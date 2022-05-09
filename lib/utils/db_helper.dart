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
  static const _itemNumber = "item_number";

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
        "CREATE TABLE $_tableName($_id INTEGER PRIMARY KEY, $_cartItem TEXT NOT NULL,$_itemNumber INTEGER)";
    await db.execute(create);
  }

  Future<void> insertIntoCart({Value? item}) async {
    Database? db = await database;

    final List<CartItem>? items = await getCartItems();

    final CartItem? cartItem = items?.firstWhere(
        (element) => (element.cartItem?.id == item?.id),
        orElse: () => CartItem());

    if (item != null) {
      String dataAsString = json.encode(item.toJson());
      if (cartItem?.cartItem == null) {
        Map<String, dynamic> data = {"cart": dataAsString, "item_number": 1};
        await db?.insert(
          _tableName,
          data,
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      } else {
        int? count = cartItem?.itemNumber;
        if (count != null) {
          count = count + 1;
          Map<String, dynamic> data = {
            "cart": dataAsString,
            "item_number": count
          };
          await db?.update(_tableName, data,
              where: "id = ?", whereArgs: [cartItem?.id]);
        }
      }
    }
  }

  Future<List<CartItem>?> getCartItems() async {
    Database? db = await database;

    final List<Map<String, dynamic>>? maps = await db?.query(_tableName);

    if (maps?.length != null || maps!.isNotEmpty) {
      return maps?.map((e) => CartItem.fromJson(e)).toList();
    } else {
      return null;
    }
  }

  Future<void> deleteFromCart({int? id}) async {
    Database? db = await database;
    await db?.rawDelete("DELETE FROM $_tableName WHERE id = $id");
  }

  Future<void> clearDatabase() async {
    Database? db = await database;
    db?.delete(_tableName);
  }
}
