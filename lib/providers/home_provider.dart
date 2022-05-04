import 'package:flutter/material.dart';
import 'package:flutter_test_application/models/home_model.dart';
import 'package:flutter_test_application/services/base_services.dart';
import 'package:flutter_test_application/services/locators.dart';

class HomeProvider extends ChangeNotifier {
  final apiServices = getIt<BaseServices>();

  HomeModel? _homeModel;

  HomeModel? get homeModel => _homeModel;

  set homeModel(HomeModel? model) {
    _homeModel = model;
    notifyListeners();
  }

  Future<void> getHomeData() async {
    homeModel = await apiServices.getHomeData();
    notifyListeners();
  }
}
