import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

class AccelerometerView extends StatefulWidget {
  const AccelerometerView({Key? key}) : super(key: key);

  @override
  State<AccelerometerView> createState() => _AccelerometerViewState();
}

class _AccelerometerViewState extends State<AccelerometerView> {
  double? x = 0;
  double? y = 0;
  double? z = 0;

  late Stream<AccelerometerEvent> accelerometer;
  late StreamSubscription<AccelerometerEvent> accelerometerSubscription;

  @override
  void initState() {
    super.initState();
    accelerometer = Sensors().accelerometerEvents;
    accelerometerSubscription = accelerometer.listen((event) {
      if (mounted) {
        setState(() {
          x = event.x;
          y = event.y;
          z = event.z;
        });
      }
    }, onError: (Object error) {
      debugPrint(error.toString());
    });
  }

  @override
  void dispose() {
    accelerometerSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Accelerometer"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("X : " + x.toString()),
            Text("Y : " + y.toString()),
            Text("Z : " + z.toString()),
          ],
        ),
      ),
    );
  }
}
