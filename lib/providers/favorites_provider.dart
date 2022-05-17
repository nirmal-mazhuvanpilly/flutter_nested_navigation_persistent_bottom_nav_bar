import 'package:flutter/cupertino.dart';
import 'package:flutter_test_application/models/favorite_model.dart';
import 'package:flutter_test_application/models/home_model.dart';
import 'package:flutter_test_application/services/locators.dart';
import 'package:flutter_test_application/utils/db_helper.dart';

class FavoritesProvider extends ChangeNotifier {
  final db = getIt<DbHelper>();

  List<FavoriteItem>? _favoriteItems;

  List<FavoriteItem>? get favoriteItems => _favoriteItems;

  set favoriteItems(List<FavoriteItem>? items) {
    _favoriteItems = items;
    notifyListeners();
  }

  Future<void> addItemToFavorite({Value? item}) async {
    await db.addToFavorites(item: item);
    await getFavoriteItems();
  }

  Future<void> getFavoriteItems() async {
    _favoriteItems = await db.getFavoriteItems();
    notifyListeners();
  }

  Future<void> clearFromFavorites({int? id}) async {
    await db.deleteFromFavorites(id: id);
    await getFavoriteItems();
  }

  Future<void> clearFavorites() async {
    await db.clearFavorites();
    await getFavoriteItems();
  }
}
