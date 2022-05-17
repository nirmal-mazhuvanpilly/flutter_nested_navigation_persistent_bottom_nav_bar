import 'dart:convert';

import 'package:flutter_test_application/models/home_model.dart';

class CartItem {
  int? id;
  int? itemNumber;
  Value? cartItem;

  CartItem({this.id, this.cartItem, this.itemNumber});

  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
      id: json["id"],
      cartItem: Value.fromJson(jsonDecode(json["cart"])),
      itemNumber: json["item_number"]);
}
