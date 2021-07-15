import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:music_factory/model/model.dart';
import 'package:music_factory/repository/repository.dart';
import 'package:music_factory/utility/utility.dart';

part 'search_artist_event.dart';
part 'search_artist_state.dart';

class SearchArtistBloc extends Bloc<SearchArtistEvent, SearchArtistState> {
  SearchArtistBloc({required this.musicService})
      : super(const SearchArtistState()) {
    on<SearchArtists>(_searchArtist);
  }

  final MusicService musicService;

  void _searchArtist(
      SearchArtists event, Emit<SearchArtistState> emit) async {
    if (state.hasReachedMax)  emit(state);
    try {
      if (state.status == SearchArtistStatus.initial) {
        final response = await musicService.searchArtist(event.query);

        Artists artists = Artists.fromJson(response.data);
        emit(state.copyWith(
          status: SearchArtistStatus.success,
          artists: artists.results!.artistmatches!.artist!,
          hasReachedMax: false,
          currentPage: int.parse(artists.results!.query!.startPage!),
          totalResult: int.parse(artists.results!.totalResults!),
        ));
      }

      final response = await musicService.searchArtist(
        event.query,
        (state.currentPage + 1),
      );
      var artists = Artists.fromJson(response.data);

      artists.results!.artistmatches!.artist!.isEmpty
          ? emit(state.copyWith(hasReachedMax: true))
          : emit(state.copyWith(
        status: SearchArtistStatus.success,
        artists: List.of(state.artists)
          ..addAll(artists.results!.artistmatches!.artist!),
        hasReachedMax: false,
        currentPage: int.parse(artists.results!.query!.startPage!),
        totalResult: int.parse(artists.results!.totalResults!),
      ));
      return;
    } on NetworkException {
      emit(state.copyWith(status: SearchArtistStatus.failure));
      return;
    }
  }
}
