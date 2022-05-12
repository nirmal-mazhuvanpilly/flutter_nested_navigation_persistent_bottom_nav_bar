import 'package:flutter/material.dart';

class OfferNavigator extends StatelessWidget {
  const OfferNavigator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Offers"),
      ),
      body: const Center(
        child: Text("Offers"),
      ),
    );
  }
}
