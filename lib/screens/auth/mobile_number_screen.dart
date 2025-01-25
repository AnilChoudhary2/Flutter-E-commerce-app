import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yahmart/controller/auth_controller.dart';
import 'package:yahmart/screens/auth/widget/rounded_button_widget.dart';
import 'package:yahmart/screens/auth/widget/rounded_text_field_widget.dart';
import 'package:yahmart/utils/common_colors.dart';
import 'package:yahmart/utils/common_images.dart';
import 'package:yahmart/utils/screen_constants.dart';

class MobileNumberScreen extends StatefulWidget {
  const MobileNumberScreen({Key? key}) : super(key: key);

  @override
  State<MobileNumberScreen> createState() => _MobileNumberScreenState();
}

class _MobileNumberScreenState extends State<MobileNumberScreen>
    with TickerProviderStateMixin {
  final AuthController _authC = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: CommonColors.appBgColor,
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 50),
            children: [
              SizedBox(height: ScreenConstant.size40),
              Image.asset(
                CommonImages.yaMartLogo,
                width: ScreenConstant.size120,
                height: ScreenConstant.size130,
                alignment: Alignment.center,
              ),
              SizedBox(height: ScreenConstant.size70),
              OutlineBorderInputField(
                controller: _authC.mobileTextField,
                keyboardType: TextInputType.phone,
                autofocus: false,
                maxLine: 1,
                textAlign: TextAlign.start,
                textInputAction: TextInputAction.done,
                textColor: CommonColors.blackColor.value,
                hintText: "Enter mobile number",
                fontSize: ScreenConstant.size13,
                hintColor: CommonColors.hintColor.value,
                maxLength: 10,
                //inputFormatters: [MaskTextInputFormatter(mask: "##/####", filter: {"#": RegExp(r'[0-9]')})],
                isAllowDecimal: false,
              ),
              SizedBox(height: ScreenConstant.size40),
              RoundedButton(
                  colour: CommonColors.appColor,
                  title: 'Send OTP',
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    _authC.sendOtpToMobileNumber();
                  }),
              SizedBox(height: ScreenConstant.size40),
            ],
          ),
        ));
  }
}
