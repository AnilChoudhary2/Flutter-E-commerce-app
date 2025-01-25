import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/product_details_controller.dart';
import '../../../model/review_list_model.dart';
import '../../../utils/common_colors.dart';
import '../../../utils/common_logics.dart';
import '../../../utils/common_values.dart';
import '../../../utils/screen_constants.dart';
import '../../../widgets/network_image_widget.dart';
import '../../../widgets/read_more_text_widget.dart';

class UserReviewsWidget extends StatelessWidget {
  final ReviewListModel reviewItem;
  UserReviewsWidget({Key? key, required this.reviewItem}) : super(key: key);

  /// find product detail controller.
  final ProductDetailsController _productDetailsC = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          minLeadingWidth: 30,
          leading: Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: CommonColors.profileColor,
              borderRadius: const BorderRadius.all(Radius.circular(50.0)),
              border: Border.all(
                color: CommonColors.whiteColor,
                width: 1.5,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50.0),
              child: NetworkImageWidget(
                imageUrl: reviewItem.user!.avatarUrl!,
              ),
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  reviewItem.user!.displayName!,
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: FontSize.s14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                ),
              ),
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(bottom: 5),
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(0, 3),
                      color: Colors.grey.withOpacity(.3),
                      blurRadius: 2.0,
                    ),
                  ],
                  color: Colors.green,
                  // border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  "${reviewItem.rating!.toString()} *",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: CommonColors.whiteColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          subtitle: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "112 people found this answer helpful",
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontSize: FontSize.s12,
                    fontWeight: FontWeight.w400,
                    color: Colors.black38),
              ),
              Text(
                CommonLogics.getDateFromUtc(
                  reviewItem.createdDate!,
                  CommonValues.ddMmYyyyAa,
                ),
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontSize: FontSize.s10,
                    fontWeight: FontWeight.w400,
                    color: Colors.black38),
              ),
            ],
          ),
        ),
        const SizedBox(height: 5),
        ReadMoreTextWidget(
          readMoreText: reviewItem.description!,
          textStyle: TextStyle(
            color: Colors.black87,
            fontSize: FontSize.s13,
            fontWeight: FontWeight.w400,
          ),
          trimLines: 2,
        ),
        const SizedBox(height: 10),
        if (reviewItem.images!.isNotEmpty)
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: List.generate(
                  reviewItem.images!.length,
                  (index) => Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10.0)),
                        border: Border.all(
                          color: CommonColors.borderColor,
                          width: 1,
                        ),
                      ),
                      margin: const EdgeInsets.only(right: 10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: NetworkImageWidget(
                          imageUrl: reviewItem.images![index],
                        ),
                      ))),
            ),
          ),
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.check_circle,
                  size: 16,
                ),
                const SizedBox(width: 8),
                Text(
                  "Verified Purchase",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: FontSize.s12,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Icon(Icons.thumb_up, color: Colors.grey),
                const SizedBox(width: 8),
                Text(
                  reviewItem.upvote! > 0 ? reviewItem.upvote!.toString() : "",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: FontSize.s12,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
