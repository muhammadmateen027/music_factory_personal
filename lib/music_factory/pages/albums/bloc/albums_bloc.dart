import 'package:bloc/bloc.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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
    // Load top album event
    on<LoadTopAlbums>(_loadTopAlbums);

    // Load album detail
    on<LoadAlbumDetail>(_loadAlbumDetail);

    // Save album in the hive storage
    on<SaveDeleteAlbumEvent>(_saveDeleteAlbum);
  }

  final MusicService musicService;
  final StorageService storageService;

  void _loadTopAlbums(LoadTopAlbums event, Emit<AlbumsState> emit) async {
    try {
      // check if the current state is Top Tags loaded then load rest of the
      // tags
      if (state is AlbumsFetched) {
        // cast state as TopTagsLoaded to access variables
        final currentState = (state as AlbumsFetched);
        var page = (int.parse(currentState.attr!.page!) + 1);

        // if page is equal or greater than total page then return otherwise
        // load next page
        if (page >= int.parse(currentState.attr!.totalPages!)) {
          return;
        }

        final response = await musicService.loadTopAlbums(
          event.artist.name!,
          page,
        );

        var topAlbumsModel = await compute(_parseTopAlbum, response.data);

        if (topAlbumsModel.topalbums == null) {
          return;
        }

        // add new albums in the previous list
        List<Album>? list = List.of(currentState.album!)
          ..addAll(topAlbumsModel.topalbums!.album!);

        emit(AlbumsFetched(album: list, attr: topAlbumsModel.topalbums!.attr));
        return;
      }

      final response = await musicService.loadTopAlbums(event.artist.name!);
      var topAlbumsModel = await compute(_parseTopAlbum, response.data);

      emit(
        AlbumsFetched(
          album: topAlbumsModel.topalbums!.album,
          attr: topAlbumsModel.topalbums!.attr,
        ),
      );
      return;
    } on NetworkException catch (err) {
      BotToast.showText(text: err.getDetail(), contentColor: Colors.red);
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
    } on NetworkException catch (err) {
      //If network is not available then load data from the detail page
      var albumData = storageService.loadAlbumData(
        event.albumDetailModel.url!,
      );
      // if albums are not available, return
      if (albumData == null) {
        BotToast.showText(text: err.getDetail(), contentColor: Colors.red);
        return;
      }

      emit(AlbumDetailLoaded(
        albumData: albumData,
        albumExists: true,
      ));
      return;
    }
  }

  // check if album already exists then delete otherwise save
  void _saveDeleteAlbum(SaveDeleteAlbumEvent event, Emit<AlbumsState> emit) {
    // check current state
    if (state is AlbumDetailLoaded) {
      // cast state as AlbumDetailLoaded to access variables
      final currentState = (state as AlbumDetailLoaded);
      // check either albums exists or not
      bool? albumExists = storageService.checkIfAlbumExists(
        currentState.albumData,
      );

      if (albumExists) {
        // if exists, delete and update album detail status
        storageService.deleteAlbumFromBox(currentState.albumData);

        emit(AlbumDetailLoaded(
          albumData: currentState.albumData,
          albumExists: false,
        ));
        return;
      }

      // if album not exists in storage, save the album and update button
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

// A function that converts a response body into a AlbumDetail
AlbumDetail _parseAlbumDetail(dynamic responseBody) {
  return AlbumDetail.fromJson(responseBody);
}
