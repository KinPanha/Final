import 'dart:io';

import 'package:assignmentfinal/Model/users.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

String table = 'Users';
String _title = 'title';
String _note = 'note';

class DatabaseConnection {
  Future<Database> initializeUserDB() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    String path = await getDatabasesPath();
    return openDatabase(join(path, 'example.db'),
        onCreate: (db, version) async {
      await db.execute(
          'CREATE TABLE $table(id INTEGER PRIMIRY KEY,$_title TEXT NOT NULL,$_note TEXT NOT NULL)');
    }, version: 1);
  }

  Future<void> insert(Users user) async {
    final db = await initializeUserDB();
    await db.insert(table, user.toMap());
    print('funtion insert');
  }

  Future<List<Users>> get() async {
    final db = await initializeUserDB();
    List<Map<String, dynamic>> qresult = await db.query(table);
    print('lll');
    return qresult.map((e) => Users.fromMap(e)).toList();
  }

  Future<void> detele(String title) async {
    final db = await initializeUserDB();
    db.delete(table, where: 'id=?', whereArgs: [title]);
  }
}
