import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:music_repository/repository.dart';

part 'storage_service.dart';

class Storage implements StorageService {
  @override
  bool checkIfAlbumExists(AlbumData albumData) {
    Box<AlbumData>? albumBox = Hive.box<AlbumData>(albumBoxName);
    String? boxKey = _getKey(albumData);

    if (albumBox.get(boxKey) == null) {
      return false;
    }
    return true;
  }

  @override
  Future<void> deleteAlbumFromBox(AlbumData albumData) async {
    Box<AlbumData>? albumBox = Hive.box<AlbumData>(albumBoxName);
    String? boxKey = _getKey(albumData);
    return await albumBox.delete(boxKey);
  }

  @override
  AlbumData? loadAlbumData(String key) {
    Box<AlbumData>? albumBox = Hive.box<AlbumData>(albumBoxName);
    return albumBox.get(key);
  }

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

  Future<List<AlbumData>> loadAlbums() async {
    Box<AlbumData>? albumBox = Hive.box<AlbumData>(albumBoxName);
    var albums = <AlbumData>[];

    if (albumBox.values.isEmpty) {
      return albums;
    }

    albums = await compute(_loadAlbums, albumBox);

    return albums;
  }
}

Future<List<AlbumData>> _loadAlbums(Box<AlbumData> albumBox) async {
  var albums = <AlbumData>[];

  for (int index = 0; index < albumBox.values.length; index++) {
    AlbumData? albumData = albumBox.getAt(index);
    albums.add(albumData!);
  }

  return albums;
}
