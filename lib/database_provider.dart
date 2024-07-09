import 'package:crud/todo_modal.dart';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

class DatabaseProvider {
  static Database? database;
  var dataBaseName = "todoDatabase.db";
  DatabaseProvider() {
    createDatabase();
  }
  createDatabase() async {
    if (database == null) {
      if (kIsWeb) {
        var databaseFactory = databaseFactoryFfiWeb;
        database = await databaseFactory.openDatabase(
          dataBaseName,
          options: OpenDatabaseOptions(
            version: 1,
            onCreate: (db, version) async {
              db.execute(
                  "CREATE TABLE todo (id INTERGER PRIMARY KEY AUTOINCREMENT , title TEXT, description TEXT)");
            },
          ),
        );
      } else {
        var path = join(await getDatabasesPath(), dataBaseName);
        database =
            await openDatabase(path, version: 1, onCreate: (db, version) {
          db.execute(
              "CREATE TABLE todo (id INTEGER PRIMARY KEY AUTOINCREMENT , title TEXT, description TEXT)");
        });
      }
    }
  }

  void insertTodo(TodoModal todoModal) {
    if (database != null) {
      database?.insert("todo", todoModal.toJson());
    }
  }
}
