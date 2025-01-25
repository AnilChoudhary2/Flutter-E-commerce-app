import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yahmart/utils/common_logics.dart';
import '../utils/common_colors.dart';
import 'login_bottom_sheet.dart';

class MenuButton extends StatelessWidget {
  const MenuButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (ctx) => IconButton(
          icon: Icon(
            Icons.menu,
            color: CommonColors.appColor,
          ),
          onPressed: () async {
            bool isLogin = CommonLogics.checkUserLogin();
            if (isLogin) {
              Scaffold.of(ctx).openDrawer();
            } else {
              Get.bottomSheet(const LoginBottomSheet());
            }
          }),
    );
  }
}
