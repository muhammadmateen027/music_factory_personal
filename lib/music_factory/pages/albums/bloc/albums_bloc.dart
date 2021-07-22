import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:music_factory/model/model.dart';
import 'package:music_repository/repository.dart';
import 'package:network/network.dart';

part 'albums_event.dart';

part 'albums_state.dart';

class AlbumsBloc extends Bloc<AlbumsEvent, AlbumsState> {
  AlbumsBloc(this.musicService) : super(AlbumsInitial()) {
    on<LoadTopTags>(_loadTopAlbums);
    on<LoadAlbumDetail>(_loadAlbumDetail);
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
    try {
      final response = await musicService.loadAlbumDetail(
        event.album.name!,
        event.album.artist!.name!,
      );
      var albumDetail = await compute(_parseAlbumDetail, response.data);

      if (albumDetail.album != null) {
        emit(AlbumDetailLoaded(albumData: albumDetail.album!));
      }
      return;
    } on NetworkException {
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
