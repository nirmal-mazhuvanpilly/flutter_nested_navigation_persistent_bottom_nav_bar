import 'package:flutter/material.dart';
import 'package:flutter_test_application/constants/text_style_constants.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 2),
      (() {
        Navigator.of(context).pushReplacementNamed("cupertino_main_page");
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            stops: const [0.2, 0.6, 1],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.green.shade800,
              Colors.green,
              Colors.green.shade900
            ],
          ),
        ),
        child: const Center(
          child: Text(
            "MACHINE TEST",
            style: TextStyleConsts.bold30White,
          ),
        ),
      ),
    );
  }
}
