import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_application/constants/border_constants.dart';
import 'package:flutter_test_application/widgets/constant_widgets.dart';
import 'package:flutter_test_application/constants/padding_constants.dart';
import 'package:flutter_test_application/models/home_model.dart';
import 'package:flutter_test_application/providers/home_provider.dart';
import 'package:provider/provider.dart';

class BannerWidget extends StatelessWidget {
  const BannerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, value, child) {
        final bannerInstance = value.homeModel?.homeData?.firstWhere(
          ((element) {
            if (element.type != null) {
              return element.type == "banners";
            } else {
              return false;
            }
          }),
          orElse: () => HomeDatum(),
        );
        if (bannerInstance == null || bannerInstance.type == null) {
          return ConstantWidgets.bannerShimmer;
        }
        return SizedBox(
          height: 181,
          child: PageView(
              controller: PageController(viewportFraction: .92),
              padEnds: false,
              children: bannerInstance.values!
                  .map((e) => Container(
                      padding: PaddingConsts.horizontal5,
                      child: ClipRRect(
                        borderRadius: BorderConts.border10,
                        child: (e.bannerUrl == null || e.bannerUrl!.isEmpty)
                            ? Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade300,
                                  borderRadius: BorderConts.border10,
                                ),
                                child: const Center(
                                  child: Icon(Icons.image),
                                ),
                              )
                            : CachedNetworkImage(
                                memCacheHeight: 181,
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
                  .toList()),
        );
      },
    );
  }
}
