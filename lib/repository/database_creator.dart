import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Database db;

class DatabaseCreator {
  static const userTable = 'userTable';
  static const id = 'id';
  static const name = 'name';
  static const email = 'email';
  static const password = 'password';

  static const todoTable = 'todoTable';
  static const todoId = 'id';
  static const userId = 'userId';
  static const todoTitle = 'todoTitle';
  static const todoDescription = 'todoDescription';

  static void databaseLog(String functionName, String sql,
      [List<Map<String, dynamic>> selectQueryResult,
      int insertAndUpdateQueryResult,
      List<dynamic> params]) {
    print(functionName);
    print(sql);
    if (params != null) {
      print(params);
    }
    if (selectQueryResult != null) {
      print(selectQueryResult);
    } else if (insertAndUpdateQueryResult != null) {
      print(insertAndUpdateQueryResult);
    }
  }

  Future<void> createUserTable(Database db) async {
    final userSql = '''CREATE TABLE $userTable
    (
      $id INTEGER PRIMARY KEY,
      $name TEXT,
      $email TEXT,
      $password TEXT
    )''';
    final todoSql = '''CREATE TABLE $todoTable
    (
      $todoId INTEGER PRIMARY KEY,
      $userId INTEGER,
      $todoTitle TEXT,
      $todoDescription TEXT
    )''';

    await db.execute(todoSql);
    await db.execute(userSql);
  }

  Future<String> getDatabasePath(String dbName) async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, dbName);

    //make sure the folder exists
    if (await Directory(dirname(path)).exists()) {
      //await deleteDatabase(path);
    } else {
      await Directory(dirname(path)).create(recursive: true);
    }
    return path;
  }

  Future<void> initDatabase() async {
    final path = await getDatabasePath('todo_db');
    db = await openDatabase(path, version: 1, onCreate: onCreate);
    print(db);
  }

  Future<void> onCreate(Database db, int version) async {
    await createUserTable(db);
  }
}
