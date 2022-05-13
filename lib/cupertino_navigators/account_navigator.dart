import 'package:flutter/cupertino.dart';
import 'package:flutter_test_application/utils/common_routes.dart';
import 'package:flutter_test_application/utils/navigator_keys.dart';
import 'package:flutter_test_application/view/account_view.dart';

class AccountNavigator extends StatelessWidget {
  const AccountNavigator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoTabView(
      navigatorKey: NavigatorKeysNControllers.accountNavigatorKey,
      onGenerateRoute: CommonRoute.generatedRoutes,
      builder: (BuildContext context) {
        return const AccountView();
      },
    );
  }
}
