import 'package:flutter/material.dart';
import 'package:yahmart/utils/common_colors.dart';
import '../../../utils/common_images.dart';
import '../../../utils/screen_constants.dart';

class SuggestionBannerWidget extends StatelessWidget {
  const SuggestionBannerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: CommonColors.whiteColor,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: IntrinsicHeight(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Image.asset(
                    CommonImages.lowestPrice,
                    height: 35,
                    width: 35,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Lowest Price",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: FontSize.s10,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                ],
              ),
              const VerticalDivider(
                color: Colors.black54,
              ),
              Column(
                children: [
                  Image.asset(
                    CommonImages.carGrey,
                    height: 35,
                    width: 35,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Cash on Delivery",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: FontSize.s10,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                ],
              ),
              const VerticalDivider(
                color: Colors.black54,
              ),
              Column(
                children: [
                  Image.asset(
                    CommonImages.uTurnIcon,
                    height: 35,
                    width: 35,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "7 -day Returns",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: FontSize.s10,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
