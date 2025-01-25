import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yahmart/utils/common_colors.dart';
import 'package:yahmart/utils/common_images.dart';
import '../../../controller/product_details_controller.dart';

class OfferBottomSheet extends StatelessWidget {
  OfferBottomSheet({Key? key}) : super(key: key);

  /// find product detail controller.
  final ProductDetailsController _productDetailsC = Get.find();
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12), topRight: Radius.circular(12))),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 60, horizontal: 12),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(CommonImages.couponOffer)),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  left: 0,
                  child: GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      margin: const EdgeInsets.only(top: 8, right: 8),
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: CommonColors.whiteColor),
                      child: const Icon(Icons.clear),
                    ),
                  ),
                )
              ],
            )
          ],
        ));
  }
}
