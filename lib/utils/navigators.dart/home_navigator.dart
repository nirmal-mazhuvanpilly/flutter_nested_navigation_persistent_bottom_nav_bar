import 'package:flutter/material.dart';
import 'package:flutter_test_application/models/home_model.dart';
import 'package:flutter_test_application/utils/navigator_keys.dart';
import 'package:flutter_test_application/view/product_view.dart';
import 'package:flutter_test_application/widgets/home_widget.dart';

class HomeNavigator extends StatelessWidget {
  const HomeNavigator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: NavigatorKeys.homeNavigatorKey,
      initialRoute: "/",
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case "/":
            return MaterialPageRoute(
              builder: (context) {
                return const HomeWidget();
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
    );
  }
}
