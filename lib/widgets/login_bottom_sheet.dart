import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yahmart/screens/auth/register_screen.dart';
import 'package:yahmart/utils/common_colors.dart';
import 'package:yahmart/widgets/outline_border_button.dart';
import '../screens/auth/login_screen.dart';
import '../utils/screen_constants.dart';

class LoginBottomSheet extends StatelessWidget {
  const LoginBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          color: Colors.transparent,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 60),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12))),
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          child: OutlineBorderButtonView(
                            "Login",
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            onPressed: () async {
                              Get.back();
                              Get.offAll(() => const LoginScreen());
                            },
                            backgroundColor: CommonColors.appColor,
                            color: CommonColors.whiteColor,
                            fontSize: FontSize.s15,
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          child: OutlineBorderButtonView(
                            "Register",
                            onPressed: () async {
                              Get.back();
                              Get.offAll(() => const RegisterScreen());
                            },
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            backgroundColor: CommonColors.whiteColor,
                            color: CommonColors.appColor,
                            fontSize: FontSize.s15,
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  left: 0,
                  child: GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      margin: const EdgeInsets.only(top: 8, right: 8),
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: CommonColors.whiteColor),
                      child: const Icon(Icons.clear),
                    ),
                  ),
                )
              ],
            )
          ],
        ));
  }
}
