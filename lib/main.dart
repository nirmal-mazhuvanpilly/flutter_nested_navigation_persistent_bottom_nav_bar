import 'package:flutter/material.dart';
import 'package:flutter_test_application/providers/home_provider.dart';
import 'package:flutter_test_application/services/locators.dart';
import 'package:flutter_test_application/view/home_page.dart';
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
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter test application',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: const HomePage(),
      ),
    );
  }
}
