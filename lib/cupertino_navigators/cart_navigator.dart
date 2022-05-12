import 'package:flutter/cupertino.dart';
import 'package:flutter_test_application/utils/common_routes.dart';
import 'package:flutter_test_application/utils/navigator_keys.dart';
import 'package:flutter_test_application/view/cart_view.dart';

class CartNavigator extends StatelessWidget {
  const CartNavigator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoTabView(
      navigatorKey: NavigatorKeysNControllers.cartNavigatorKey,
      onGenerateRoute: CommonRoute.generatedRoutes,
      builder: (BuildContext context) {
        return const CartView();
      },
    );
  }
}
