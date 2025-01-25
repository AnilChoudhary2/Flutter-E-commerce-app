import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../controller/product_controller.dart';
import '../../../utils/common_colors.dart';
import '../../../utils/common_images.dart';
import '../../../utils/screen_constants.dart';

class SortingBottomSheet extends StatelessWidget {
  SortingBottomSheet({Key? key}) : super(key: key);

  /// find product controller.
  final ProductController _productC = Get.find();
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        height: 230,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12), topRight: Radius.circular(12))),
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 16),
          children:
              List.generate(_productC.productListingSorting.length, (index) {
            return Column(
              children: [
                GestureDetector(
                  onTap: () {
                    if (_productC
                        .productListingSorting[index].isSelected!.value) {
                      _productC.productListingSorting[index].isSelected!(false);
                      _productC.productSortingValue("");
                    } else {
                      for (var element in _productC.productListingSorting) {
                        element.isSelected!(false);
                      }
                      _productC.productListingSorting[index].isSelected!(true);
                      Get.back();
                      _productC.isFinishLoadMore(false);
                      _productC.isLoadMoreLoading(false);
                      _productC.pageNumber(1);
                      _productC.productSortingValue(
                          _productC.productListingSorting[index].keyValue);
                      _productC.getProductListPagination(
                          shouldShowLoader: false,
                          isPageRefresh: true,
                          shouldShowLoadingPopup: true);
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _productC.productListingSorting[index].name!,
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                        ),
                        SvgPicture.asset(
                          _productC.productListingSorting[index].isSelected!
                                  .value
                              ? CommonImages.radioBtnSelected
                              : CommonImages.radioBtn,
                          color: Colors.black,
                          height: ScreenConstant.size22,
                          width: ScreenConstant.size22,
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 1,
                  width: double.infinity,
                  color: CommonColors.borderColor,
                ),
              ],
            );
          }),
        ),
      );
    });
  }
}
