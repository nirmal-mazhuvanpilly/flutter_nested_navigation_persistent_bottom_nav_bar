import 'package:flutter/cupertino.dart';
import 'package:flutter_test_application/models/home_model.dart';
import 'package:flutter_test_application/services/locators.dart';
import 'package:flutter_test_application/utils/db_helper.dart';

class CartProvider extends ChangeNotifier {
  final db = getIt<DbHelper>();

  List<Value>? _cartItems;

  List<Value>? get cartItems => _cartItems;

  set cartItems(List<Value>? items) {
    _cartItems = items;
    notifyListeners();
  }

  Future<void> addItemToCart({Value? item}) async {
    await db.insertIntoCart(item: item);
    await getcartItems();
    notifyListeners();
  }

  Future<void> getcartItems() async {
    cartItems = await db.getCartItems();
    notifyListeners();
  }

  Future<void> deleteFromCart({int? id}) async {
    await db.deleteFromCart(id: id);
    await getcartItems();
    notifyListeners();
  }

  Future<void> clearCart() async {
    await db.clearDatabase();
    await getcartItems();
    notifyListeners();
  }
}
