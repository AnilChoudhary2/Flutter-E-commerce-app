import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:yahmart/controller/auth_controller.dart';
import 'package:yahmart/screens/auth/login_screen.dart';
import 'package:yahmart/screens/auth/widget/rounded_button_widget.dart';
import 'package:yahmart/screens/auth/widget/rounded_text_field_widget.dart';
import 'package:yahmart/utils/common_colors.dart';
import 'package:yahmart/utils/common_images.dart';
import 'package:yahmart/utils/constants.dart';
import 'package:yahmart/utils/screen_constants.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final AuthController _authC = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CommonColors.appBgColor,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          children: [
            SizedBox(height: ScreenConstant.size50),
            Image.asset(
              CommonImages.yaMartLogo,
              width: ScreenConstant.size80,
              height: ScreenConstant.size80,
              alignment: Alignment.center,
            ),
            SizedBox(height: ScreenConstant.size6),
            Text(AppString.createAccountStart,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: FontSize.s16,
                  fontWeight: FontWeight.w600,
                )),
            SizedBox(height: ScreenConstant.size30),
            OutlineBorderInputField(
              controller: _authC.userNameTextField,
              keyboardType: TextInputType.text,
              autofocus: false,
              maxLine: 1,
              textAlign: TextAlign.start,
              textInputAction: TextInputAction.next,
              textColor: CommonColors.blackColor.value,
              hintText: "User name",
              fontSize: ScreenConstant.size13,
              hintColor: CommonColors.hintColor.value,
              isAllowDecimal: false,
            ),
            SizedBox(height: ScreenConstant.size5),
            OutlineBorderInputField(
              controller: _authC.mobileTextField,
              keyboardType: TextInputType.phone,
              autofocus: false,
              maxLine: 1,
              textAlign: TextAlign.start,
              textInputAction: TextInputAction.next,
              textColor: CommonColors.blackColor.value,
              hintText: "Mobile number",
              maxLength: 10,
              fontSize: ScreenConstant.size13,
              hintColor: CommonColors.hintColor.value,
              isAllowDecimal: false,
            ),
            SizedBox(height: ScreenConstant.size5),
            OutlineBorderInputField(
              controller: _authC.emailTextField,
              keyboardType: TextInputType.emailAddress,
              autofocus: false,
              maxLine: 1,
              textAlign: TextAlign.start,
              textInputAction: TextInputAction.done,
              textColor: CommonColors.blackColor.value,
              hintText: "Email address",
              fontSize: ScreenConstant.size13,
              hintColor: CommonColors.hintColor.value,
              isAllowDecimal: false,
            ),
            SizedBox(height: ScreenConstant.size5),
            passwordTextField(),
            SizedBox(height: ScreenConstant.size5),
            conPasswordTextField(),
            SizedBox(height: ScreenConstant.size20),
            RoundedButton(
              colour: CommonColors.appColor,
              title: AppString.signUp,
              onPressed: () {
                FocusScope.of(context).unfocus();
                _authC.doRegister();
              },
            ),
            SizedBox(height: ScreenConstant.size30),
            GestureDetector(
              onTap: () {
                _authC.passwordTextField = TextEditingController(text: "");
                _authC.userNameTextField = TextEditingController(text: "");
                _authC.mobileTextField = TextEditingController(text: "");
                _authC.emailTextField = TextEditingController(text: "");
                _authC.confirmPasswordTextField =
                    TextEditingController(text: "");
                Get.to(() => const LoginScreen());
              },
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(children: <TextSpan>[
                  const TextSpan(
                      text: "Already have an account?  ",
                      style: TextStyle(fontSize: 15, color: Colors.black)),
                  TextSpan(
                      text: "Login",
                      style: TextStyle(
                          // decoration: TextDecoration.underline,
                          fontSize: 16,
                          color: CommonColors.yellowColor,
                          fontWeight: FontWeight.bold)),
                ]),
              ),
            ),
            SizedBox(height: ScreenConstant.size30),
          ],
        ),
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
          hintText: "Password",
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
          // suffixIcon: IconButton(
          //   icon: Icon(
          //       color: CommonColors.appColor,
          //       conPasswordVisible ? Icons.visibility : Icons.visibility_off),
          //   onPressed: () {
          //     setState(
          //       () {
          //         conPasswordVisible = !conPasswordVisible;
          //       },
          //     );
          //   },
          // ),
        ),
        keyboardType: TextInputType.visiblePassword,
        textInputAction: TextInputAction.done,
      ),
    );
  }
}
