import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test_application/utils/helpers.dart';
import 'package:flutter_test_application/widgets/constant_widgets.dart';
import 'package:pedometer/pedometer.dart';
import 'package:permission_handler/permission_handler.dart';

class PedoMeterView extends StatefulWidget {
  const PedoMeterView({Key? key}) : super(key: key);

  @override
  State<PedoMeterView> createState() => _PedoMeterViewState();
}

class _PedoMeterViewState extends State<PedoMeterView> {
  late Stream<StepCount>? stepCountStream;
  late Stream<PedestrianStatus>? pedestrianStatusStream;

  late StreamSubscription<StepCount>? stepCountStreamSubscription;
  late StreamSubscription<PedestrianStatus>? pedestrianStatusStreamSubscription;

  String? status;
  late int initialCount;
  int? stepCount;

  ValueNotifier<bool> isPaused = ValueNotifier<bool>(true);

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void onStepCount(StepCount event) {
    setState(() {
      stepCount = event.steps - initialCount;
    });
  }

  void onPedestrianStatusChanged(PedestrianStatus event) {
    setState(() {
      status = event.status;
    });
  }

  void onPedestrianStatusError(Object error) {
    setState(() {
      status = 'Not available';
      stepCount = 0;
    });
    Helpers.showToast(toastMessage: "Pedometer not available on this device");
  }

  void onStepCountError(Object error) {
    setState(() {
      status = 'Not available';
      stepCount = 0;
    });
    Helpers.showToast(toastMessage: "Pedometer not available on this device");
  }

  void initPlatformState() async {
    if (await Permission.activityRecognition.request().isGranted) {
      pedestrianStatusStream = Pedometer.pedestrianStatusStream;
      pedestrianStatusStreamSubscription = pedestrianStatusStream?.listen(
        onPedestrianStatusChanged,
        onError: onPedestrianStatusError,
      );

      stepCountStream = Pedometer.stepCountStream;
      stepCountStreamSubscription = stepCountStream?.listen(
        onStepCount,
        onError: onStepCountError,
      );
      stepCountStream?.first.then((value) {
        initialCount = value.steps;
      });
    }
    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pedometer"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            (stepCount == null)
                ? ConstantWidgets.emptyBox
                : RichText(
                    text: TextSpan(children: [
                    const TextSpan(
                        text: "Steps taken : ",
                        style: TextStyle(color: Colors.green, fontSize: 20)),
                    TextSpan(
                        text: stepCount.toString(),
                        style: const TextStyle(
                            color: Colors.green,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                  ])),
            RichText(
                text: TextSpan(children: [
              const TextSpan(
                  text: "Status : ",
                  style: TextStyle(color: Colors.green, fontSize: 20)),
              TextSpan(
                  text: status,
                  style: const TextStyle(
                      color: Colors.green,
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
            ])),
            ValueListenableBuilder<bool>(
                valueListenable: isPaused,
                builder: (context, value, child) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      value
                          ? ConstantWidgets.emptyBox
                          : IconButton(
                              color: Colors.green,
                              onPressed: () {
                                if (stepCountStreamSubscription?.isPaused ??
                                    false) {
                                  stepCountStreamSubscription?.resume();
                                }
                                isPaused.value = !isPaused.value;
                              },
                              icon: const Icon(Icons.play_arrow),
                            ),
                      value
                          ? IconButton(
                              color: Colors.green,
                              onPressed: () {
                                if (!(stepCountStreamSubscription?.isPaused ??
                                    false)) {
                                  stepCountStreamSubscription?.pause();
                                }
                                isPaused.value = !isPaused.value;
                              },
                              icon: const Icon(Icons.pause),
                            )
                          : ConstantWidgets.emptyBox,
                    ],
                  );
                }),
          ],
        ),
      ),
    );
  }
}
