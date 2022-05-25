import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_application/services/base_services.dart';
import 'package:flutter_test_application/services/locators.dart';
import 'package:overlay_support/overlay_support.dart';

class FirebaseServices {
  static final apiServices = getIt<BaseServices>();

  //Terminated State
  static Future<void> getInitialDynamicLinkData() async {
    final PendingDynamicLinkData? initialLink =
        await FirebaseDynamicLinks.instance.getInitialLink();
    if (initialLink != null) {
      final Uri deepLink = initialLink.link;
      debugPrint(deepLink.queryParameters.toString());
    }
  }

  static Future<void> getForegroundDynamicLinkData() async {
    FirebaseDynamicLinks.instance.onLink.listen((dynamicLinkData) {
      final PendingDynamicLinkData? initialLink = dynamicLinkData;
      if (initialLink != null) {
        final Uri deepLink = initialLink.link;
        debugPrint(deepLink.queryParameters.toString());
      }
    }).onError((error) {});
  }

  static Future<Uri?> createDynamicLink({String? id, String? name}) async {
    final String hostUrl = apiServices.urlAndSchemes?["hostUrl"];
    final String packageName = apiServices.urlAndSchemes?["packageName"];

    final dynamicLinkParams = DynamicLinkParameters(
        link: Uri.parse("http://www.google.com/?id=$id&name=$name"),
        uriPrefix: hostUrl,
        androidParameters: AndroidParameters(packageName: packageName),
        socialMetaTagParameters: SocialMetaTagParameters(title: name));

    final unguessableDynamicLink =
        await FirebaseDynamicLinks.instance.buildShortLink(
      dynamicLinkParams,
      shortLinkType: ShortDynamicLinkType.unguessable,
    );

    debugPrint(unguessableDynamicLink.shortUrl.toString());

    return unguessableDynamicLink.shortUrl;
  }

  static Future<void> saveDeviceInfoToFirebase({String? deviceName}) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    QuerySnapshot querySnapshot = await users.get();

    // Get data from docs and convert map to List
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();

    if (deviceName != null) {
      if (!allData.any((element) {
        Map<String, dynamic> data = element as Map<String, dynamic>;
        return data["device"] == deviceName;
      })) {
        users.add({"device": deviceName});
      }
    }
  }

  //Push notifications in Background & Terminated State
  static Future<void> notificationOnBackgroundMessage(
      Future<void> Function(RemoteMessage) remoteMessage) async {
    FirebaseMessaging.onBackgroundMessage(remoteMessage);
  }

  //Push notifications in Background state (Not terminated).
  static Future<void> notificationOnMessageOpenedApp() async {
    await Firebase.initializeApp();
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage? remoteMessage) {
      debugPrint('A new onMessageOpenedApp event was published!');
      if (remoteMessage != null) {
        debugPrint(remoteMessage.data.toString());
      }
    });
  }

  //Push notifications in Foreground state.
  static Future<void> notificationOnMessage() async {
    await Firebase.initializeApp();
    final token = await FirebaseMessaging.instance
        .getToken(); //Call this method before onMessage, Otherwise it wont listen foreground messages
    debugPrint(token);
    FirebaseMessaging.onMessage.listen((RemoteMessage? remoteMessage) {
      debugPrint('A new onMessage event was published!');
      if (remoteMessage != null) {
        debugPrint(remoteMessage.data.toString());
        showSimpleNotification(Text(remoteMessage.data.toString()),
            background: Colors.grey.shade900);
      }
    });
  }
}
