part of 'music_repository.dart';

abstract class MusicService {
  Future<Response> loadAlbums(String artist);

  Future<Response> searchArtist(String artistName);
}