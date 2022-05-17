import 'dart:convert';
import 'dart:io';

import 'package:flutter_test_application/models/cart_model.dart';
import 'package:flutter_test_application/models/favorite_model.dart';
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

  static const _favoriteTable = "favorites";
  static const _favoriteItem = "favorite_item";

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

    const createFavorite =
        "CREATE TABLE $_favoriteTable($_id INTEGER PRIMARY KEY,$_favoriteItem TEXT NOT NULL)";

    await db.execute(create);
    await db.execute(createFavorite);
  }

  Future<void> addOrRemoveFromCart({
    Value? item,
    int? count,
    bool? fromHome,
  }) async {
    Database? db = await database;

    final List<CartItem>? items = await getCartItems();

    final CartItem? cartItem = items?.firstWhere(
        (element) => (element.cartItem?.id == item?.id),
        orElse: () => CartItem());

    String dataAsString = json.encode(item?.toJson());
    if (cartItem?.cartItem == null) {
      Map<String, dynamic> data = {"cart": dataAsString, "item_number": count};
      await db?.insert(
        _tableName,
        data,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } else {
      if (fromHome ?? false) {
        int? _count = cartItem?.itemNumber;
        if (count != null && _count != null) {
          _count = _count + count;
          await updateCartItem(count: _count, id: cartItem?.id);
        }
      } else {
        await updateCartItem(count: count, id: cartItem?.id);
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

  Future<void> updateCartItem({int? count, int? id}) async {
    Database? db = await database;

    db?.rawUpdate(
        "UPDATE $_tableName SET $_itemNumber = $count WHERE $_id = $id");
  }

  Future<void> deleteFromCart({int? id}) async {
    Database? db = await database;
    await db?.rawDelete("DELETE FROM $_tableName WHERE id = $id");
  }

  Future<void> clearDatabase() async {
    Database? db = await database;
    db?.delete(_tableName);
  }

  Future<void> addToFavorites({Value? item}) async {
    Database? db = await database;

    String dataAsString = json.encode(item?.toJson());

    Map<String, dynamic> data = {_favoriteItem: dataAsString};
    await db?.insert(
      _favoriteTable,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<FavoriteItem>?> getFavoriteItems() async {
    Database? db = await database;

    final List<Map<String, dynamic>>? maps = await db?.query(_favoriteTable);

    if (maps?.length != null) {
      return maps?.map((e) => FavoriteItem.fromJson(e)).toList();
    } else {
      return null;
    }
  }

  Future<void> deleteFromFavorites({int? id}) async {
    Database? db = await database;
    await db?.rawDelete("DELETE FROM $_favoriteTable WHERE id = $id");
  }

  Future<void> clearFavorites() async {
    Database? db = await database;
    db?.delete(_favoriteTable);
  }
}
