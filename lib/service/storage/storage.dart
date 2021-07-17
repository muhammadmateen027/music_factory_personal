import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive/hive.dart';
import 'package:music_factory/model/model.dart';

part 'storage_service.dart';

class Storage implements StorageService {
  @override
  void registerAlbumAdapter() {
    Hive.registerAdapter(AlbumAdapter());
    Hive.registerAdapter(ArtistDetailAdapter());
    Hive.registerAdapter(ImageAdapter());
    return;
  }

  @override
  Future<void> delete(Album album) async {
    final contactsBox = await Hive.openBox(dotenv.env['ALBUMS']!);
    return await contactsBox.delete(album);
  }

  // Inserts a row in the database where each key in the Map is a column name
  // and the value is the column value. The return value is the id of the
  // inserted row.

  @override
  Future<int> insert(Album album) async {
    log('------>>>> 123');
    final contactsBox = await Hive.openBox(dotenv.env['ALBUMS']!);
    log('---->>>>   1234567');
    await contactsBox.add(album);
    return 1;
  }

  @override
  Future<List<Album>> queryAllRows() async {
    List<Album> albums = List<Album>.empty(growable: true);
    final contactsBox = await Hive.openBox(dotenv.env['ALBUMS']!);

    log(contactsBox.length.toString());
    for (int index = 0; index < contactsBox.length; index++) {
      albums.add(contactsBox.get(index) as Album);
    }

    return albums;
  }

  @override
  Future<int> queryRowCount() {
    // TODO: implement queryRowCount
    throw UnimplementedError();
  }

  @override
  Future<void> update(Album album) async {
    final contactsBox = await Hive.openBox(dotenv.env['ALBUMS']!);
    return await contactsBox.put(album, album);
  }

  @override
  Future<void> closeHiveBoxes() {
    return Hive.close();
  }

  @override
  Future<void> deleteAll() async{
    final contactsBox = await Hive.openBox(dotenv.env['ALBUMS']!);
    await contactsBox.deleteFromDisk();
  }
}
