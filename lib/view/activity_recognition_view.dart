import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:activity_recognition_flutter/activity_recognition_flutter.dart';

class ActivityRecognitionView extends StatefulWidget {
  const ActivityRecognitionView({Key? key}) : super(key: key);

  @override
  State<ActivityRecognitionView> createState() =>
      _ActivityRecognitionViewState();
}

class _ActivityRecognitionViewState extends State<ActivityRecognitionView> {
  StreamSubscription<ActivityEvent>? activityStreamSubscription;

  final List<ActivityEvent> _events = [];

  ActivityRecognition activityRecognition = ActivityRecognition();

  @override
  void initState() {
    super.initState();
    _init();
    _events.add(ActivityEvent.unknown());
  }

  @override
  void dispose() {
    activityStreamSubscription?.cancel();
    super.dispose();
  }

  void _init() async {
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
    setState(() {
      _events.add(activityEvent);
    });
  }

  void onError(Object error) {
    debugPrint("Error $error");
  }

  Icon _activityIcon(ActivityType type) {
    switch (type) {
      case ActivityType.WALKING:
        return const Icon(Icons.directions_walk);
      case ActivityType.IN_VEHICLE:
        return const Icon(Icons.car_rental);
      case ActivityType.ON_BICYCLE:
        return const Icon(Icons.pedal_bike);
      case ActivityType.ON_FOOT:
        return const Icon(Icons.directions_walk);
      case ActivityType.RUNNING:
        return const Icon(Icons.run_circle);
      case ActivityType.STILL:
        return const Icon(Icons.cancel_outlined);
      case ActivityType.TILTING:
        return const Icon(Icons.redo);
      default:
        return const Icon(Icons.device_unknown);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ActivityRecognition"),
      ),
      body: Center(
        child: ListView.builder(
            itemCount: _events.length,
            reverse: true,
            itemBuilder: (_, int idx) {
              final activity = _events[idx];
              return ListTile(
                leading: _activityIcon(activity.type),
                title: Text(
                    '${activity.type.toString().split('.').last} (${activity.confidence}%)'),
                trailing: Text(activity.timeStamp
                    .toString()
                    .split(' ')
                    .last
                    .split('.')
                    .first),
              );
            }),
      ),
    );
  }
}
