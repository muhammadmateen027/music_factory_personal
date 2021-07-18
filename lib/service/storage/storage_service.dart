part of 'storage.dart';

abstract class StorageService {
  // Inserts a row in the database where item is album.
  // The return value is the id of the inserted row.
  Future<int> insert(Album album);

  // All of the rows are returned as a list of album.
  Future<List<Album>> queryAllRows();

  // All of the methods (insert, query, update, delete) can also be done using
  // raw SQL commands. This method uses a raw query to give the row count.
  Future<int> queryRowCount();

  // We are assuming here that the id column in the map is set. The other
  // column values will be used to update the row.
  Future<void> update(Album album);

  // Deletes the row specified by the id. The number of affected rows is
  // returned. This should be 1 as long as the row exists.
  Future<void> delete(Album album);

  Future<void> deleteAll();

  Future<Database> get db;


  Future<void> closeHiveBoxes();
}