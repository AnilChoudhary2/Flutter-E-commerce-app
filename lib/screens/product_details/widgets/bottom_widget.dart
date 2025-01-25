import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yahmart/utils/common_colors.dart';
import '../../../controller/product_controller.dart';
import '../../../widgets/outline_border_button.dart';

class BottomWidget extends StatelessWidget {
  final Function() onPressedAddToCart;
  final Function() onPressedBuyNow;
  const BottomWidget({
    Key? key,
    required this.onPressedAddToCart,
    required this.onPressedBuyNow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, -3),
            color: Colors.grey.withOpacity(.2),
            blurRadius: 3.0,
          ),
        ],
        color: CommonColors.whiteColor,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: OutlineBorderButtonView(
              "Add to Cart",
              onPressed: onPressedAddToCart,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: OutlineBorderButtonView(
              "Buy Now",
              backgroundColor: CommonColors.appColor,
              color: CommonColors.whiteColor,
              onPressed: onPressedBuyNow,
            ),
          ),
        ],
      ),
    );
  }
}
