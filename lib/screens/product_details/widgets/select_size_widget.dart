import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yahmart/utils/common_logics.dart';
import 'package:yahmart/utils/screen_constants.dart';
import '../../../controller/product_details_controller.dart';
import '../../../utils/common_colors.dart';

class SelectSizeWidget extends StatelessWidget {
  SelectSizeWidget({Key? key}) : super(key: key);

  /// find product detail controller.
  final ProductDetailsController _productDetailsC = Get.find();

  isSelected(String attributeName, String attributeValue) {
    return _productDetailsC.selectedAttributes.containsKey(attributeName) &&
        _productDetailsC.selectedAttributes[attributeName] == attributeValue;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: CommonColors.whiteColor,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GetBuilder(
          id: 'select_size_widget',
          init: _productDetailsC,
          builder: (dynamic controller) {
            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              padding: const EdgeInsets.only(bottom: 12),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(
                      _productDetailsC.attributeOptions!.length, (index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        Text(
                          "Select ${CommonLogics.toTitleCase(_productDetailsC.attributeOptions![index].attributeName!)}",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: FontSize.s15,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Wrap(
                            children: List.generate(
                                _productDetailsC.attributeOptions![index]
                                    .attributeOptions!.length, (jIndex) {
                              return GestureDetector(
                                onTap: () {
                                  _productDetailsC.selectSizeFun(
                                      index: index, jIndex: jIndex);
                                },
                                child: Card(
                                  elevation: 2,
                                  color: _productDetailsC.selectedAttributes
                                              .containsKey(
                                            _productDetailsC
                                                .attributeOptions![index]
                                                .attributeName!,
                                          ) &&
                                          _productDetailsC.selectedAttributes[
                                                  _productDetailsC
                                                      .attributeOptions![index]
                                                      .attributeName!] ==
                                              _productDetailsC
                                                  .attributeOptions![index]
                                                  .attributeOptions![jIndex]
                                      ? CommonColors.searchHintColor
                                      : CommonColors.whiteColor,
                                  margin:
                                      const EdgeInsets.only(right: 12, top: 12),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6.0),
                                    side: BorderSide(
                                        color: CommonColors.appColor,
                                        width: 0.3,
                                        style: BorderStyle.solid),
                                  ),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 7),
                                    child: Text(
                                      CommonLogics.toTitleCase(_productDetailsC
                                          .attributeOptions![index]
                                          .attributeOptions![jIndex]
                                          .trim()),
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontSize: FontSize.s15,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),
                        ),
                      ],
                    );
                  })),
            );
          }),
    );
  }
}
