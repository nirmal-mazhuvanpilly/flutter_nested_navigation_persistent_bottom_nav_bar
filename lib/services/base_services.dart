import 'package:flutter_test_application/models/home_model.dart';

abstract class BaseServices {
  Map<String,dynamic>? urlAndSchemes;
  Future<HomeModel?> getHomeData();
}
