import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yahmart/utils/common_colors.dart';

import '../../../controller/product_details_controller.dart';
import '../../../utils/screen_constants.dart';

class ProductDetailsView extends StatelessWidget {
  ProductDetailsView({Key? key}) : super(key: key);

  /// find product detail controller.
  final ProductDetailsController _productDetailsC = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: CommonColors.whiteColor,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Text(
            "Product Details",
            textAlign: TextAlign.start,
            style: TextStyle(
                fontSize: FontSize.s15,
                fontWeight: FontWeight.w500,
                color: Colors.black),
          ),
          const SizedBox(height: 14),
          Text(
            "Name: ${_productDetailsC.productDetailsData!.productName!}",
            textAlign: TextAlign.start,
            style: TextStyle(
                fontSize: FontSize.s12,
                fontWeight: FontWeight.w400,
                color: Colors.black87),
          ),
          const SizedBox(height: 8),
          Text(
            _productDetailsC.productDetailsData!.productDescription!,
            textAlign: TextAlign.start,
            style: TextStyle(
                fontSize: FontSize.s12,
                fontWeight: FontWeight.w400,
                color: Colors.black87),
          ),
          const SizedBox(height: 14),
        ],
      ),
    );
  }
}
