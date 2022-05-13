import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_application/constants/border_constants.dart';
import 'package:flutter_test_application/constants/text_style_constants.dart';
import 'package:flutter_test_application/widgets/clippers/flag_banner.dart';
import 'package:flutter_test_application/widgets/constant_widgets.dart';
import 'package:flutter_test_application/constants/padding_constants.dart';
import 'package:flutter_test_application/models/home_model.dart';
import 'package:flutter_test_application/providers/cart_provider.dart';
import 'package:flutter_test_application/providers/home_provider.dart';
import 'package:flutter_test_application/utils/navigator_keys.dart';
import 'package:provider/provider.dart';

class ProductWidget extends StatelessWidget {
  const ProductWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(builder: (context, value, child) {
      final productInstance = value.homeModel?.homeData?.firstWhere(
        ((element) {
          if (element.type != null) {
            return element.type == "products";
          } else {
            return false;
          }
        }),
        orElse: () => HomeDatum(),
      );
      if (productInstance == null || productInstance.type == null) {
        return ConstantWidgets.productShimmer;
      }
      return Container(
        padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
        height: 325,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: productInstance.values?.length ?? 1,
          itemBuilder: (context, index) {
            final ValueNotifier<int> _count = ValueNotifier<int>(1);

            final productItem = productInstance.values?.elementAt(index);
            return GestureDetector(
              onTap: () {
                NavigatorKeysNControllers.homeNavigatorKey.currentState
                    ?.pushNamed("product_view", arguments: productItem);
              },
              child: Row(
                children: [
                  Container(
                    height: 325,
                    width: 160,
                    decoration: BoxDecoration(
                      borderRadius: BorderConts.border5,
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Stack(
                      children: [
                        (productItem?.offer != 0)
                            ? Positioned(
                                top: 12,
                                child: ClipPath(
                                  clipper: const FlagBanner(),
                                  child: Container(
                                      color: Colors.red,
                                      padding: const EdgeInsets.fromLTRB(
                                          5.0, 2, 15.0, 2),
                                      child: Text(
                                        "${productItem?.offer ?? ""}% OFF",
                                        style: TextStyleConsts.white,
                                      )),
                                ),
                              )
                            : ConstantWidgets.emptyBox,
                        Padding(
                          padding: PaddingConsts.padding12,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Align(
                                alignment: Alignment.centerRight,
                                child: Icon(
                                  Icons.favorite,
                                  color: Colors.grey,
                                ),
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: SizedBox(
                                  height: 92,
                                  width: 92,
                                  child: (productItem?.image == null ||
                                          productItem!.image!.isEmpty)
                                      ? ConstantWidgets.emptyBox
                                      : CachedNetworkImage(
                                          imageUrl: productItem.image ?? "",
                                          memCacheHeight: 92,
                                          memCacheWidth: 92),
                                ),
                              ),
                              (productItem?.isExpress == true)
                                  ? Container(
                                      height: 20,
                                      width: 20,
                                      color: Colors.amber,
                                      padding: PaddingConsts.padding1,
                                      child: const Icon(
                                        Icons.delivery_dining,
                                        size: 15,
                                      ))
                                  : const SizedBox(height: 20, width: 10),
                              Text(
                                productItem?.actualPrice ?? "",
                                style: TextStyleConsts.strike12GreyShade900,
                              ),
                              Text(
                                productItem?.offerPrice ?? "",
                                style: TextStyleConsts.bold15,
                              ),
                              Expanded(
                                flex: 3,
                                child: Text(
                                  productItem?.name ?? "",
                                  overflow: TextOverflow.fade,
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      if (_count.value > 1) {
                                        _count.value = _count.value - 1;
                                      }
                                    },
                                    child: Container(
                                        padding: PaddingConsts.padding5,
                                        decoration: BoxDecoration(
                                            color: Colors.grey.shade300,
                                            shape: BoxShape.circle),
                                        child:
                                            const Icon(Icons.remove, size: 15)),
                                  ),
                                  ValueListenableBuilder<int>(
                                    valueListenable: _count,
                                    builder: (context, value, child) => Text(
                                      value.toString(),
                                      style: TextStyleConsts.boldGreenShade900,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      _count.value = _count.value + 1;
                                    },
                                    child: Container(
                                        padding: PaddingConsts.padding5,
                                        decoration: BoxDecoration(
                                            color: Colors.grey.shade300,
                                            shape: BoxShape.circle),
                                        child: const Icon(Icons.add, size: 15)),
                                  ),
                                ],
                              ),
                              ConstantWidgets.sizedBoxHeight10,
                              Expanded(
                                  flex: 2,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: ElevatedButton(
                                          onPressed: () {
                                            context
                                                .read<CartProvider>()
                                                .addOrRemoveFromCart(
                                                    count: _count.value,
                                                    item: productItem,
                                                    fromHome: true);
                                            _count.value = 1;
                                          },
                                          child: const Text("ADD"),
                                        ),
                                      ),
                                    ],
                                  ))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  ConstantWidgets.sizedBoxWidth10
                ],
              ),
            );
          },
        ),
      );
    });
  }
}
