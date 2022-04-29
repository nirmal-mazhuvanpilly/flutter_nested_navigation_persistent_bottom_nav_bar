import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_application/utils/navigator_keys.dart';
import 'package:flutter_test_application/view/cart_view.dart';

class CartNavigator extends StatelessWidget {
  const CartNavigator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoTabView(
      navigatorKey: NavigatorKeys.cartNavigatorKey,
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case "/":
            return MaterialPageRoute(
              builder: (context) {
                return const CartView();
              },
            );
          default:
            return MaterialPageRoute(
                builder: (_) => Scaffold(
                      body: Center(
                          child: Text('No route defined for ${settings.name}')),
                    ));
        }
      },
      builder: (BuildContext context) {
        return const CartView();
      },
    );
  }
}
