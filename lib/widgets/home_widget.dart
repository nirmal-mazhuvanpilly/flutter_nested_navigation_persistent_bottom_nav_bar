import 'package:flutter/material.dart';
import 'package:flutter_test_application/widgets/banner_widget.dart';
import 'package:flutter_test_application/widgets/category_widget.dart';
import 'package:flutter_test_application/widgets/products_widget.dart';
import 'package:flutter_test_application/widgets/search_widget.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        SearchWidget(),
        CategoryWidget(),
        BannerWidget(),
        ProductWidget(),
      ],
    );
  }
}
