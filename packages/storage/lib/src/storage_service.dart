part of 'storage.dart';

/// This name will be used to initialize the box and to get the value from
/// respective box
const String albumBoxName = 'music-album';

/// This class will be used to communicate inside the bloc with storage
abstract class StorageService {

  /// Pass the AlbumData and check either exists in the Hive or not
  bool checkIfAlbumExists(AlbumData albumData);

  /// Save album in the Hive box
  Future<void> saveAlbumInBox(AlbumData albumData);

  /// Function will be used to delete item from the box if exists
  Future<void> deleteAlbumFromBox(AlbumData albumData);

  /// When we require to load Album detail of specific album,
  /// pass the Key to this function and get detail if exists
  AlbumData? loadAlbumData(String key);

  /// Load all available albums from the hive. It'll gives the list of AlbumData
  /// and can be accessed inside bloc
  Future<List<AlbumData>> loadAlbums();
}