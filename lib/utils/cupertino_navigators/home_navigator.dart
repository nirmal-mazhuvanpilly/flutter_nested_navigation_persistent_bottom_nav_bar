import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_application/models/home_model.dart';
import 'package:flutter_test_application/utils/navigator_keys.dart';
import 'package:flutter_test_application/view/cart_view.dart';
import 'package:flutter_test_application/view/home_view.dart';
import 'package:flutter_test_application/view/product_view.dart';

class HomeNavigator extends StatelessWidget {
  const HomeNavigator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoTabView(
      navigatorKey: NavigatorKeys.homeNavigatorKey,
      onGenerateRoute: (settings) {
        switch (settings.name) {
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
          default:
            return MaterialPageRoute(
                builder: (_) => Scaffold(
                      body: Center(
                          child: Text('No route defined for ${settings.name}')),
                    ));
        }
      },
      builder: (BuildContext context) {
        return const HomeView();
      },
    );
  }
}
