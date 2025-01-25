import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:yahmart/controller/auth_controller.dart';
import 'package:yahmart/screens/auth/widget/rounded_button_widget.dart';
import 'package:yahmart/utils/common_colors.dart';
import 'package:yahmart/utils/common_images.dart';
import 'package:yahmart/utils/constants.dart';
import 'package:yahmart/utils/screen_constants.dart';

class CreatePasswordScreen extends StatefulWidget {
  const CreatePasswordScreen({Key? key}) : super(key: key);

  @override
  State<CreatePasswordScreen> createState() => _CreatePasswordScreenState();
}

class _CreatePasswordScreenState extends State<CreatePasswordScreen> {
  final AuthController _authC = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CommonColors.appBgColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: CommonColors.appBgColor,
        title: Text(AppString.createNewPassword,
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
          Text(
              AppString
                  .yourNewPasswordMustBeDifferentFromPreviouslyUsedPassword,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: FontSize.s14,
                fontWeight: FontWeight.normal,
              )),
          SizedBox(height: ScreenConstant.size30),
          passwordTextField(),
          SizedBox(height: ScreenConstant.size10),
          conPasswordTextField(),
          SizedBox(height: ScreenConstant.size30),
          RoundedButton(
              colour: CommonColors.appColor,
              title: AppString.save,
              onPressed: () {
                FocusScope.of(context).unfocus();
                _authC.createNewPassword();
              }),
          SizedBox(height: ScreenConstant.size20),
        ],
      ),
    );
  }

  bool passwordVisible = true;

  passwordTextField() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      elevation: 3,
      child: TextField(
        obscureText: passwordVisible,
        controller: _authC.passwordTextField,
        style: TextStyle(
          color: CommonColors.blackColor,
          fontSize: ScreenConstant.size13,
        ),
        inputFormatters: [FilteringTextInputFormatter.deny(RegExp(r'\s'))],
        decoration: InputDecoration(
          counterText: "",
          isDense: true,
          contentPadding: const EdgeInsets.all(16),
          border: InputBorder.none,
          hintText: "New password",
          hintStyle: TextStyle(
            color: CommonColors.hintColor,
            fontSize: ScreenConstant.size13,
          ),
          suffixIcon: IconButton(
            color: CommonColors.appColor,
            icon:
                Icon(passwordVisible ? Icons.visibility : Icons.visibility_off),
            onPressed: () {
              setState(
                () {
                  passwordVisible = !passwordVisible;
                },
              );
            },
          ),
        ),
        keyboardType: TextInputType.visiblePassword,
        textInputAction: TextInputAction.done,
      ),
    );
  }

  bool conPasswordVisible = true;

  conPasswordTextField() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      elevation: 3,
      child: TextField(
        obscureText: passwordVisible,
        controller: _authC.confirmPasswordTextField,
        style: TextStyle(
          color: CommonColors.blackColor,
          fontSize: ScreenConstant.size13,
        ),
        inputFormatters: [FilteringTextInputFormatter.deny(RegExp(r'\s'))],
        decoration: InputDecoration(
          counterText: "",
          isDense: true,
          contentPadding: const EdgeInsets.all(16),
          border: InputBorder.none,
          hintText: "Confirm password",
          hintStyle: TextStyle(
            color: CommonColors.hintColor,
            fontSize: ScreenConstant.size13,
          ),
        ),
        keyboardType: TextInputType.visiblePassword,
        textInputAction: TextInputAction.done,
      ),
    );
  }
}
