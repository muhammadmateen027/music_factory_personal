import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:music_factory/model/model.dart';
import 'package:music_factory/repository/repository.dart';
import 'package:music_factory/utility/utility.dart';

part 'albums_event.dart';
part 'albums_state.dart';

class AlbumsBloc extends Bloc<AlbumsEvent, AlbumsState> {
  AlbumsBloc(this.musicService) : super(AlbumsInitial()) {
    on<LoadTopTags>(_loadTopAlbums);
  }

  final MusicService musicService;

  void _loadTopAlbums(LoadTopTags event, Emit<AlbumsState> emit) async {
    try {
      final response = await musicService.loadTopTags(event.artist.name!);
      TopAlbumsModel? topAlbumsModel = TopAlbumsModel.fromJson(response.data);

      emit(TopTagsLoaded(topAlbumsModel: topAlbumsModel));
      return;
    } on NetworkException {
      return;
    }
  }
}
