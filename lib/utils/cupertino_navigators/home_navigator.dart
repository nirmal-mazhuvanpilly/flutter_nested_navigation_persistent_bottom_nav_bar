import 'package:flutter/cupertino.dart';
import 'package:flutter_test_application/utils/common_routes.dart';
import 'package:flutter_test_application/utils/navigator_keys.dart';
import 'package:flutter_test_application/view/home_view.dart';

class HomeNavigator extends StatelessWidget {
  const HomeNavigator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoTabView(
      navigatorKey: NavigatorKeys.homeNavigatorKey,
      onGenerateRoute: CommonRoute.generatedRoutes,
      builder: (BuildContext context) {
        return const HomeView();
      },
    );
  }
}
