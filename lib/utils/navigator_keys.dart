import 'package:flutter/cupertino.dart';

class NavigatorKeys {
  static final homeNavigatorKey = GlobalKey<NavigatorState>();
  static final cateogoryNavigatorKey = GlobalKey<NavigatorState>();
  static final offerNavigatorKey = GlobalKey<NavigatorState>();
  static final cartNavigatorKey = GlobalKey<NavigatorState>();
  static final accountNavigatorKey = GlobalKey<NavigatorState>();

  static final CupertinoTabController cupertinoTabController =
      CupertinoTabController();
}
