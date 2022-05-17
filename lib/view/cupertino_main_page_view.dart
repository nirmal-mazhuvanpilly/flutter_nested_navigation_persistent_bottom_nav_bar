import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_application/constants/padding_constants.dart';
import 'package:flutter_test_application/constants/text_style_constants.dart';
import 'package:flutter_test_application/providers/favorites_provider.dart';
import 'package:flutter_test_application/widgets/connectivity_widget.dart';
import 'package:flutter_test_application/widgets/constant_widgets.dart';
import 'package:flutter_test_application/cupertino_navigators/account_navigator.dart';
import 'package:flutter_test_application/cupertino_navigators/cart_navigator.dart';
import 'package:flutter_test_application/cupertino_navigators/category_navigator.dart';
import 'package:flutter_test_application/cupertino_navigators/home_navigator.dart';
import 'package:flutter_test_application/cupertino_navigators/offer_navigator.dart';
import 'package:flutter_test_application/providers/cart_provider.dart';
import 'package:flutter_test_application/providers/home_provider.dart';
import 'package:flutter_test_application/utils/navigator_keys.dart';
import 'package:provider/provider.dart';

class CupertinoMainPageView extends StatefulWidget {
  const CupertinoMainPageView({Key? key}) : super(key: key);

  @override
  State<CupertinoMainPageView> createState() => _CupertinoMainPageViewState();
}

class _CupertinoMainPageViewState extends State<CupertinoMainPageView> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<HomeProvider>().getHomeData();
      context.read<CartProvider>().getcartItems();
      context.read<FavoritesProvider>().getFavoriteItems();
    });
  }

  final _listOfKeys = [
    NavigatorKeysNControllers.homeNavigatorKey,
    NavigatorKeysNControllers.cateogoryNavigatorKey,
    NavigatorKeysNControllers.offerNavigatorKey,
    NavigatorKeysNControllers.cartNavigatorKey,
    NavigatorKeysNControllers.accountNavigatorKey
  ];

  Future<bool> _onWillPop() async {
    if (_listOfKeys[NavigatorKeysNControllers.cupertinoTabController.index]
            .currentState !=
        null) {
      return !await _listOfKeys[
              NavigatorKeysNControllers.cupertinoTabController.index]
          .currentState!
          .maybePop();
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return ConnectivityWidget(
      child: WillPopScope(
        onWillPop: _onWillPop,
        child: CupertinoTabScaffold(
          controller: NavigatorKeysNControllers.cupertinoTabController,
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
                        builder: (context, value, child) =>
                            (value.cartItems?.isEmpty ?? true)
                                ? ConstantWidgets.emptyBox
                                : Positioned(
                                    right: 0,
                                    child: Container(
                                      height: 12,
                                      width: 12,
                                      padding: PaddingConsts.padding2,
                                      decoration: const BoxDecoration(
                                          color: Colors.red,
                                          shape: BoxShape.circle),
                                      child: FittedBox(
                                        child: Text(
                                          value.totalItem.toString(),
                                          style: TextStyleConsts.white,
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
      ),
    );
  }
}
