import 'package:flutter_test_application/models/home_model.dart';

abstract class BaseServices {
  Future<HomeModel?> getHomeData();
}
