import 'dart:convert';
import 'dart:io';

import 'package:flutter_test_application/models/home_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  static const _databaseName = "cart.db";
  static const _databaseVersion = 1;

  static const _tableName = "cart";

  static const _id = "id";
  static const _cartItem = "cart";

  Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    const create =
        "CREATE TABLE $_tableName($_id INTEGER PRIMARY KEY, $_cartItem TEXT NOT NULL)";
    await db.execute(create);
  }

  Future<void> insertIntoCart({Value? item}) async {
    Database? db = await database;

    if (item != null) {
      String dataAsString = json.encode(item.toJson());
      Map<String, dynamic> data = {"cart": dataAsString};
      await db?.insert(
        _tableName,
        data,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  Future<List<Value>?> getCartItems() async {
    Database? db = await database;

    final List<Map<String, dynamic>>? maps = await db?.query(_tableName);

    if (maps?.length != null || maps!.isNotEmpty) {
      return maps?.map((e) => Value.fromJson(json.decode(e["cart"]))).toList();
    } else {
      return null;
    }
  }

  Future<void> deleteFromCart({int? id}) async {
    Database? db = await database;
    await db?.rawDelete("DELETE FROM $_tableName WHERE id = ${id! + 1}");
  }

  Future<void> clearDatabase() async {
    Database? db = await database;
    db?.delete(_tableName);
  }
}
