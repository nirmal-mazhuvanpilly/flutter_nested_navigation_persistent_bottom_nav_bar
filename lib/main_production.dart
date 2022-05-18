import 'package:flutter/material.dart';
import 'package:flutter_test_application/my_app.dart';

import 'package:flutter_test_application/services/locators.dart';

void main() async {
  await setUpLocator(staging: false);
  runApp(const MyApp());
}