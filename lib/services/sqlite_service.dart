import 'dart:async';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;
import 'package:tracker_payment/models/input_model.dart';

abstract class DB {
  static Database? _db;
  static int get _version => 1;

  static Future<void> init() async {
    if (_db != null) {
      return;
    }
    try {
      var databasePath = await getDatabasesPath();
      String _path = path.join(databasePath, 'money_crud.db');
      _db = await openDatabase(_path, version: _version, onCreate: onCreate);
    } catch (e) {
      print(e);
    }
  }

  static onCreate(Database db, int version) {
    return db.execute('CREATE TABLE input(id INTEGER PRIMARY KEY AUTOINCREMENT, type TEXT, amount REAL, category TEXT, description TEXT, date TEXT, time TEXT)');
  }

  static Future<List<InputModel>> inputModelList() async {
    List<Map<String, dynamic>> inputList = await _db!.query('input');
    return inputList.map((item) => InputModel.fromMap(item)).toList();
  }

  static Future<int> insert(InputModel model) async {
    return await _db!.insert('input', model.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> update(InputModel model) async {
    return await _db!.update('input', model.toMap(), where: 'id = ?', whereArgs: [model.id]);
  }

  static Future<int> delete(int id) async {
    return await _db!.delete('input', where: 'id = ?', whereArgs: [id]);
  }

  static Future<int> deleteAll() async {
    return await _db!.delete('input');
  }
}
