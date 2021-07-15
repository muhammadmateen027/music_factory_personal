
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:music_factory/model/model.dart';
import 'package:music_factory/repository/repository.dart';
import 'package:music_factory/utility/utility.dart';

part 'search_artist_event.dart';
part 'search_artist_state.dart';

class SearchArtistBloc extends Bloc<SearchArtistEvent, SearchArtistState> {
  SearchArtistBloc({required this.musicService})
      : super(SearchArtistInitial()) {
    on<SearchArtists>(_loadAlbums);
  }

  final MusicService musicService;

  void _loadAlbums(SearchArtists event, Emit<SearchArtistState> emit) async {
    emit(ArtistsLoading());
    try {
      var response = await musicService.loadArtists('believe');

      Artists artists = Artists.fromJson(response.data);

      emit(ArtistsLoaded(artists.results!.artistmatches!.artist!));
    } on NetworkException {
      return;
    }
  }
}
