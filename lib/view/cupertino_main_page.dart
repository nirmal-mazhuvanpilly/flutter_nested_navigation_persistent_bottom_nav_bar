import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_application/providers/home_provider.dart';
import 'package:flutter_test_application/utils/cupertino_navigators/account_navigator.dart';
import 'package:flutter_test_application/utils/cupertino_navigators/cart_navigator.dart';
import 'package:flutter_test_application/utils/cupertino_navigators/category_navigator.dart';
import 'package:flutter_test_application/utils/cupertino_navigators/home_navigator.dart';
import 'package:flutter_test_application/utils/cupertino_navigators/offer_navigator.dart';
import 'package:flutter_test_application/utils/navigator_keys.dart';
import 'package:provider/provider.dart';

class CupertinoMainPage extends StatefulWidget {
  const CupertinoMainPage({Key? key}) : super(key: key);

  @override
  State<CupertinoMainPage> createState() => _CupertinoMainPageState();
}

class _CupertinoMainPageState extends State<CupertinoMainPage> {
  final CupertinoTabController _cupertinoTabController =
      CupertinoTabController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<HomeProvider>().getHomeData());
  }

  final _listOfKeys = [
    NavigatorKeys.homeNavigatorKey,
    NavigatorKeys.cateogoryNavigatorKey,
    NavigatorKeys.offerNavigatorKey,
    NavigatorKeys.cartNavigatorKey,
    NavigatorKeys.accountNavigatorKey
  ];

  Future<bool> _onWillPop() async {
    if (_listOfKeys[_cupertinoTabController.index].currentState != null) {
      return !await _listOfKeys[_cupertinoTabController.index]
          .currentState!
          .maybePop();
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: CupertinoTabScaffold(
        controller: _cupertinoTabController,
        tabBar: CupertinoTabBar(
          backgroundColor: Colors.grey.shade300,
          border: Border.all(color: Colors.grey.shade300),
          iconSize: 25.0,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.apps), label: "Categories"),
            BottomNavigationBarItem(
                icon: Icon(Icons.local_offer), label: "Offers"),
            BottomNavigationBarItem(
                icon: Icon(Icons.add_shopping_cart), label: "Cart"),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_circle), label: "Account"),
          ],
        ),
        tabBuilder: (BuildContext context, int index) {
          switch (index) {
            case 0:
              return const HomeNavigator();
            case 1:
              return const CategoryNavigator();
            case 2:
              return const OfferNavigator();
            case 3:
              return const CartNavigator();
            case 4:
              return const AccountNavigator();
            default:
              return const Center(
                child: Text("No Tabs Found"),
              );
          }
        },
      ),
    );
  }
}
