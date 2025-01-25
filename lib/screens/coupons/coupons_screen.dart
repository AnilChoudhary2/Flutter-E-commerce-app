import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/common_colors.dart';
import '../../utils/common_images.dart';
import '../../utils/screen_constants.dart';

class CouponsScreen extends StatelessWidget {
  const CouponsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CommonColors.appBgColor,
      appBar: AppBar(
        centerTitle: false,
        elevation: 0,
        backgroundColor: CommonColors.appBgColor,
        leadingWidth: 22,
        leading: GestureDetector(
            onTap: () => Get.back(),
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Image.asset(
                CommonImages.backButton,
                color: CommonColors.appColor,
              ),
            )),
        title: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text(
            "Coupons",
            style: TextStyle(
                color: CommonColors.appColor,
                fontWeight: FontWeight.bold,
                fontSize: FontSize.s16),
          ),
        ),
      ),
      body: ListView(
        children: const [],
      ),
    );
  }
}
