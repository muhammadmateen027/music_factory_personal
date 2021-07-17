import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:music_factory/model/model.dart';
import 'package:music_factory/repository/repository.dart';
import 'package:music_factory/utility/utility.dart';

part 'search_artist_event.dart';
part 'search_artist_state.dart';

class ArtistBloc extends Bloc<ArtistEvent, ArtistState> {
  ArtistBloc({required this.musicService})
      : super(SearchArtistInitial()) {
    on<SearchArtists>(_searchArtist);
    on<LoadArtists>(_loadArtist);
  }

  final MusicService musicService;

  void _searchArtist(SearchArtists event, Emit<ArtistState> emit) async {
    try {
      if (state is ArtistsLoadedState) {
        emit(SearchArtistInitial());
      }

      final response = await musicService.searchArtist(event.query);
      var artists = Artists.fromJson(response.data);

      if (artists.results!.totalResults == '0') {
        emit(SearchArtistInitial());
        return;
      }
      emit(ArtistsLoadedState(
        query: event.query,
        artists: artists.results!.artistmatches!.artist!,
        currentPage: int.parse(artists.results!.query!.startPage!),
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
        if(currentState.reachedMaximum) {
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

        Artists? artists = Artists.fromJson(response.data);
        if (artists.results == null) {
          emit(const ArtistsLoadedState(
            reachedMaximum: true,
            artists: [],
          ));
          return;
        }

        List<Artist>? list = List.of(currentState.artists!)
          ..addAll(artists.results!.artistmatches!.artist!);

        emit(ArtistsLoadedState(
          query: currentState.query!,
          artists: list,
          currentPage: (int.parse(artists.results!.query!.startPage!)),
        ));
        return;
      }

    } on NetworkException {
      emit(const SearchArtistFailure('Unable to load'));
      return;
    }
  }
}
