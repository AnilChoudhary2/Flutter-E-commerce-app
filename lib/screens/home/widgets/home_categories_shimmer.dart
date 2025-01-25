import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../../utils/common_colors.dart';

class HomeCategoriesShimmer extends StatelessWidget {
  const HomeCategoriesShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: CommonColors.appBgColor,
      child: ScrollConfiguration(
        behavior: const ScrollBehavior().copyWith(overscroll: false),
        child: SingleChildScrollView(
          primary: false,
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(
                10,
                (index) => Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 35.0,
                            backgroundColor: Colors.transparent,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(.3),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Shimmer.fromColors(
                              baseColor: CommonColors.shimmerBaseColor,
                              highlightColor:
                                  CommonColors.shimmerHighlightColor,
                              child: Text(
                                "AAAA",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: CommonColors.blackColor,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
          ),
        ),
      ),
    );
  }
}
