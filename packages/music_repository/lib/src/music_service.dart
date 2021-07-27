part of 'music_repository.dart';

abstract class MusicService {

  // This function require [artist name] as a string to load related artists
  Future<Response> searchArtist(String artistName, [int index = 1]);

  // loadTopTags will load all top albums of selected artist
  Future<Response> loadTopAlbums(String artistName, [int index = 1]);

  // loadAlbumDetail will load detail of selected album.
  // it requires Album Name, Artist Name, and/or mbid
  // album name and artist name is mandatory, in case not available then fetch
  // while using mbid.
  //NOTE: mbid will be different in album detail and there is chance of empty
  // string
  Future<Response> loadAlbumDetail({String? albumName, String? artistName, String? mbid});
}