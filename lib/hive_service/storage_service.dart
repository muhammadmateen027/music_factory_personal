part of 'app_storage.dart';

abstract class StorageService {

  bool checkIfAlbumExists(AlbumData albumData);

  Future<void> saveAlbumInBox(AlbumData albumData);

  Future<void> deleteAlbumFromBox(AlbumData albumData);

  AlbumData? loadAlbumData(String key);

  Future<void> registerAdapters();
}