import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_application/constants/constant_widgets.dart';
import 'package:flutter_test_application/providers/cart_provider.dart';
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
    Future.microtask(() {
      context.read<HomeProvider>().getHomeData();
      context.read<CartProvider>().getcartItems();
    } );
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
          items: <BottomNavigationBarItem>[
            const BottomNavigationBarItem(
                icon: Icon(Icons.home), label: "Home"),
            const BottomNavigationBarItem(
                icon: Icon(Icons.apps), label: "Categories"),
            const BottomNavigationBarItem(
                icon: Icon(Icons.local_offer), label: "Offers"),
            BottomNavigationBarItem(
                icon: Stack(
                  children: [
                    const Icon(Icons.add_shopping_cart),
                    Consumer<CartProvider>(
                      builder: (context, value, child) => (value
                                  .cartItems?.isEmpty ??
                              true)
                          ? ConstantWidgets.emptyBox
                          : Positioned(
                              right: 0,
                              child: Container(
                                height: 12,
                                width: 12,
                                padding: const EdgeInsets.all(2),
                                decoration: const BoxDecoration(
                                    color: Colors.red, shape: BoxShape.circle),
                                child: FittedBox(
                                  child: Text(
                                    value.cartItems?.length.toString() ?? "",
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                    ),
                  ],
                ),
                label: "Cart"),
            const BottomNavigationBarItem(
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
