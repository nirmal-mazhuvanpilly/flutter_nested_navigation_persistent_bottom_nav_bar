import 'package:flutter/material.dart';
import 'package:flutter_test_application/models/home_model.dart';
import 'package:flutter_test_application/view/cart_view.dart';
import 'package:flutter_test_application/view/cupertino_main_page_view.dart';
import 'package:flutter_test_application/view/home_view.dart';
import 'package:flutter_test_application/view/product_view.dart';
import 'package:flutter_test_application/view/splash_view.dart';

class CommonRoute {
  static Route<dynamic>? generatedRoutes(RouteSettings settings) {
    switch (settings.name) {
      case "cupertino_main_page":
        return MaterialPageRoute(
          builder: (context) {
            return const CupertinoMainPageView();
          },
        );
      case "home_view":
        return MaterialPageRoute(
          builder: (context) {
            return const HomeView();
          },
        );
      case "cart_view":
        return MaterialPageRoute(
          builder: (context) {
            return const CartView();
          },
        );
      case "product_view":
        return MaterialPageRoute(
            builder: (context) => ProductView(
                  productItem: settings.arguments as Value,
                ));
      case "splash_view":
        return MaterialPageRoute(builder: (context) => const SplashView());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}
