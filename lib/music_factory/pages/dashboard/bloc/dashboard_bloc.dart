import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:music_factory/config/config.dart';
import 'package:music_factory/model/model.dart';
import 'package:music_factory/repository/repository.dart';
import 'package:music_factory/service/service.dart';

part 'dashboard_event.dart';

part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc({required this.musicService}) : super(DashboardInitial()) {
    on<LoadAlbums>(_loadAlbums);
    on<LoadAlbumDetail>(_albumDetail);

    on<SaveAlbum>(_saveAlbum);
  }

  final MusicService musicService;

  void _loadAlbums(LoadAlbums event, Emit<DashboardState> emit) async {
    emit(DashboardLoading());

    _fetchAlbums();
  }

  void _albumDetail(LoadAlbumDetail event, Emit<DashboardState> emit) async {
    emit(AlbumDetailLoaded(album: event.album));
  }

  void _saveAlbum(SaveAlbum event, Emit<DashboardState> emit) async {
    Album newAlbum = event.album;

    if (newAlbum.image!.isNotEmpty) {
      if (newAlbum.image!.length != 0) {
        var decoded = base64.decode(newAlbum.image![0].text!);
        log(decoded.toString());

        String str = '';
        Image image = Image(
          text: decoded.toString(),
          size: newAlbum.image![0].size!,
        );


        newAlbum.image![0] = image;
      }

      log('--------newAlbum images empty');
      return;
    } else {
      log('--------newAlbum images not empty');
    }
    int? result = await locator<StorageService>().insert(newAlbum);
    _fetchAlbums();
  }

  void _fetchAlbums() async {
    List<Album>? albums = await locator<StorageService>().queryAllRows();

    if (albums.isEmpty) {
      return;
    }

    emit(AlbumLoaded(albums: albums));
  }

  @override
  Future<void> close() async {
    await locator<StorageService>().closeHiveBoxes();
    return super.close();
  }
}
