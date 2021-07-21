import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:music_factory/model/model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

part 'storage_service.dart';

// Database name
const String DB_NAME = 'music.albums.db';

//Table name
const String TABLE = 'albums';

// Columns
const String ID = '_id';
const String ALBUM_NAME = 'album_name';
const String PLAY_COUNT = 'playcount';
const String ALBUM_URL = 'album_url';
const String ARTIST_NAME = 'artist_name';
const String ARTIST_URL = 'artist_url';
const String ALBUM_IMAGE = 'album_image';
const String ALBUM_IMAGE_SIZE = 'album_image_size';

class Storage {
  // make this a singleton class
  Storage._privateConstructor();

  static final Storage instance = Storage._privateConstructor();

  // only have a single app-wide reference to the database
  static late Database _db;

  Future<Database> get database async {
    if (_db != null) return _db;
    // lazily instantiate the db the first time it is accessed
    _db = await initDb();
    return _db;
  }

// only have a single app-wide reference to the database

  // Initialize the Database
  Future<Database> get db async {
    _db = await initDb();
    return _db;
  }

  Future<Database> initDb() async {
    // Get the Device's Documents directory to store the Offline Database...
    var documentsDirectory = await getApplicationDocumentsDirectory();
    var path = join(documentsDirectory.path, DB_NAME);
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    // Create the DB Table
    await db.execute('CREATE TABLE $TABLE '
        '( $ID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, '
        '$ALBUM_NAME TEXT, '
        '$PLAY_COUNT INTEGER, '
        '$ALBUM_URL TEXT, '
        '$ARTIST_NAME TEXT, '
        '$ARTIST_URL TEXT, '
        '$ALBUM_IMAGE BLOB, '
        '$ALBUM_IMAGE_SIZE TEXT)');
  }

  Future<void> delete(Album album) async {
    var dbClient = await db;
    await dbClient
        .delete(TABLE, where: '$ALBUM_NAME = ?', whereArgs: [album.name]);
    return;
  }

  // Inserts a row in the database where each key in the Map is a column name
  // and the value is the column value. The return value is the id of the
  // inserted row.

  Future<int> insert(Album album) async {
    var dbClient = await db;
    // this will insert the Album object to the DB after converting it to a json
    var albumImage;
    if (album.image![0].text!.isNotEmpty) {
      albumImage = album.image![0].text! as Uint8List;
    }

    var mapData = {
      ALBUM_NAME: album.name,
      PLAY_COUNT: album.playcount,
      ALBUM_URL: album.url,
      ARTIST_NAME: album.artist!.name,
      ARTIST_URL: album.artist!.url,
      ALBUM_IMAGE: albumImage,
      ALBUM_IMAGE_SIZE: album.image![0].size
    };
    return await dbClient.insert(
      TABLE,
      mapData,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    // return 1;
  }

  Future<List<Album>> queryAllRows() async {
    var dbClient = await db;
    List<Album> albums = [];

    // specify the column names you want in the result set
    List<Map<String, dynamic>> result = await dbClient.query(
      TABLE,
      columns: [
        ALBUM_NAME,
        PLAY_COUNT,
        ALBUM_URL,
        ARTIST_NAME,
        ARTIST_URL,
        ALBUM_IMAGE,
        ALBUM_IMAGE_SIZE,
      ],
    );

    if (result.isEmpty) {
      return albums;
    }

    albums = await compute(_loadListOfImages, result);

    return albums;
  }

  Future<int> queryRowCount() {
    // TODO: implement queryRowCount
    throw UnimplementedError();
  }

  Future<bool> isExists(Album album) async {
    var dbClient = await db;

    List<Map<String, dynamic>> queryResult = await dbClient.query(
      TABLE,
      columns: [ALBUM_NAME, ARTIST_NAME],
      where: "$ALBUM_NAME = ?",
      whereArgs: [album.name],
    );

    if (queryResult.isEmpty) {
      return false;
    }
    return true;
  }

  Future<void> deleteAlbum(Album album) async {
    var dbClient = await db;
    await dbClient
        .delete(TABLE, where: '$ALBUM_NAME = ?', whereArgs: [album.name]);
    return;
  }

  Future<void> update(Album album) async {
    var dbClient = await db;
    await dbClient
        .delete(TABLE, where: '$ALBUM_NAME = ?', whereArgs: [album.name]);
  }

  Future<void> closeHiveBoxes() async {
    var dbClient = await db;
    return dbClient.close();
  }

  Future<void> deleteAll() async {
    var dbClient = await db;
    await dbClient.delete(TABLE);
    return;
  }
}

Future<List<Album>> _loadListOfImages(List<Map<String, Object?>> result) async {
  List<Album>? albums = [];
  for (var index = 0; index < result.length; index++) {
    List<Image>? images = [];
    Map map = result[index];

    if (result[index][ALBUM_IMAGE] != null) {
      final image = Image(
        text: map[ALBUM_IMAGE],
        size: map[ALBUM_IMAGE_SIZE],
      );
      images.add(image);
    }

    final artistDetail = ArtistDetail(
      name: map[ARTIST_NAME],
      url: map[ARTIST_URL],
    );

    var album = Album(
      name: map[ALBUM_NAME]!,
      playcount: map[PLAY_COUNT],
      url: map[ALBUM_URL],
      artist: artistDetail,
      image: images,
    );

    albums.add(album);
  }

  return albums;
}
