import 'package:flutter/material.dart';
import 'package:flutter_test_application/utils/navigator_keys.dart';
import 'package:flutter_test_application/view/sample_page.dart';
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
          case "sample":
            return MaterialPageRoute(builder: (context) => const SamplePage());
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
