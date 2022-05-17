import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_application/constants/border_constants.dart';
import 'package:flutter_test_application/constants/text_style_constants.dart';
import 'package:flutter_test_application/models/cart_model.dart';
import 'package:flutter_test_application/models/favorite_model.dart';
import 'package:flutter_test_application/providers/favorites_provider.dart';
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
    return Consumer3<HomeProvider, CartProvider, FavoritesProvider>(
        builder: (context, value, cartValue, favoriteValue, child) {
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
        height: 300,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: productInstance.values?.length ?? 1,
          itemBuilder: (context, index) {
            final productItem = productInstance.values?.elementAt(index);

            final cartItem = cartValue.cartItems?.firstWhere(
                (element) => element.cartItem?.id == productItem?.id,
                orElse: () => CartItem());

            final favoriteItem = favoriteValue.favoriteItems?.firstWhere(
                (element) => element.value?.id == productItem?.id,
                orElse: () => FavoriteItem());

            return GestureDetector(
              onTap: () {
                NavigatorKeysNControllers.homeNavigatorKey.currentState
                    ?.pushNamed("product_view", arguments: productItem);
              },
              child: Row(
                children: [
                  Container(
                    height: 300,
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
                              Align(
                                alignment: Alignment.centerRight,
                                child: (favoriteItem?.value == null)
                                    ? IconButton(
                                        onPressed: () {
                                          favoriteValue.addItemToFavorite(
                                              item: productItem);
                                        },
                                        icon: const Icon(
                                          Icons.favorite,
                                          color: Colors.grey,
                                        ),
                                      )
                                    : IconButton(
                                        onPressed: () {
                                          favoriteValue.clearFromFavorites(id: favoriteItem?.id);
                                        },
                                        icon: const Icon(
                                          Icons.favorite,
                                          color: Colors.red,
                                        ),
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
                              (cartItem?.cartItem == null)
                                  ? Expanded(
                                      flex: 2,
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: ElevatedButton(
                                              onPressed: () {
                                                context
                                                    .read<CartProvider>()
                                                    .addOrRemoveFromCart(
                                                        count: 1,
                                                        item: productItem,
                                                        fromHome: true);
                                              },
                                              child: const Text("ADD"),
                                            ),
                                          ),
                                        ],
                                      ))
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            if (cartItem?.cartItem != null) {
                                              int? count = cartItem?.itemNumber;
                                              if (count != null) {
                                                count = count - 1;
                                                if (count < 1) {
                                                  cartValue.deleteFromCart(
                                                      id: cartItem?.id);
                                                } else {
                                                  cartValue.addOrRemoveFromCart(
                                                      item: productItem,
                                                      count: count);
                                                }
                                              }
                                            }
                                          },
                                          child: Container(
                                              padding: PaddingConsts.padding5,
                                              decoration: BoxDecoration(
                                                  color: Colors.grey.shade300,
                                                  shape: BoxShape.circle),
                                              child: const Icon(Icons.remove,
                                                  size: 15)),
                                        ),
                                        (cartItem?.cartItem == null)
                                            ? Text(
                                                "0",
                                                style: TextStyleConsts
                                                    .boldGreenShade900,
                                              )
                                            : Text(
                                                cartItem?.itemNumber
                                                        .toString() ??
                                                    "",
                                                style: TextStyleConsts
                                                    .boldGreenShade900,
                                              ),
                                        GestureDetector(
                                          onTap: () {
                                            if (cartItem?.cartItem == null) {
                                              cartValue.addOrRemoveFromCart(
                                                  item: productItem, count: 1);
                                            } else {
                                              int? count = cartItem?.itemNumber;
                                              if (count != null) {
                                                count = count + 1;
                                                cartValue.addOrRemoveFromCart(
                                                    item: productItem,
                                                    count: count);
                                              }
                                            }
                                          },
                                          child: Container(
                                              padding: PaddingConsts.padding5,
                                              decoration: BoxDecoration(
                                                  color: Colors.grey.shade300,
                                                  shape: BoxShape.circle),
                                              child: const Icon(Icons.add,
                                                  size: 15)),
                                        ),
                                      ],
                                    ),
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
