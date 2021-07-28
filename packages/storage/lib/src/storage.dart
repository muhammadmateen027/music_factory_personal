
import 'package:hive/hive.dart';
import 'package:music_repository/repository.dart';

part 'storage_service.dart';

/// This class will implement the function of StorageService. We will try to
/// hide function methods and access will be available from StorageService class
class Storage implements StorageService {
  /// Pass the AlbumData and check either exists in the Hive or not
  @override
  bool checkIfAlbumExists(AlbumData albumData) {
    Box<AlbumData>? albumBox = Hive.box<AlbumData>(albumBoxName);
    String? boxKey = _getKey(albumData);

    if (albumBox.get(boxKey) == null) {
      return false;
    }
    return true;
  }

  /// Function will be used to delete item from the box if exists
  @override
  Future<void> deleteAlbumFromBox(AlbumData albumData) async {
    Box<AlbumData>? albumBox = Hive.box<AlbumData>(albumBoxName);
    String? boxKey = _getKey(albumData);
    return await albumBox.delete(boxKey);
  }

  /// When we require to load Album detail of specific album,
  /// pass the Key to this function and get detail if exists
  @override
  AlbumData? loadAlbumData(String key) {
    Box<AlbumData>? albumBox = Hive.box<AlbumData>(albumBoxName);
    return albumBox.get(key);
  }

  /// Save album in the Hive box
  @override
  Future<void> saveAlbumInBox(AlbumData albumData) async {
    Box<AlbumData>? albumBox = Hive.box<AlbumData>(albumBoxName);

    String? boxKey = _getKey(albumData);

    return await albumBox.put(boxKey, albumData);
  }

  String _getKey(AlbumData albumData) {
    if (albumData.url == null) {
      return '${albumData.name}--${albumData.artistName}';
    }
    return albumData.url!;
  }

  /// Load all available albums from the hive. It'll gives the list of AlbumData
  /// and can be accessed inside bloc
  Future<List<AlbumData>> loadAlbums() async {
    Box<AlbumData>? albumBox = Hive.box<AlbumData>(albumBoxName);
    var albums = <AlbumData>[];

    if (albumBox.values.isEmpty) {
      return albums;
    }

    for(AlbumData? albumData in albumBox.values) {
      albums.add(albumData!);
    }

    return albums;
  }
}
