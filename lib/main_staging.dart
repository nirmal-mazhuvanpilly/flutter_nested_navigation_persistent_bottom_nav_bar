import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_application/my_app.dart';

import 'package:flutter_test_application/services/locators.dart';
import 'package:flutter_test_application/utils/firebase_services.dart';

//copy google-services.json to debug,release,profile folders under each build flavor

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage? message) async {
  await Firebase.initializeApp();
  debugPrint('A new background event was published!');
  if (message != null) {
    debugPrint(message.data.toString());
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseServices.notificationOnBackgroundMessage(
      _firebaseMessagingBackgroundHandler);
  await setUpLocator(staging: true);
  runApp(const MyApp());
}