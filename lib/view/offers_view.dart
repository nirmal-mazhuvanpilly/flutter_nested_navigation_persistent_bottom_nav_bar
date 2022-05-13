import 'package:flutter/material.dart';
import 'package:flutter_test_application/widgets/quadratic_beizer_curve_widget.dart';

class OffersView extends StatelessWidget {
  const OffersView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Offers"),
      ),
      body: const QuadraticBeizerCurveWidget(),
    );
  }
}
