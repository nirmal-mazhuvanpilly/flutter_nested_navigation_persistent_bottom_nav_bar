import 'package:flutter/cupertino.dart';
import 'package:flutter_test_application/utils/common_routes.dart';
import 'package:flutter_test_application/utils/navigator_keys.dart';
import 'package:flutter_test_application/view/offers_view.dart';

class OfferNavigator extends StatelessWidget {
  const OfferNavigator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoTabView(
      navigatorKey: NavigatorKeysNControllers.offerNavigatorKey,
      onGenerateRoute: CommonRoute.generatedRoutes,
      builder: (BuildContext context) {
        return const OffersView();
      },
    );
  }
}
