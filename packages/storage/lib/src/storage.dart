
import 'package:flutter/foundation.dart';
import 'package:music_factory/model/model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

// Database name
const String DB_NAME = 'apps_factory.db';

//Table name
const String TABLE = 'music_album';

// Columns
const String ID = '_id';
const String ALBUM_NAME = 'album_name';
const String PLAY_COUNT = 'playcount';
const String ALBUM_URL = 'album_url';
const String ARTIST_NAME = 'artist_name';
const String ARTIST_URL = 'artist_url';

const String IMAGE_ONE = 'image_one';
const String IMAGE_TWO = 'image_two';
const String IMAGE_THREE = 'image_three';
const String IMAGE_FOUR = 'image_four';

const String IMAGE_SMALL = 'small_image';
const String IMAGE_MEDIUM = 'image_medium';
const String IMAGE_LARGE = 'image_large';
const String IMAGE__EXTRA_LARGE = 'image_extra_large';

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
        '$IMAGE_ONE TEXT, '
        '$IMAGE_SMALL TEXT,'
        '$IMAGE_TWO TEXT, '
        '$IMAGE_MEDIUM TEXT,'
        '$IMAGE_THREE TEXT, '
        '$IMAGE_LARGE TEXT,'
        '$IMAGE_FOUR TEXT, '
        '$IMAGE__EXTRA_LARGE TEXT )');
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

    // AS MAP and List isn't supported in SQFLite https://github.com/tekartik/sqflite/blob/master/sqflite/doc/supported_types.md#supported-types
    // We need to split and store each item one by one in a  column

    var mapData = await compute(_getTableData, album);

    return await dbClient.insert(
      TABLE,
      mapData,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    // return 1;
  }

  Future<List<Album>> queryAllRows() async {
    var dbClient = await db;
    List<Album> albums = List<Album>.empty(growable: true);

    // specify the column names you want in the result set
    List<Map<String, dynamic>> queryResult =
        await dbClient.rawQuery('SELECT * FROM $TABLE');

    if (queryResult.isEmpty) {
      return albums;
    }

    albums = await compute(_albumsFromResult, queryResult);

    return albums;
  }

  Future<bool> isExists(Album album) async {
    var dbClient = await db;

    List<Map<String, dynamic>> queryResult = await dbClient.query(
      TABLE,
      columns: [ALBUM_NAME],
      where: '$ALBUM_NAME = ?',
      whereArgs: [album.name],
    );

    if (queryResult.isEmpty) {
      return false;
    }
    return true;
  }

  Future<void> deleteAlbum(Album album) async {
    var dbClient = await db;
    await dbClient.delete(
      TABLE,
      where: '$ALBUM_NAME = ?',
      whereArgs: [album.name],
    );
    return;
  }

  Future<void> closeDatabase() async {
    var dbClient = await db;
    return dbClient.close();
  }

  Future<void> deleteTable() async {
    var dbClient = await db;
    await dbClient.delete(TABLE);
    return;
  }
}

Future<List<Album>> _albumsFromResult(List<Map<String, Object?>> result) async {
  List<Album>? albums = [];
  for (var index = 0; index < result.length; index++) {
    Map<String, dynamic> map = result[index];

    var artistDetail = ArtistDetail(
      name: map[ARTIST_NAME],
      url: map[ARTIST_URL],
    );

    List<Image> images = [];
    images.add(Image(text: map[IMAGE_ONE], size: map[IMAGE_SMALL]));
    images.add(Image(text: map[IMAGE_TWO], size: map[IMAGE_MEDIUM]));
    images.add(Image(text: map[IMAGE_THREE], size: map[IMAGE_LARGE]));
    images.add(Image(text: map[IMAGE_FOUR], size: map[IMAGE__EXTRA_LARGE]));

    var album = Album(
      name: map[ALBUM_NAME],
      url: map[ALBUM_URL],
      playcount: map[PLAY_COUNT],
      artist: artistDetail,
      image: images,
    );

    albums.add(album);
  }

  return albums;
}

Map<String, dynamic> _getTableData(Album album) {
  var tableData = {
    ALBUM_NAME: album.name,
    PLAY_COUNT: album.playcount,
    ALBUM_URL: album.url,
    ARTIST_NAME: album.artist!.name,
    ARTIST_URL: album.artist!.url,
    IMAGE_ONE: null,
    IMAGE_TWO: null,
    IMAGE_THREE: null,
    IMAGE_FOUR: null,
    IMAGE_SMALL: null,
    IMAGE_MEDIUM: null,
    IMAGE_LARGE: null,
    IMAGE__EXTRA_LARGE: null
  };

  if (album.image != null) {
    if (album.image![0].text != '') {
      tableData[IMAGE_ONE] = album.image![0].text;
      tableData[IMAGE_SMALL] = album.image![0].size;
    }

    if (album.image![1].text != '') {
      tableData[IMAGE_TWO] = album.image![1].text;
      tableData[IMAGE_MEDIUM] = album.image![1].size;
    }

    if (album.image![2].text != '') {
      tableData[IMAGE_THREE] = album.image![2].text;
      tableData[IMAGE_LARGE] = album.image![2].size;
    }

    if (album.image![3].text != '') {
      tableData[IMAGE_FOUR] = album.image![3].text;
      tableData[IMAGE__EXTRA_LARGE] = album.image![3].size;
    }
  }

  return tableData;
}
