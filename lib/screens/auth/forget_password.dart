import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yahmart/controller/auth_controller.dart';
import 'package:yahmart/screens/auth/widget/rounded_button_widget.dart';
import 'package:yahmart/screens/auth/widget/rounded_text_field_widget.dart';
import 'package:yahmart/utils/common_colors.dart';
import 'package:yahmart/utils/common_images.dart';
import 'package:yahmart/utils/constants.dart';
import 'package:yahmart/utils/screen_constants.dart';

class ForgetPasswordScreen extends StatelessWidget {
  ForgetPasswordScreen({Key? key}) : super(key: key);

  final AuthController _authC = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CommonColors.appBgColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: CommonColors.appBgColor,
        leading: IconButton(
          icon: Image.asset(
            CommonImages.backButton,
            width: ScreenConstant.size12,
            height: ScreenConstant.size25,
          ),
          onPressed: () => Get.back(),
        ),
        title: Text(AppString.forgetPasswordString,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: FontSize.s16,
              fontWeight: FontWeight.w600,
            )),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          SizedBox(height: ScreenConstant.size40),
          Image.asset(
            CommonImages.yaMartLogo,
            width: ScreenConstant.size120,
            height: ScreenConstant.size130,
            alignment: Alignment.center,
          ),
          SizedBox(height: ScreenConstant.size70),
          Text(AppString.pleaseEnterEmailAddressToVerificationCode,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: FontSize.s14,
                fontWeight: FontWeight.normal,
              )),
          SizedBox(height: ScreenConstant.size30),
          OutlineBorderInputField(
            controller: _authC.mobileTextField,
            keyboardType: TextInputType.phone,
            autofocus: false,
            maxLine: 1,
            maxLength: 10,
            textAlign: TextAlign.start,
            textInputAction: TextInputAction.done,
            textColor: CommonColors.blackColor.value,
            hintText: "Phone Number",
            fontSize: ScreenConstant.size13,
            hintColor: CommonColors.hintColor.value,
            isAllowDecimal: false,
          ),
          SizedBox(height: ScreenConstant.size30),
          RoundedButton(
              colour: CommonColors.appColor,
              title: AppString.send,
              onPressed: () {
                FocusScope.of(context).unfocus();
                _authC.forgetPasswordEmailOTP();
              }),
          SizedBox(height: ScreenConstant.size20),
        ],
      ),
    );
  }
}
