import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/foundation.dart';

class FirebaseServices {
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
}
