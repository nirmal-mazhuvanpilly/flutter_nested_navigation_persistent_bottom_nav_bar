import 'package:flutter/material.dart';
import 'package:flutter_test_application/providers/cart_provider.dart';
import 'package:flutter_test_application/providers/favorites_provider.dart';
import 'package:flutter_test_application/providers/home_provider.dart';
import 'package:flutter_test_application/services/locators.dart';
import 'package:flutter_test_application/utils/common_routes.dart';
import 'package:flutter_test_application/services/connectivty_service.dart';
import 'package:provider/provider.dart';

void main() async {
  await setUpLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<HomeProvider>(
          create: (context) => HomeProvider(),
        ),
        ChangeNotifierProvider<CartProvider>(
          create: (context) => CartProvider(),
        ),
        ChangeNotifierProvider<FavoritesProvider>(
          create: (context) => FavoritesProvider(),
        ),
        StreamProvider<ConnectivityStatus>(
            create: (context) =>
                ConnectivityService().connectionStatusController?.stream,
            initialData: ConnectivityStatus.offline),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Machine Test',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        initialRoute: "splash_view",
        onGenerateRoute: CommonRoute.generatedRoutes,
      ),
    );
  }
}
