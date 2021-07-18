import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:music_factory/model/model.dart';

part 'storage_service.dart';

class Storage implements StorageService {
  @override
  void registerAlbumAdapter() {

    return;
  }

  @override
  Future<void> delete(Album album) async {
    // TODO: implement queryRowCount
    throw UnimplementedError();
  }

  // Inserts a row in the database where each key in the Map is a column name
  // and the value is the column value. The return value is the id of the
  // inserted row.

  @override
  Future<int> insert(Album album) async {
    // TODO: implement queryRowCount
    throw UnimplementedError();
  }

  @override
  Future<List<Album>> queryAllRows() async {
    // TODO: implement queryRowCount
    throw UnimplementedError();
  }

  @override
  Future<int> queryRowCount() {
    // TODO: implement queryRowCount
    throw UnimplementedError();
  }

  @override
  Future<void> update(Album album) async {
    // TODO: implement queryRowCount
    throw UnimplementedError();
  }

  @override
  Future<void> closeHiveBoxes() {
    // TODO: implement queryRowCount
    throw UnimplementedError();
  }

  @override
  Future<void> deleteAll() async{
    // TODO: implement queryRowCount
    throw UnimplementedError();
  }
}
