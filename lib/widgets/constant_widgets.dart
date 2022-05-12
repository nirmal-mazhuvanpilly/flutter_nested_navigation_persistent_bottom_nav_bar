import 'package:flutter/material.dart';
import 'package:flutter_test_application/constants/border_constants.dart';
import 'package:flutter_test_application/constants/padding_constants.dart';
import 'package:shimmer/shimmer.dart';

class ConstantWidgets {
  static const sizedBoxWidth10 = SizedBox(width: 10);
  static const sizedBoxWidth16 = SizedBox(width: 16);

  static const sizedBoxHeight5 = SizedBox(height: 5);
  static const sizedBoxHeight10 = SizedBox(height: 10);

  static const emptyBox = SizedBox();

  static final cateogoryShimmer = SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Padding(
        padding: PaddingConsts.padding10,
        child: Shimmer.fromColors(
          baseColor: Colors.grey.shade100,
          highlightColor: Colors.grey,
          direction: ShimmerDirection.ltr,
          child: Row(
              children: List.generate(
                  6,
                  (index) => Row(
                        children: [
                          Container(
                            width: 69,
                            height: 69,
                            padding: PaddingConsts.padding10,
                            decoration: const BoxDecoration(
                              color: Colors.grey,
                              shape: BoxShape.circle,
                            ),
                          ),
                          ConstantWidgets.sizedBoxWidth16,
                        ],
                      ))),
        )),
  );

  static final bannerShimmer = SizedBox(
    height: 181,
    child: PageView(
      controller: PageController(viewportFraction: .92),
      padEnds: false,
      children: List.generate(
        3,
        (index) => Shimmer.fromColors(
          baseColor: Colors.grey.shade100,
          highlightColor: Colors.grey,
          direction: ShimmerDirection.ltr,
          child: Container(
              padding: PaddingConsts.horizontal5,
              child: (Container(
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderConts.border10,
                ),
              ))),
        ),
      ),
    ),
  );

  static final productShimmer = Container(
    padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
    height: 285,
    child: Shimmer.fromColors(
      baseColor: Colors.grey.shade100,
      highlightColor: Colors.grey,
      direction: ShimmerDirection.ltr,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: List.generate(
          4,
          (index) => Row(
            children: [
              Container(
                height: 285,
                width: 160,
                decoration: BoxDecoration(
                  borderRadius: BorderConts.border5,
                  border: Border.all(color: Colors.grey),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                          height: 92,
                          width: 92,
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Colors.grey,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ),
                      sizedBoxHeight5,
                      Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(5)),
                      ),
                      sizedBoxHeight5,
                      Container(
                        height: 15,
                        width: 40,
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(5)),
                      ),
                      sizedBoxHeight5,
                      Container(
                        height: 15,
                        width: 50,
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(5)),
                      ),
                      sizedBoxHeight5,
                      Container(
                        height: 15,
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(5)),
                      ),
                      sizedBoxHeight5,
                      Container(
                        height: 15,
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(5)),
                      ),
                      sizedBoxHeight5,
                      Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 15, 10, 0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(5)),
                            ),
                          ))
                    ],
                  ),
                ),
              ),
              ConstantWidgets.sizedBoxWidth10
            ],
          ),
        ),
      ),
    ),
  );
}
