import 'package:flutter/material.dart';
import 'package:flutter_test_application/models/home_model.dart';
import 'package:flutter_test_application/services/base_services.dart';
import 'package:flutter_test_application/services/locators.dart';
import 'package:flutter_test_application/utils/helpers.dart';

class HomeProvider extends ChangeNotifier {
  final apiServices = getIt<BaseServices>();

  HomeModel? _homeModel;

  HomeModel? get homeModel => _homeModel;

  set homeModel(HomeModel? model) {
    _homeModel = model;
    notifyListeners();
  }

  bool isInternetAvailable = true;

  Future<void> getHomeData() async {
    if (await Helpers.isInternetAvailable()) {
      Future.delayed(const Duration(seconds: 2)).then((value) async {
        homeModel = await apiServices.getHomeData();
        isInternetAvailable = true;
        notifyListeners();
      });
    } else {
      isInternetAvailable = false;
    }
  }
}
