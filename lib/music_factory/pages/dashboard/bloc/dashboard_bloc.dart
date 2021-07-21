import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:music_factory/model/model.dart';
import 'package:music_factory/repository/repository.dart';
import 'package:music_factory/service/service.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc({required this.musicService}) : super(DashboardInitial()) {
    // Initialize database

    on<LoadAlbums>(_loadAlbums);
    on<TruncateTable>(_deleteDatabase);
    on<LoadButtonState>(_albumDetail);

    on<SaveAlbum>(_saveAlbum);
    on<DeleteItem>(_deleteAlbum);
  }

  final _dbHelper = Storage.instance;
  final MusicService musicService;

  void _loadAlbums(LoadAlbums event, Emit<DashboardState> emit) async {
    emit(DashboardLoading());
    _fetchAlbums();
  }

  void _deleteDatabase(TruncateTable event, Emit<DashboardState> emit) async {
    emit(DashboardLoading());
    await _dbHelper.deleteTable();
    _fetchAlbums();
  }

  void _albumDetail(LoadButtonState event, Emit<DashboardState> emit) async {

    if (await _dbHelper.isExists(event.album)) {
      emit(AlbumExistState());
      return;
    }
    emit(AlbumNotExistState());
  }

  void _deleteAlbum(DeleteItem event, Emit<DashboardState> emit) async {
    await _dbHelper.delete(event.album);
    _fetchAlbums();
    emit(AlbumNotExistState());
  }

  void _saveAlbum(SaveAlbum event, Emit<DashboardState> emit) async {

    await _dbHelper.insert(event.album);

    _fetchAlbums();

    emit(AlbumExistState());
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