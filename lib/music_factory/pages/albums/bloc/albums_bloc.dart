import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:music_factory/music_factory/pages/albums/model/album_detail_model.dart';
import 'package:music_repository/repository.dart';
import 'package:network/network.dart';
import 'package:storage/storage.dart';

part 'albums_event.dart';

part 'albums_state.dart';

class AlbumsBloc extends Bloc<AlbumsEvent, AlbumsState> {
  AlbumsBloc({required this.musicService, required this.storageService})
      : super(AlbumsInitial()) {
    on<LoadTopTags>(_loadTopAlbums);
    on<LoadAlbumDetail>(_loadAlbumDetail);

    on<SaveDeleteAlbumEvent>(_saveDeleteAlbum);
  }

  final MusicService musicService;
  final StorageService storageService;

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
          albumExists: storageService.checkIfAlbumExists(albumDetail.album!),
        ));
      }
      return;
    } on NetworkException {
      log(event.albumDetailModel.mbid!);
      AlbumData? albumData = storageService.loadAlbumData(
        event.albumDetailModel.url!,
      );
      if (albumData == null) {
        return;
      }
      emit(AlbumDetailLoaded(
        albumData: albumData,
        albumExists: true,
      ));
      return;
    }
  }

  void _saveDeleteAlbum(SaveDeleteAlbumEvent event, Emit<AlbumsState> emit) {
    if (state is AlbumDetailLoaded) {
      final currentState = (state as AlbumDetailLoaded);
      bool? albumExists = storageService.checkIfAlbumExists(
        currentState.albumData,
      );

      if (albumExists) {
        storageService.deleteAlbumFromBox(currentState.albumData);

        emit(AlbumDetailLoaded(
          albumData: currentState.albumData,
          albumExists: false,
        ));
        return;
      }

      storageService.saveAlbumInBox(currentState.albumData);
      emit(AlbumDetailLoaded(
        albumData: currentState.albumData,
        albumExists: true,
      ));
      return;
    }
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
