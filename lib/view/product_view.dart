import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_application/constants/constant_widgets.dart';
import 'package:flutter_test_application/constants/padding_constants.dart';
import 'package:flutter_test_application/models/home_model.dart';

class ProductView extends StatelessWidget {
  final Value? productItem;
  const ProductView({Key? key, this.productItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(productItem?.name ?? ""),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  height: MediaQuery.of(context).size.height * .25,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade400)),
                  child: Stack(
                    children: [
                      CachedNetworkImage(imageUrl: productItem?.image ?? ""),
                      (productItem?.isExpress == true)
                          ? Container(
                              color: Colors.amber,
                              padding: PaddingConsts.padding1,
                              child: const Icon(Icons.delivery_dining))
                          : ConstantWidgets.emptyBox,
                      (productItem?.offer != 0)
                          ? Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                  color: Colors.red,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 2),
                                  child: Text(
                                    "${productItem?.offer}% OFF",
                                    style: const TextStyle(color: Colors.white),
                                  )),
                            )
                          : ConstantWidgets.emptyBox,
                    ],
                  )),
              ConstantWidgets.sizedBoxHeight10,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    productItem?.actualPrice ?? "",
                    style: TextStyle(
                      color: Colors.grey.shade900,
                      fontSize: 12,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                  ConstantWidgets.sizedBoxWidth10,
                  Text(
                    productItem?.offerPrice ?? "",
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              ConstantWidgets.sizedBoxHeight10,
              Text(
                productItem?.name ?? "",
                style: const TextStyle(fontSize: 20),
              ),
            ],
          ),
        ));
  }
}
