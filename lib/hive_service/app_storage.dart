import 'package:hive/hive.dart';
import 'package:music_factory/model/model.dart';

part 'storage_service.dart';

const String musicAlbumBoxName = 'music-album';

class AppStorage implements StorageService {
  @override
  bool checkIfAlbumExists(AlbumData albumData) {
    Box<AlbumData>? albumBox = Hive.box<AlbumData>(musicAlbumBoxName);
    String? boxKey = _getKey(albumData);

    if (albumBox.get(boxKey) == null) {
      return false;
    }
    return true;
  }

  @override
  Future<void> deleteAlbumFromBox(AlbumData albumData) async {
    Box<AlbumData>? albumBox = Hive.box<AlbumData>(musicAlbumBoxName);
    String? boxKey = _getKey(albumData);
    return await albumBox.delete(boxKey);
  }

  @override
  AlbumData? loadAlbumData(String key) {
    Box<AlbumData>? albumBox = Hive.box<AlbumData>(musicAlbumBoxName);
    return albumBox.get(key);
  }

  @override
  Future<void> saveAlbumInBox(AlbumData albumData) async {
    Box<AlbumData>? albumBox = Hive.box<AlbumData>(musicAlbumBoxName);

    String? boxKey = _getKey(albumData);

    return await albumBox.put(boxKey, albumData);
  }

  String _getKey(AlbumData albumData) {
    if (albumData.url == null) {
      return '${albumData.name}--${albumData.artistName}';
    }
    return albumData.url!;
  }

  @override
  Future<void> registerAdapters() async {
    Hive
      ..registerAdapter<AlbumData>(AlbumDataAdapter())
      ..registerAdapter<Wiki>(WikiAdapter())
      ..registerAdapter<Tracks>(TracksAdapter())
      ..registerAdapter<Track>(TrackAdapter())
      ..registerAdapter<Tags>(TagsAdapter())
      ..registerAdapter<Tag>(TagAdapter())
      ..registerAdapter<ArtistDetail>(ArtistDetailAdapter())
      ..registerAdapter<Streamable>(StreamableAdapter())
      ..registerAdapter<Image>(ImageAdapter());
  }
}
