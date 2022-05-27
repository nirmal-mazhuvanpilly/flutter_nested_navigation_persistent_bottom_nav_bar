import 'dart:ui';

import 'package:flutter/material.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> with SingleTickerProviderStateMixin {
  late Animation<double> fontAnimation;

  late Animation<double> imageAnimation;

  late Animation<double> blurAnimation;

  late AnimationController controller;

  late Animation<double> opacityAnimation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 800), vsync: this);

    opacityAnimation = Tween<double>(begin: 1.0, end: .50).animate(
        CurvedAnimation(parent: controller, curve: Curves.easeInQuint));
    imageAnimation = Tween<double>(begin: 1.0, end: 2.0).animate(
        CurvedAnimation(parent: controller, curve: Curves.easeInQuint));
    fontAnimation = Tween<double>(begin: 1.0, end: 4.0).animate(
        CurvedAnimation(parent: controller, curve: Curves.easeInQuint));
    blurAnimation = Tween<double>(begin: 0.0, end: 5.0).animate(
        CurvedAnimation(parent: controller, curve: Curves.easeInQuint));

    Future.delayed((const Duration(seconds: 1)), () {
      controller.forward();
    });
    controller.addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed) {
        Navigator.of(context).pushReplacementNamed("cupertino_main_page");
      }
    });
    //   controller.addStatusListener((AnimationStatus status) {
    //     if (status == AnimationStatus.completed) {
    //       controller.reverse();
    //     } else if (status == AnimationStatus.dismissed) {
    //       controller.forward();
    //     }
    //   });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
          animation: controller,
          builder: (context, child) {
            return Opacity(
              opacity: opacityAnimation.value,
              child: Transform.scale(
                scale: imageAnimation.value,
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      color: Colors.black,
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage("assets/images/splash.jpg"))),
                  child: Transform.scale(
                    scale: fontAnimation.value,
                    child: ImageFiltered(
                      imageFilter: ImageFilter.blur(
                          sigmaX: blurAnimation.value,
                          sigmaY: blurAnimation.value),
                      child: const Center(
                          child: Text(
                        "Machine Test",
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
