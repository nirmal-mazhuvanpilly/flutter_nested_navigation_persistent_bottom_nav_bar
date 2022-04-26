import 'package:flutter/material.dart';
import 'package:flutter_test_application/providers/home_provider.dart';
import 'package:flutter_test_application/widgets/banner_widget.dart';
import 'package:flutter_test_application/widgets/category_widget.dart';
import 'package:flutter_test_application/widgets/search_widget.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<HomeProvider>().getHomeData());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: const [
            SearchWidget(),
            CategoryWidget(),
            BannerWidget(),
          ],
        ),
      ),
    );
  }
}
