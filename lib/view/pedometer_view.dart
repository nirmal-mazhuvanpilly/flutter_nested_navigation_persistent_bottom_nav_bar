import 'package:flutter/material.dart';
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

  String? status;
  late int initialCount;
  int? stepCount;

  bool? isSupport;

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
  }

  void onStepCountError(Object error) {
    setState(() {
      isSupport = false;
      status = 'Not available';
      stepCount = 0;
    });
  }

  void initPlatformState() async {
    if (await Permission.activityRecognition.request().isGranted) {
      pedestrianStatusStream = Pedometer.pedestrianStatusStream;
      pedestrianStatusStream
          ?.listen(onPedestrianStatusChanged)
          .onError(onPedestrianStatusError);

      stepCountStream = Pedometer.stepCountStream;
      stepCountStream?.first.then((value) {
        initialCount = value.steps;
      });
      stepCountStream
          ?.listen(
            onStepCount,
          )
          .onError(onStepCountError);
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
            RichText(
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
          ],
        ),
      ),
    );
  }
}
