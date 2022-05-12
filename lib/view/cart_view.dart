import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_application/constants/border_constants.dart';
import 'package:flutter_test_application/constants/constant_widgets.dart';
import 'package:flutter_test_application/constants/padding_constants.dart';
import 'package:flutter_test_application/providers/cart_provider.dart';
import 'package:provider/provider.dart';

class CartView extends StatefulWidget {
  const CartView({Key? key}) : super(key: key);

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<CartProvider>().getcartItems());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart"),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              context.read<CartProvider>().clearCart();
            },
          ),
        ],
      ),
      body: Consumer<CartProvider>(
        builder: (context, value, child) {
          return ListView.builder(
            itemCount: value.cartItems?.length ?? 0,
            itemBuilder: (context, index) {
              return Container(
                padding: PaddingConsts.padding10,
                margin: PaddingConsts.padding10,
                decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(5)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 0,
                      child: ClipRRect(
                        borderRadius: BorderConts.border100,
                        child: SizedBox(
                          width: 50,
                          height: 50,
                          child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl: value.cartItems
                                      ?.elementAt(index)
                                      .cartItem
                                      ?.image ??
                                  ""),
                        ),
                      ),
                    ),
                    ConstantWidgets.sizedBoxWidth10,
                    Expanded(
                      flex: 6,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            value.cartItems?.elementAt(index).cartItem?.name ??
                                "",
                            style: TextStyle(
                                color: Colors.green.shade900,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            value.cartItems
                                    ?.elementAt(index)
                                    .cartItem
                                    ?.actualPrice ??
                                "",
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                          Text(
                            value.cartItems
                                    ?.elementAt(index)
                                    .cartItem
                                    ?.offerPrice ??
                                "",
                            style: TextStyle(
                                color: Colors.grey.shade800,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 5,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    value.addItemToCart(
                                        item: value.cartItems
                                            ?.elementAt(index)
                                            .cartItem);
                                  },
                                  child: Container(
                                      padding: PaddingConsts.padding5,
                                      decoration: BoxDecoration(
                                          color: Colors.grey.shade400,
                                          shape: BoxShape.circle),
                                      child: const Icon(Icons.add, size: 15)),
                                ),
                                Text(
                                  value.cartItems
                                          ?.elementAt(index)
                                          .itemNumber
                                          .toString() ??
                                      "",
                                  style: TextStyle(
                                      color: Colors.green.shade900,
                                      fontWeight: FontWeight.bold),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    value.addItemToCart(
                                        item: value.cartItems
                                            ?.elementAt(index)
                                            .cartItem,
                                        inc: false);
                                  },
                                  child: Container(
                                      padding: PaddingConsts.padding5,
                                      decoration: BoxDecoration(
                                          color: Colors.grey.shade400,
                                          shape: BoxShape.circle),
                                      child:
                                          const Icon(Icons.remove, size: 15)),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: IconButton(
                                onPressed: () {
                                  value.deleteFromCart(
                                      id: value.cartItems?.elementAt(index).id);
                                },
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.green.shade800,
                                )),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
