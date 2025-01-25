import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../../utils/common_colors.dart';

class HomeCartShimmer extends StatelessWidget {
  const HomeCartShimmer({Key? key}) : super(key: key);

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
                          Card(
                            elevation: 7,
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                color: Colors.black,
                              ),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: SizedBox(
                              height: 130,
                              width: 120,
                              child: Column(
                                children: [
                                  Expanded(
                                      child: ClipRRect(
                                    borderRadius: BorderRadius.circular(5.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.grey.withOpacity(.3),
                                      ),
                                    ),
                                  )),
                                  const SizedBox(height: 10),
                                  Shimmer.fromColors(
                                    baseColor: CommonColors.shimmerBaseColor,
                                    highlightColor:
                                        CommonColors.shimmerHighlightColor,
                                    child: const Text(
                                      "AAAA",
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
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
