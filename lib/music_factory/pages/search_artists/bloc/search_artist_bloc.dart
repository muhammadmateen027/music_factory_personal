import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:music_repository/repository.dart';
import 'package:network/network.dart';

part 'search_artist_event.dart';

part 'search_artist_state.dart';

class ArtistBloc extends Bloc<ArtistEvent, ArtistState> {
  ArtistBloc({required this.musicService}) : super(SearchArtistInitial()) {
    on<SearchArtists>(_searchArtist);
    on<LoadArtists>(_loadArtist);
  }

  final MusicService musicService;

  void _searchArtist(SearchArtists event, Emit<ArtistState> emit) async {
    if (event.query.isEmpty) {
      emit(SearchArtistInitial());
      return;
    }

    try {
      if (state is ArtistsLoadedState) {
        emit(SearchArtistInitial());
      }

      final response = await musicService.searchArtist(event.query);
      var artists = Artists.fromJson(response.data);

      if (artists.results!.openSearchTotalResults == '0') {
        emit(SearchArtistInitial());
        return;
      }
      emit(ArtistsLoadedState(
        query: event.query,
        artists: artists.results!.artistMatches!.artist!,
        currentPage: int.parse(artists.results!.openSearchQuery!.startPage!),
      ));
      return;
    } on NetworkException {
      emit(const SearchArtistFailure('Unable to load'));
      return;
    }
  }

  void _loadArtist(LoadArtists event, Emit<ArtistState> emit) async {
    try {
      if (state is ArtistsLoadedState) {
        var currentState = (state as ArtistsLoadedState);
        if (currentState.reachedMaximum) {
          emit(ArtistsListEnds());
          return;
        }

        if (currentState.query!.isEmpty) {
          emit(const ArtistsLoadedState(reachedMaximum: true, artists: []));
          return;
        }

        final response = await musicService.searchArtist(
          currentState.query!,
          (currentState.currentPage! + 1),
        );

        var artists = await compute(_parseArtist, response.data);
        if (artists.results == null) {
          emit(const ArtistsLoadedState(
            reachedMaximum: true,
            artists: [],
          ));
          return;
        }

        List<Artist>? list = List.of(currentState.artists!)
          ..addAll(artists.results!.artistMatches!.artist!);

        emit(ArtistsLoadedState(
          query: currentState.query!,
          artists: list,
          currentPage:
              (int.parse(artists.results!.openSearchQuery!.startPage!)),
        ));
        return;
      }
    } on NetworkException {
      emit(const SearchArtistFailure('Unable to load'));
      return;
    }
  }
}

// A function that converts a response body into a TopAlbumsModel
Artists _parseArtist(dynamic responseBody) {
  return Artists.fromJson(responseBody);
}
