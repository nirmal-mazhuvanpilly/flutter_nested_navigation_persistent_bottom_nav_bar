import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_application/constants/border_constants.dart';
import 'package:flutter_test_application/constants/constant_widgets.dart';
import 'package:flutter_test_application/constants/padding_constants.dart';
import 'package:flutter_test_application/providers/home_provider.dart';
import 'package:provider/provider.dart';

class BannerWidget extends StatelessWidget {
  const BannerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 181,
      child: Consumer<HomeProvider>(
        builder: (context, value, child) {
          final bannerInstance =
              value.homeModel?.homeData?.firstWhere(((element) {
            if (element.type != null) {
              return element.type!.contains("banners");
            } else {
              return false;
            }
          }));
          if (bannerInstance == null) {
            return ConstantWidgets.emptyBox;
          }
          return PageView(
              controller: PageController(viewportFraction: .92),
              padEnds: false,
              children: bannerInstance.values!
                  .map((e) => Container(
                      padding: PaddingConsts.horizontal5,
                      child: ClipRRect(
                        borderRadius: BorderConts.border10,
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl: e.bannerUrl ?? "",
                          placeholder: (context, string) {
                            return Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: BorderConts.border10,
                              ),
                            );
                          },
                        ),
                      )))
                  .toList());
        },
      ),
    );
  }
}