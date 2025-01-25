import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:yahmart/controller/product_details_controller.dart';
import 'package:yahmart/utils/common_colors.dart';
import 'package:yahmart/utils/screen_constants.dart';

class CheckDeliveryDateWidget extends StatelessWidget {
  CheckDeliveryDateWidget({Key? key}) : super(key: key);

  /// find ProductDetails controller.
  final ProductDetailsController _productDetailsC = Get.find();
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        id: 'select_size_widget',
        init: _productDetailsC,
        builder: (dynamic controller) {
          return Container(
            color: CommonColors.whiteColor,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Text(
                  "Check Delivery Info",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: FontSize.s15,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                ),
                const SizedBox(height: 14),
                SizedBox(
                  height: 40,
                  child: TextField(
                      onSubmitted: (v) {
                        _productDetailsC.checkDeliveryAvailability();
                      },
                      controller: _productDetailsC.pinCodeTextField,
                      style: TextStyle(
                        color: CommonColors.blackColor,
                        fontSize: ScreenConstant.size12,
                      ),
                      maxLength: 6,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      decoration: InputDecoration(
                        counterText: "",
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 0, vertical: 6),
                        hintText: "PinCode",
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: ScreenConstant.size12,
                        ),
                        // labelText: "PinCode",
                        labelStyle: const TextStyle(color: Color(0xFF424242)),
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: CommonColors.appColor),
                        ),
                        suffixIconConstraints:
                            const BoxConstraints(minWidth: 23, maxHeight: 20),
                        suffixIcon: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min, // added line
                          children: <Widget>[
                            IconButton(
                                padding: EdgeInsets.zero,
                                icon: Text(
                                  "CHECK",
                                  style: TextStyle(
                                    color: CommonColors.yellowColor,
                                    fontSize: ScreenConstant.size12,
                                  ),
                                ),
                                onPressed: () {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  _productDetailsC.checkDeliveryAvailability();
                                }),
                          ],
                        ),
                      )),
                ),
                if (_productDetailsC.availableCourier!.isNotEmpty)
                  ..._productDetailsC.availableCourier!.map(
                    (e) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      child: RichText(
                        text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                              text: e.freightCharge.toString(),
                              style: const TextStyle(
                                color: Colors.black87,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const TextSpan(
                              text: "     |     ",
                              style: TextStyle(
                                color: Colors.orange,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const TextSpan(
                              text: "₹ ",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text: "${e.rate?.toStringAsFixed(0)}",
                              style: TextStyle(
                                color: CommonColors.blackColor,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text: "(delivery charge)",
                              style: TextStyle(
                                color: CommonColors.greyColor535353,
                                fontSize: 13,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                else
                  Text(
                    _productDetailsC.availableCourierMessage.value,
                    style: TextStyle(
                      color: CommonColors.blackColor,
                      fontSize: ScreenConstant.size14,
                    ),
                  ),
                const SizedBox(height: 14),
              ],
            ),
          );
        });
  }
}
