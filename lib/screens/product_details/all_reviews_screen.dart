import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yahmart/screens/product_details/widgets/user_reviews_widget.dart';
import '../../controller/product_details_controller.dart';
import '../../utils/common_colors.dart';
import '../../utils/screen_constants.dart';
import 'widgets/average_rating_widget.dart';

class AllReviewsScreen extends StatelessWidget {
  AllReviewsScreen({Key? key}) : super(key: key);

  /// find product detail controller.
  final ProductDetailsController _productDetailsC = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CommonColors.appBgColor,
      appBar: AppBar(
        centerTitle: false,
        elevation: 0,
        backgroundColor: CommonColors.appBgColor,
        titleSpacing: 0,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: CommonColors.appColor,
            ),
            onPressed: () => Get.back()),
        title: Text(
          "All Reviews",
          style: TextStyle(
              color: CommonColors.appColor,
              fontWeight: FontWeight.bold,
              fontSize: FontSize.s16),
        ),
      ),
      body: ScrollConfiguration(
        behavior: const ScrollBehavior().copyWith(overscroll: false),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ListView(
            children: [
              const SizedBox(height: 10),
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
            ],
          ),
        ),
      ),
    );
  }
}
