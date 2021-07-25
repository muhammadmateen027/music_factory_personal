part of 'storage.dart';

// This name will be used to inititalize the box and
const String albumBoxName = 'music-album';

abstract class StorageService {

  bool checkIfAlbumExists(AlbumData albumData);

  Future<void> saveAlbumInBox(AlbumData albumData);

  Future<void> deleteAlbumFromBox(AlbumData albumData);

  AlbumData? loadAlbumData(String key);

  Future<List<AlbumData>> loadAlbums();
}