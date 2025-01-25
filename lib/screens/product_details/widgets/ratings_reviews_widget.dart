import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yahmart/screens/product_details/widgets/user_reviews_widget.dart';
import '../../../controller/product_details_controller.dart';
import '../../../utils/common_colors.dart';
import '../../../utils/screen_constants.dart';
import '../all_reviews_screen.dart';
import 'average_rating_widget.dart';

class RatingsReviewsWidget extends StatelessWidget {
  RatingsReviewsWidget({Key? key}) : super(key: key);

  /// find product detail controller.
  final ProductDetailsController _productDetailsC = Get.find();
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return _productDetailsC.isReviewListLoading.value
          ? Container()
          : Container(
              color: CommonColors.whiteColor,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  Text(
                    "Product Ratings & Reviews",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: FontSize.s15,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                  const SizedBox(height: 25),
                  AverageRatingWidget(),
                  const SizedBox(height: 14),
                  const Divider(color: Colors.grey),
                  if (_productDetailsC.reviewList.isNotEmpty)
                    ListView.builder(
                      itemCount: _productDetailsC.reviewList.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            UserReviewsWidget(
                                reviewItem: _productDetailsC.reviewList[index]),
                            const SizedBox(height: 5),
                            const Divider(color: Colors.grey),
                          ],
                        );
                      },
                    ),
                  if (_productDetailsC.reviewList.isNotEmpty)
                    Column(
                      children: [
                        const SizedBox(height: 5),
                        GestureDetector(
                          onTap: () {
                            Get.to(() => AllReviewsScreen());
                          },
                          child: Row(
                            children: [
                              Text(
                                "VIEW ALL REVIEWS",
                                style: TextStyle(
                                    color: CommonColors.yellowColor,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(width: 3),
                              Icon(Icons.arrow_forward_ios_rounded,
                                  size: 16, color: CommonColors.yellowColor)
                            ],
                          ),
                        ),
                      ],
                    ),
                  const SizedBox(height: 14),
                ],
              ),
            );
    });
  }
}
