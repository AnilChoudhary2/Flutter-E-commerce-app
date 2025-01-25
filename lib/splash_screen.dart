import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yahmart/screens/home/home_screen.dart';
import 'package:yahmart/utils/common_colors.dart';
import 'package:yahmart/utils/common_images.dart';
import 'package:yahmart/utils/screen_constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () async {
      Get.offAll(() => const HomeScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: CommonColors.splashBgColor,
        alignment: Alignment.center,
        child: Image.asset(
          CommonImages.yaMartLogo,
          width: ScreenConstant.size200,
          height: ScreenConstant.size210,
        ),
      ),
    );
  }
}
