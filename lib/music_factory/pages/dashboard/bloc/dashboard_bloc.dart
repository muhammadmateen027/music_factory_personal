import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:music_factory/music_factory/music_factory.dart';
import 'package:music_repository/model/model.dart';
import 'package:storage/storage.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc({required this.albumsBloc, required this.service})
      : super(DashboardInitial()) {
    albumsBlocSubscription = albumsBloc.stream.listen((albumState) async{
      if (albumState is AlbumDetailLoaded) {
        List<AlbumData>? albums = await service.loadAlbums();
        emit(AlbumsLoaded(albums: albums));
      }
    });

    on<LoadAlbums>(_loadTopAlbums);
  }

  final AlbumsBloc albumsBloc;
  final StorageService service;
  late final StreamSubscription albumsBlocSubscription;

  void _loadTopAlbums(LoadAlbums event, Emit<DashboardState> emit) async {
    List<AlbumData>? albums = await service.loadAlbums();

    if (albums.isEmpty) {
      emit(DashboardInitial());
      return;
    }

    emit(AlbumsLoaded(albums: albums));
  }

  @override
  Future<void> close() {
    albumsBlocSubscription.cancel();
    return super.close();
  }
}
