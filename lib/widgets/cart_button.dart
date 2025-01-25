import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yahmart/controller/cart_checkout_controller.dart';
import 'package:yahmart/utils/common_colors.dart';
import 'package:yahmart/utils/screen_constants.dart';
import '../screens/my_cart/my_cart_screen.dart';
import '../utils/common_images.dart';
import '../utils/common_logics.dart';
import 'login_bottom_sheet.dart';

class CartButton extends StatelessWidget {
  CartButton({Key? key}) : super(key: key);

  /// get cart controller.
  final CartCheckoutController _cartCheckoutC = Get.find();
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IconButton(
            padding: const EdgeInsets.only(top: 10),
            icon: Image.asset(
              CommonImages.cartIcon,
              height: 22,
              width: 22,
            ),
            onPressed: () {
              bool isLogin = CommonLogics.checkUserLogin();
              if (isLogin) {
                Get.to(() => (const MyCartScreen()));
              } else {
                Get.bottomSheet(const LoginBottomSheet());
              }
            }),
        Obx(
          () => (_cartCheckoutC.cartQuantity.value == 0)
              ? Container()
              : Positioned(
                  right: 8,
                  top: 8,
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      bool isLogin = CommonLogics.checkUserLogin();
                      if (isLogin) {
                        Get.to(() => (const MyCartScreen()));
                      } else {
                        Get.bottomSheet(const LoginBottomSheet());
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: ScreenConstant.size15,
                      height: ScreenConstant.size15,
                      margin: EdgeInsets.only(
                          top: ScreenConstant.size3,
                          right: ScreenConstant.size3,
                          bottom: ScreenConstant.size18),
                      padding: EdgeInsets.all(
                        ScreenConstant.size1,
                      ),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: CommonColors.appColor,
                          border: Border.all(width: 1, color: Colors.white)),
                      child: Text(
                        _cartCheckoutC.cartQuantity.value.toString(),
                        textScaleFactor: 1.0,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: ScreenConstant.size8,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                ),
        ),
      ],
    );
  }
}
