import 'package:flutter/material.dart';
import 'package:flutter_test_application/models/home_model.dart';
import 'package:flutter_test_application/services/base_services.dart';
import 'package:flutter_test_application/test_data/test_data.dart';

class TestServices implements BaseServices {
  @override
  Future<HomeModel?> getHomeData() async {
    try {
      return HomeModel.fromJson(HomeTestData.homeTestData);
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }
}
