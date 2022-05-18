import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_application/constants/border_constants.dart';
import 'package:flutter_test_application/constants/padding_constants.dart';
import 'package:flutter_test_application/constants/text_style_constants.dart';
import 'package:flutter_test_application/providers/favorites_provider.dart';
import 'package:flutter_test_application/widgets/constant_widgets.dart';
import 'package:provider/provider.dart';

class FavoritesView extends StatelessWidget {
  const FavoritesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Favorites"),
          actions: [
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                context.read<FavoritesProvider>().clearFavorites();
              },
            ),
          ],
        ),
        body: Consumer<FavoritesProvider>(
          builder: (context, value, child) {
            if (value.favoriteItems == null) {
              return const Center(child: CircularProgressIndicator());
            }
            return ListView.builder(
              itemCount: value.favoriteItems?.length,
              itemBuilder: (context, index) {
                return Container(
                  padding: PaddingConsts.padding10,
                  margin: PaddingConsts.padding10,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderConts.border5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 0,
                        child: Container(
                          width: 50,
                          height: 50,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                              borderRadius: BorderConts.border100),
                          child: (value.favoriteItems
                                          ?.elementAt(index)
                                          .value
                                          ?.image ==
                                      null ||
                                  value.favoriteItems!
                                      .elementAt(index)
                                      .value!
                                      .image!
                                      .isEmpty)
                              ? CircleAvatar(
                                  backgroundColor: Colors.grey.shade400,
                                  child: Icon(
                                    Icons.image,
                                    size: 25,
                                    color: Colors.grey.shade600,
                                  ),
                                )
                              : CachedNetworkImage(
                                  fit: BoxFit.cover,
                                  errorWidget: (context, string, dynamic) {
                                    return CircleAvatar(
                                      backgroundColor: Colors.grey.shade400,
                                      child: Icon(
                                        Icons.image,
                                        size: 25,
                                        color: Colors.grey.shade600,
                                      ),
                                    );
                                  },
                                  placeholder: (context, value) {
                                    return CircleAvatar(
                                      backgroundColor: Colors.grey.shade400,
                                      child: Icon(
                                        Icons.image,
                                        size: 25,
                                        color: Colors.grey.shade600,
                                      ),
                                    );
                                  },
                                  imageUrl: value.favoriteItems
                                          ?.elementAt(index)
                                          .value
                                          ?.image ??
                                      ""),
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
                              value.favoriteItems
                                      ?.elementAt(index)
                                      .value
                                      ?.name ??
                                  "",
                              style: TextStyleConsts.boldGreenShade900,
                            ),
                            Text(
                              value.favoriteItems
                                      ?.elementAt(index)
                                      .value
                                      ?.actualPrice ??
                                  "",
                              style: TextStyleConsts.boldStrikeGreyShade600,
                            ),
                            Text(
                              value.favoriteItems
                                      ?.elementAt(index)
                                      .value
                                      ?.offerPrice ??
                                  "",
                              style: TextStyleConsts.boldStrikeGreyShade800,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                          flex: 0,
                          child: IconButton(
                            icon: Icon(
                              Icons.delete,
                              color: Colors.green.shade800,
                            ),
                            onPressed: () {
                              value.clearFromFavorites(
                                  id: value.favoriteItems?.elementAt(index).id);
                            },
                          ))
                    ],
                  ),
                );
              },
            );
          },
        ));
  }
}
