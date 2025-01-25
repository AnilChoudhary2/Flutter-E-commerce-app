import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:yahmart/controller/cart_checkout_controller.dart';
import 'package:yahmart/utils/common_colors.dart';
import 'package:yahmart/utils/screen_constants.dart';

import 'coupon_code_bottom_sheet.dart';

class CheckCouponCodeWidget extends StatelessWidget {
  CheckCouponCodeWidget({Key? key}) : super(key: key);

  /// find CartCheckout controller.
  final CartCheckoutController _cartCheckoutC = Get.find();

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        id: 'checkout_screen',
        init: _cartCheckoutC,
        builder: (dynamic controller) {
          return Container(
            color: CommonColors.whiteColor,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    couponCodeBottomSheet(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16, bottom: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Apply Coupon Code",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: FontSize.s15,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                        ),
                        const Icon(
                          Icons.arrow_forward_ios,
                          size: 20,
                        )
                      ],
                    ),
                  ),
                ),
                Divider(
                  thickness: 1,
                  color: CommonColors.borderColor,
                ),
                _cartCheckoutC.selectedCouponCode!.couponCode != null
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 5),
                          Text(
                            _cartCheckoutC.selectedCouponCode?.couponCode ?? "",
                            style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            _cartCheckoutC.selectedCouponCode?.offerValue ?? "",
                            style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.black87),
                          ),
                        ],
                      )
                    : Container(),
                const SizedBox(height: 16),
              ],
            ),
          );
        });
  }
}
