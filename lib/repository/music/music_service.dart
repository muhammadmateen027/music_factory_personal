part of 'music_repository.dart';

abstract class MusicService {
  Future<Response> loadArtists(String artist);

  Future<Response> searchArtist(String artistName, [int index = 1]);
}