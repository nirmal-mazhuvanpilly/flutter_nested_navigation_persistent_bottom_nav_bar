import 'package:flutter/cupertino.dart';
import 'package:flutter_test_application/models/home_model.dart';
import 'package:flutter_test_application/services/locators.dart';
import 'package:flutter_test_application/utils/db_helper.dart';

class CartProvider extends ChangeNotifier {
  final db = getIt<DbHelper>();

  List<CartItem>? _cartItems;

  List<CartItem>? get cartItems => _cartItems;

  set cartItems(List<CartItem>? items) {
    _cartItems = items;
    notifyListeners();
  }

  late int totalItem;

  Future<void> addOrRemoveFromCart(
      {Value? item, int? count, bool? fromHome}) async {
    await db.addOrRemoveFromCart(item: item, count: count, fromHome: fromHome);
    await getcartItems();
    notifyListeners();
  }

  Future<void> getcartItems() async {
    cartItems = await db.getCartItems();
    totalItem = 0;
    cartItems?.forEach(
      (element) {
        totalItem = totalItem + element.itemNumber!.toInt();
        element.itemNumber;
      },
    );
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
