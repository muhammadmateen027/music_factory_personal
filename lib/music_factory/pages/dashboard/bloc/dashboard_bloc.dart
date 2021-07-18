import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:music_factory/model/model.dart';
import 'package:music_factory/repository/repository.dart';
import 'package:music_factory/service/service.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

final _dbHelper = Storage.instance;

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc({required this.musicService}) : super(DashboardInitial()) {
    // Initialize database

    on<LoadAlbums>(_loadAlbums);
    on<DeleteAlbums>(_deleteAlbums);
    on<LoadAlbumDetail>(_albumDetail);

    on<SaveAlbum>(_saveAlbum);
  }

  final MusicService musicService;

  void _loadAlbums(LoadAlbums event, Emit<DashboardState> emit) async {
    emit(DashboardLoading());
    _fetchAlbums();
  }

  void _deleteAlbums(DeleteAlbums event, Emit<DashboardState> emit) async {
    emit(DashboardLoading());
    await _dbHelper.deleteAll();
    _fetchAlbums();
  }

  void _albumDetail(LoadAlbumDetail event, Emit<DashboardState> emit) async {
    emit(AlbumDetailLoaded(album: event.album));
  }

  void _saveAlbum(SaveAlbum event, Emit<DashboardState> emit) async {
    Album? newAlbum = event.album;

    if (await _dbHelper.isExists(event.album)) {
      log('Item exists');
      return;
    }

    if (newAlbum.images!.isNotEmpty) {
      List<Image>? images = [];
      if (newAlbum.images![0].text!.isNotEmpty) {
        String? imageUrl = newAlbum.images![0].text! as String;

        final imageData =
            await NetworkAssetBundle(Uri.parse(imageUrl)).load('');
        final bytes = imageData.buffer.asUint8List();
        final image = Image(
          text: bytes,
          size: newAlbum.images![0].size!,
        );

        images.add(image);
        newAlbum.images = images;
      }

      await _dbHelper.insert(newAlbum);
    }

    _fetchAlbums();
  }

  Future<File> getImageFromNetwork(String url) async {
    File file = await DefaultCacheManager().getSingleFile(url);
    return file;
  }

  void _fetchAlbums() async {
    var albums = await _dbHelper.queryAllRows();
    if (albums.isEmpty) {
      emit(EmptyAlbums());
      return;
    }

    emit(AlbumLoaded(albums: await _dbHelper.queryAllRows()));
  }

  @override
  Future<void> close() async {
    return super.close();
  }
}
