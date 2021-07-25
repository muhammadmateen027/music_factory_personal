
import 'package:bloc/bloc.dart';
import 'package:music_repository/repository.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc({required this.musicService}) : super(DashboardInitial()) {
    // Initialize database
    on<LoadAlbums>(_loadAlbums);
    on<TruncateTable>(_deleteItems);
  }

  final MusicService musicService;
  // ValueListenable<Box<AlbumData>>? albumsListener =
  // Hive.box<AlbumData>(musicAlbumBoxName).listenable();

  void _loadAlbums(LoadAlbums event, Emit<DashboardState> emit) async {
    emit(DashboardLoading());
    _fetchAlbums();
  }


  Future<void> _deleteItems(event, emit) async {
    // Box<AlbumData>? albumBox = Hive.box<AlbumData>(musicAlbumBoxName);
    // return albumBox.deleteFromDisk();
  }

  Iterable<AlbumData> _fetchAlbums() {
    var albums = <AlbumData>[];
    // Box<AlbumData>? box = Hive.box<AlbumData>(musicAlbumBoxName);
    //
    // if (albumsListener!.value.isEmpty) {
    //   return albums;
    // }
    //
    // for (int index=0; index < albumsListener!.value.length; index++) {
    //   AlbumData? albumData = box.get(index);
    //   if (albumData != null) {
    //     albums.add(albumData);
    //   }
    //
    // }
    return albums;
  }

  @override
  Future<void> close() async {
    return super.close();
  }
}
