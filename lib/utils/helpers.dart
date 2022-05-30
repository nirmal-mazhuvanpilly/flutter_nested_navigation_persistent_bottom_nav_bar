import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_test_application/utils/firebase_services.dart';

class Helpers {
  static Future<bool> isInternetAvailable() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  static Future<void> getDeviceInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      FirebaseServices.saveDeviceInfoToFirebase(deviceName: iosInfo.model);
    } else if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      FirebaseServices.saveDeviceInfoToFirebase(deviceName: androidInfo.model);
    }
  }

  static Future<Uint8List> dataFromBase64String(String base64String) async {
    return base64Decode(base64String);
  }

  static Future<String> base64String(Uint8List data) async {
    return base64Encode(data);
  }
}
