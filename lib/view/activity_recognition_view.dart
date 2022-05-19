import 'package:flutter/material.dart';
import 'package:flutter_test_application/providers/actvity_tracker_provider.dart';
import 'package:flutter_test_application/widgets/activity_icon_widget.dart';
import 'package:provider/provider.dart';

class ActivityRecognitionView extends StatefulWidget {
  const ActivityRecognitionView({Key? key}) : super(key: key);

  @override
  State<ActivityRecognitionView> createState() =>
      _ActivityRecognitionViewState();
}

class _ActivityRecognitionViewState extends State<ActivityRecognitionView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ActivityRecognition"),
      ),
      body: Center(
        child: Consumer<ActivityTrackerProvider>(
          builder: (context, value, child) {
            return ListView.builder(
                itemCount: value.events.length,
                reverse: true,
                itemBuilder: (context, int index) {
                  final activity = value.events[index];
                  return ListTile(
                    leading: ActivityIconWidget(
                      type: activity.type,
                    ),
                    title: Text(
                        '${activity.type.toString().split('.').last} (${activity.confidence}%)'),
                    trailing: Text(activity.timeStamp
                        .toString()
                        .split(' ')
                        .last
                        .split('.')
                        .first),
                  );
                });
          },
        ),
      ),
    );
  }
}
