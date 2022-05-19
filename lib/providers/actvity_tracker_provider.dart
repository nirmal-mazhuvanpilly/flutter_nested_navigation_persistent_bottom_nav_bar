import 'dart:async';
import 'dart:io';

import 'package:activity_recognition_flutter/activity_recognition_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:permission_handler/permission_handler.dart';

class ActivityTrackerProvider extends ChangeNotifier {
  StreamSubscription<ActivityEvent>? activityStreamSubscription;

  final List<ActivityEvent> events = [];

  ActivityRecognition activityRecognition = ActivityRecognition();

  void init() async {
    if (Platform.isAndroid) {
      if (await Permission.activityRecognition.request().isGranted) {
        _startTracking();
      }
    } else {
      _startTracking();
    }
  }

  void _startTracking() {
    activityStreamSubscription = activityRecognition
        .activityStream(runForegroundService: true)
        .listen(onData, onError: onError);
  }

  void onData(ActivityEvent activityEvent) {
    debugPrint(activityEvent.toString());
    events.add(activityEvent);
    notifyListeners();
  }

  void onError(Object error) {
    debugPrint("Error $error");
  }
}
