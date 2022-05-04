import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_application/constants/border_constants.dart';
import 'package:flutter_test_application/constants/constant_widgets.dart';
import 'package:flutter_test_application/constants/padding_constants.dart';
import 'package:flutter_test_application/models/home_model.dart';
import 'package:flutter_test_application/providers/home_provider.dart';
import 'package:flutter_test_application/services/app_data.dart';
import 'package:provider/provider.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, value, child) {
        final categoryInstance = value.homeModel?.homeData?.firstWhere(
          ((element) {
            if (element.type != null) {
              return element.type == "category";
            } else {
              return false;
            }
          }),
          orElse: () => HomeDatum(),
        );
        if (categoryInstance == null || categoryInstance.type == null) {
          return ConstantWidgets.emptyBox;
        }
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: PaddingConsts.padding10,
            child: Row(
              children: categoryInstance.values!
                  .map((e) => Row(
                        children: [
                          Column(
                            children: [
                              Container(
                                width: 69,
                                height: 69,
                                padding: PaddingConsts.padding10,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade300,
                                  borderRadius: BorderConts.border100,
                                ),
                                child: CachedNetworkImage(
                                  imageUrl: (e.imageUrl == null ||
                                          e.imageUrl!.isEmpty)
                                      ? AppData.invalidImage
                                      : e.imageUrl ?? "",
                                  placeholder: (context, value) {
                                    return Icon(
                                      Icons.image,
                                      size: 25,
                                      color: Colors.grey.shade600,
                                    );
                                  },
                                ),
                              ),
                              Text(e.name ?? ""),
                            ],
                          ),
                          ConstantWidgets.sizedBoxWidth16,
                        ],
                      ))
                  .toList(),
            ),
          ),
        );
      },
    );
  }
}
