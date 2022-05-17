import 'package:flutter/material.dart';
import 'package:flutter_test_application/utils/navigator_keys.dart';
import 'package:flutter_test_application/widgets/quadratic_beizer_curve_widget.dart';

class OffersView extends StatelessWidget {
  const OffersView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Offers"),
        actions: [
          IconButton(
              onPressed: () {
                NavigatorKeysNControllers.offerNavigatorKey.currentState
                    ?.pushNamed("favorites_view");
              },
              icon: const Icon(Icons.favorite))
        ],
      ),
      body: const QuadraticBeizerCurveWidget(),
    );
  }
}
