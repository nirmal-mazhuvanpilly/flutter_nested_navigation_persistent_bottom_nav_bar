import 'package:flutter/material.dart';
import 'package:flutter_test_application/utils/navigator_keys.dart';
import 'package:flutter_test_application/view/cart_view.dart';

class CartNavigator extends StatelessWidget {
  const CartNavigator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        NavigatorKeys.cartNavigatorKey.currentState?.maybePop();
        return false;
      },
      child: Navigator(
        key: NavigatorKeys.cartNavigatorKey,
        initialRoute: "/",
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
                            child:
                                Text('No route defined for ${settings.name}')),
                      ));
          }
        },
      ),
    );
  }
}
