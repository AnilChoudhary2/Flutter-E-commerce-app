import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../controller/cart_checkout_controller.dart';
import '../../../utils/common_colors.dart';
import '../../../utils/common_images.dart';
import '../../../utils/screen_constants.dart';

couponCodeBottomSheet(context) {
  /// find CartCheckout controller.
  final CartCheckoutController cartCheckoutC = Get.find();
  return showModalBottomSheet(
      isScrollControlled: true,
      useSafeArea: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      context: context,
      builder: (context) {
        return Container(
          color: Colors.transparent,
          child: ListView(
            children: [
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Apply Coupon Code",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: CommonColors.greyColor535353,
                        fontSize: ScreenConstant.size14,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        margin: const EdgeInsets.only(top: 8, right: 8),
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: CommonColors.yellowColor),
                        child: const Icon(Icons.clear),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Container(
                height: 40,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextField(
                    controller: cartCheckoutC.couponCodeTextField,
                    style: TextStyle(
                        color: CommonColors.blackColor,
                        fontSize: ScreenConstant.size15,
                        fontWeight: FontWeight.w500),
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      counterText: "",
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 9),
                      hintText: "COUPON CODE",
                      hintStyle: TextStyle(
                          color: CommonColors.appColor,
                          fontSize: ScreenConstant.size13,
                          fontWeight: FontWeight.w500),
                      // labelText: "PinCode",
                      labelStyle: const TextStyle(color: Color(0xFF424242)),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: CommonColors.appColor, width: 1.5),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: CommonColors.appColor, width: 1.5),
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
                                "APPLY",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: CommonColors.yellowColor,
                                  fontSize: ScreenConstant.size14,
                                ),
                              ),
                              onPressed: () {}),
                        ],
                      ),
                    )),
              ),
              const SizedBox(height: 25),
              ...cartCheckoutC.allCouponList.map((el) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            for (var element in cartCheckoutC.allCouponList) {
                              element.isSelected!(false);
                            }
                            el.isSelected!(true);
                            cartCheckoutC.selectedCouponCode = el;
                            cartCheckoutC.updateCouponCode();
                            Get.back();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                el.couponCode!,
                                style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              SvgPicture.asset(
                                el.isSelected!.value
                                    ? CommonImages.radioBtnSelected
                                    : CommonImages.radioBtn,
                                color: Colors.black,
                                height: ScreenConstant.size22,
                                width: ScreenConstant.size22,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          el.offerValue!,
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.black87),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          margin: const EdgeInsets.symmetric(vertical: 14),
                          height: 1,
                          width: double.infinity,
                          color: CommonColors.borderColor,
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        );
      });
}
