import 'dart:convert';

import 'package:flutter_test_application/models/home_model.dart';

class FavoriteItem {
  int? id;
  Value? value;

  FavoriteItem({
    this.id,
    this.value,
  });

  factory FavoriteItem.fromJson(Map<String, dynamic> json) => FavoriteItem(
        id: json["id"],
        value: Value.fromJson(jsonDecode(json["favorite_item"])),
      );
}
