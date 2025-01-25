import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yahmart/screens/product_details/widgets/you_may_like_card_widget.dart';
import 'package:yahmart/utils/common_colors.dart';
import '../../../controller/cart_checkout_controller.dart';
import '../../../controller/product_controller.dart';
import '../../../controller/product_details_controller.dart';
import '../../../utils/screen_constants.dart';
import '../product_details_screen.dart';

class YouMayLikeAlsoWidget extends StatelessWidget {
  YouMayLikeAlsoWidget({Key? key}) : super(key: key);

  /// find product controller.
  final ProductController _productC = Get.find();
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        height: 330,
        color: CommonColors.whiteColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "You May Also Like",
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontSize: FontSize.s15,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children:
                      List.generate(_productC.productListData.length, (index) {
                    return GestureDetector(
                        onTap: () async {
                          Get.to(
                              () => ProductDetailsScreen(
                                  productId: _productC
                                      .productListData[index].productId,
                                  brandName: _productC.productListData[index]
                                      .brand!.brandName!),
                              preventDuplicates: false);
                        },
                        child: Container(
                          padding: const EdgeInsets.only(left: 6, bottom: 15),
                          width: 180,
                          child: YouMayLikeCardWidget(
                            productListData: _productC.productListData[index],
                          ),
                        ));
                  }),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
