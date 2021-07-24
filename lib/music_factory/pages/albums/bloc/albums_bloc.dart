
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:music_factory/config/config.dart';
import 'package:music_factory/model/model.dart';
import 'package:music_factory/music_factory/pages/albums/model/album_detail_model.dart';
import 'package:music_repository/repository.dart';
import 'package:network/network.dart';

part 'albums_event.dart';
part 'albums_state.dart';

class AlbumsBloc extends Bloc<AlbumsEvent, AlbumsState> {
  AlbumsBloc(this.musicService) : super(AlbumsInitial()) {
    on<LoadTopTags>(_loadTopAlbums);
    on<LoadAlbumDetail>(_loadAlbumDetail);

    on<SaveDeleteAlbumEvent>(_saveDeleteAlbum);
  }

  final MusicService musicService;

  void _loadTopAlbums(LoadTopTags event, Emit<AlbumsState> emit) async {
    try {
      if (state is TopTagsLoaded) {
        final currentState = (state as TopTagsLoaded);
        var page = (int.parse(currentState.attr!.page!) + 1);

        if (page >= int.parse(currentState.attr!.totalPages!)) {
          return;
        }

        final response = await musicService.loadTopTags(
          event.artist.name!,
          page,
        );

        var topAlbumsModel = await compute(_parseTopAlbum, response.data);

        if (topAlbumsModel.topalbums == null) {
          return;
        }

        List<Album>? list = List.of(currentState.album!)
          ..addAll(topAlbumsModel.topalbums!.album!);

        emit(TopTagsLoaded(album: list, attr: topAlbumsModel.topalbums!.attr));
        return;
      }

      final response = await musicService.loadTopTags(event.artist.name!);
      var topAlbumsModel = await compute(_parseTopAlbum, response.data);

      emit(TopTagsLoaded(
          album: topAlbumsModel.topalbums!.album,
          attr: topAlbumsModel.topalbums!.attr));
      return;
    } on NetworkException {
      return;
    }
  }

  void _loadAlbumDetail(LoadAlbumDetail event, Emit<AlbumsState> emit) async {
    emit(AlbumsLoading());
    try {
      final response = await musicService.loadAlbumDetail(
        artistName: event.albumDetailModel.artistName,
        albumName: event.albumDetailModel.albumName,
        mbid: event.albumDetailModel.mbid,
      );
      var albumDetail = await compute(_parseAlbumDetail, response.data);

      if (albumDetail.album != null) {
        emit(AlbumDetailLoaded(
          albumData: albumDetail.album!,
          albumExists: _checkIfAlbumExists(albumDetail.album!),
        ));
      }
      return;
    } on NetworkException {
      return;
    }
  }

  void _saveDeleteAlbum(SaveDeleteAlbumEvent event, Emit<AlbumsState> emit) {
    if (state is AlbumDetailLoaded) {
      final currentState = (state as AlbumDetailLoaded);
      bool? albumExists = _checkIfAlbumExists(currentState.albumData);
      

      if (albumExists) {
        _deleteAlbumFromBox(currentState.albumData);

        emit(AlbumDetailLoaded(
          albumData: currentState.albumData,
          albumExists: false,
        ));
        return;
      }

      _saveAlbumInBox(currentState.albumData);
      emit(AlbumDetailLoaded(
        albumData: currentState.albumData,
        albumExists: true,
      ));
      return;
    }
  }

  bool _checkIfAlbumExists(AlbumData albumData) {
    Box<AlbumData>? albumBox = Hive.box<AlbumData>(musicAlbumBoxName);
    String? boxKey = _getKey(albumData);


    if (albumBox.get(boxKey) == null) {
      return false;
    }
    return true;
  }

  Future<void> _saveAlbumInBox(AlbumData albumData) async {
    Box<AlbumData>? albumBox = Hive.box<AlbumData>(musicAlbumBoxName);

    String? boxKey = _getKey(albumData);

    return await albumBox.put(boxKey, albumData);
  }

  Future<void> _deleteAlbumFromBox(AlbumData albumData) async {
    Box<AlbumData>? albumBox = Hive.box<AlbumData>(musicAlbumBoxName);
    String? boxKey = _getKey(albumData);

    return await albumBox.delete(boxKey);
  }

  String _getKey(AlbumData albumData) {
    if(albumData.mbid != null) {
      return albumData.mbid!;
    }
    return albumData.url!;
  }
}

// A function that converts a response body into a TopAlbumsModel
TopAlbumsModel _parseTopAlbum(dynamic responseBody) {
  return TopAlbumsModel.fromJson(responseBody);
}

// A function that converts a response body into a TopAlbumsModel
AlbumDetail _parseAlbumDetail(dynamic responseBody) {
  return AlbumDetail.fromJson(responseBody);
}
