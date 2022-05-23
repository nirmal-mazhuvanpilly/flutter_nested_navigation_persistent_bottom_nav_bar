import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_application/constants/text_style_constants.dart';
import 'package:flutter_test_application/utils/firebase_services.dart';
import 'package:flutter_test_application/widgets/constant_widgets.dart';
import 'package:flutter_test_application/constants/padding_constants.dart';
import 'package:flutter_test_application/models/home_model.dart';
import 'package:flutter_test_application/utils/navigator_keys.dart';

class ProductView extends StatelessWidget {
  final Value? productItem;
  const ProductView({Key? key, this.productItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(productItem?.name ?? ""),
          actions: [
            IconButton(
                onPressed: () {
                  FirebaseServices.createDynamicLink(
                      id: productItem?.id.toString(), name: productItem?.name);
                },
                icon: const Icon(Icons.share))
          ],
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
                      (productItem?.image == null ||
                              productItem!.image!.isEmpty)
                          ? CircleAvatar(
                              radius: 500,
                              backgroundColor: Colors.grey.shade200,
                              child: Icon(
                                Icons.image,
                                size: 75,
                                color: Colors.grey.shade500,
                              ),
                            )
                          : CachedNetworkImage(
                              imageUrl: productItem?.image ?? "",
                              errorWidget: (context, string, dynamic) {
                                return CircleAvatar(
                                  radius: 500,
                                  backgroundColor: Colors.grey.shade200,
                                  child: Icon(
                                    Icons.image,
                                    size: 75,
                                    color: Colors.grey.shade500,
                                  ),
                                );
                              },
                              placeholder: (context, value) {
                                return CircleAvatar(
                                  radius: 500,
                                  backgroundColor: Colors.grey.shade200,
                                  child: Icon(
                                    Icons.image,
                                    size: 75,
                                    color: Colors.grey.shade500,
                                  ),
                                );
                              },
                            ),
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
                                    style: TextStyleConsts.white,
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
                    style: TextStyleConsts.strike12GreyShade900,
                  ),
                  ConstantWidgets.sizedBoxWidth10,
                  Text(
                    productItem?.offerPrice ?? "",
                    style: TextStyleConsts.bold15,
                  ),
                ],
              ),
              ConstantWidgets.sizedBoxHeight10,
              Text(
                productItem?.name ?? "",
                style: TextStyleConsts.normal20,
              ),
              ElevatedButton(
                  onPressed: () {
                    NavigatorKeysNControllers.cupertinoTabController.index = 3;
                  },
                  child: const Text("Goto Cart")),
            ],
          ),
        ));
  }
}
