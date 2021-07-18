import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
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
    on<TruncateTable>(_deleteDatabase);
    on<LoadButtonState>(_albumDetail);

    on<SaveAlbum>(_saveAlbum);
    on<DeleteItem>(_deleteAlbum);
  }

  final MusicService musicService;

  void _loadAlbums(LoadAlbums event, Emit<DashboardState> emit) async {
    emit(DashboardLoading());
    _fetchAlbums();
  }

  void _deleteDatabase(TruncateTable event, Emit<DashboardState> emit) async {
    emit(DashboardLoading());
    await _dbHelper.deleteAll();
    _fetchAlbums();
  }

  void _albumDetail(LoadButtonState event, Emit<DashboardState> emit) async {

    if (await _dbHelper.isExists(event.album)) {
      log('Item exists');
      emit(AlbumExistState());
      return;
    }
    log('Item Not exists');
    emit(AlbumNotExistState());
  }

  void _deleteAlbum(DeleteItem event, Emit<DashboardState> emit) async {

    log('--------------------');
    await _dbHelper.delete(event.album);
    emit(AlbumNotExistState());
  }

  void _saveAlbum(SaveAlbum event, Emit<DashboardState> emit) async {
    Album? newAlbum = event.album;

    if (await _dbHelper.isExists(event.album)) {
      log('Item exists');
      return;
    }
    log('Item Not exists');
    newAlbum = await compute(_setImageData, newAlbum);
    await _dbHelper.insert(newAlbum);

    _fetchAlbums();

    emit(AlbumExistState());
  }

  Future<File> getImageFromNetwork(String url) async {
    File file = await DefaultCacheManager().getSingleFile(url);
    return file;
  }

  void _fetchAlbums() async {
    print('------------');

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

Future<Album> _setImageData(Album newAlbum) async{
  List<Image>? images = [];
  if (newAlbum.images!.isNotEmpty) {
    if (newAlbum.images![0].text!.isNotEmpty) {
      var imagetext = newAlbum.images![0].text!;
      if(newAlbum.images![0].text!.runtimeType == String) {
        String? imageUrl = newAlbum.images![0].text! as String;

        final imageData =
        await NetworkAssetBundle(Uri.parse(imageUrl)).load('');
        final bytes = imageData.buffer.asUint8List();

        imagetext = bytes;
      }

      final image = Image(
        text: imagetext,
        size: newAlbum.images![0].size!,
      );

      images.add(image);
      newAlbum.images = images;
    }
  }

  return newAlbum;
}