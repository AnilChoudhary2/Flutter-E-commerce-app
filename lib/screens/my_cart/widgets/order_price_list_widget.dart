import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yahmart/controller/cart_checkout_controller.dart';
import '../../../utils/common_colors.dart';
import '../../../utils/common_logics.dart';
import '../../../utils/screen_constants.dart';
import '../../../widgets/simple_clipper.dart';

class OrderPriceListWidget extends StatelessWidget {
  OrderPriceListWidget({Key? key}) : super(key: key);

  /// find CartCheckout controller.
  final CartCheckoutController _cartCheckoutC = Get.find();
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ClipPath(
        clipper: SimpleClipper(),
        child: Container(
          padding: const EdgeInsets.all(8),
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Price (${_cartCheckoutC.myCartList.length.toString()} item)",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: CommonColors.blackColor,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    "₹ ${CommonLogics.convertValueInThousandFormat(inputString: _cartCheckoutC.cartBasePriceTotal.value.toString())}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: FontSize.s14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Discount",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: CommonColors.blackColor,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    "- ₹ ${CommonLogics.convertValueInThousandFormat(inputString: _cartCheckoutC.cartTotalDiscount.value.toStringAsFixed(0))}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: CommonColors.yellowColor,
                      fontSize: FontSize.s14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Coupon",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: CommonColors.blackColor,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    "₹ 0",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: FontSize.s14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Delivery Charge",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: CommonColors.blackColor,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    "₹ 0",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: FontSize.s14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total Amount",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: CommonColors.blackColor,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "₹ ${CommonLogics.convertValueInThousandFormat(inputString: _cartCheckoutC.cartSalePriceTotal.value.toString())}",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const Divider(),
              Text(
                "You will save ₹ ${CommonLogics.convertValueInThousandFormat(inputString: (_cartCheckoutC.cartBasePriceTotal.value - _cartCheckoutC.cartSalePriceTotal.value).toString())} On this order",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.green,
                  fontSize: FontSize.s14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      );
    });
  }
}
