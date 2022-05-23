import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_application/my_app.dart';

import 'package:flutter_test_application/services/locators.dart';

//copy google-services.json to debug,release,profile folders under each build flavor

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await setUpLocator(staging: false);
  runApp(const MyApp());
}