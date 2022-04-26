import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_test_application/models/home_model.dart';
import 'package:flutter_test_application/services/base_services.dart';
import 'package:flutter_test_application/services/app_data.dart';
import 'package:http/http.dart' as http;

class ApiServices implements BaseServices {
  @override
  Future<HomeModel?> getHomeData() async {
    try {
      final response = await http.get(Uri.parse(AppData.baseUrl));
      if (response.statusCode == 200) {
        return HomeModel.fromJson(jsonDecode(response.body));
      } else {
        throw Exception("Failed to load home data");
      }
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }
}
