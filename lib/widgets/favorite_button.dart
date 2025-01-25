import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yahmart/screens/favorite_product/favorite_product_screen.dart';
import '../utils/common_images.dart';
import '../utils/common_logics.dart';
import 'login_bottom_sheet.dart';

class FavoriteButton extends StatelessWidget {
  const FavoriteButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        padding: EdgeInsets.zero,
        constraints: const BoxConstraints(),
        icon: Image.asset(
          CommonImages.hartIcon,
          height: 20,
          width: 20,
        ),
        onPressed: () {
          bool isLogin = CommonLogics.checkUserLogin();
          if (isLogin) {
            Get.to(() => (const FavoriteProductScreen()));
          } else {
            Get.bottomSheet(const LoginBottomSheet());
          }
        });
  }
}
