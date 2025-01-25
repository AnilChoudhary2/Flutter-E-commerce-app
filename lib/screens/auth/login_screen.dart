import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yahmart/controller/auth_controller.dart';
import 'package:yahmart/screens/auth/forget_password.dart';
import 'package:yahmart/screens/auth/mobile_number_screen.dart';
import 'package:yahmart/screens/auth/register_screen.dart';
import 'package:yahmart/screens/auth/widget/rounded_button_widget.dart';
import 'package:yahmart/screens/auth/widget/rounded_text_field_widget.dart';
import 'package:yahmart/utils/common_colors.dart';
import 'package:yahmart/utils/common_images.dart';
import 'package:yahmart/utils/constants.dart';
import 'package:yahmart/utils/screen_constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
            Text(AppString.signInYourAccountStart,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: FontSize.s16,
                  fontWeight: FontWeight.w600,
                )),
            SizedBox(height: ScreenConstant.size30),
            OutlineBorderInputField(
              controller: _authC.emailTextField,
              keyboardType: TextInputType.text,
              autofocus: false,
              maxLine: 1,
              textAlign: TextAlign.start,
              textInputAction: TextInputAction.next,
              textColor: CommonColors.blackColor.value,
              hintText: "Email address/Phone No.",
              fontSize: ScreenConstant.size13,
              hintColor: CommonColors.hintColor.value,
              isAllowDecimal: false,
            ),
            SizedBox(height: ScreenConstant.size10),
            passwordTextField(),
            SizedBox(height: ScreenConstant.size14),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    _authC.mobileTextField = TextEditingController(text: "");
                    Get.to(() => ForgetPasswordScreen());
                  },
                  child: Text(AppString.forgetPassword,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: CommonColors.yellowColor,
                        fontSize: FontSize.s14,
                        fontWeight: FontWeight.bold,
                      )),
                ),
              ],
            ),
            SizedBox(height: ScreenConstant.size30),
            RoundedButton(
              colour: CommonColors.appColor,
              title: AppString.login,
              onPressed: () {
                FocusScope.of(context).unfocus();
                _authC.doLogIn();
              },
            ),
            SizedBox(height: ScreenConstant.size30),
            GestureDetector(
              onTap: () {
                _authC.mobileTextField = TextEditingController(text: "");
                Get.to(const MobileNumberScreen());
              },
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(children: <TextSpan>[
                  const TextSpan(
                      text: "Or Login With Phone Number ",
                      style: TextStyle(fontSize: 15, color: Colors.black)),
                  TextSpan(
                      text: "OTP?",
                      style: TextStyle(
                          // decoration: TextDecoration.underline,
                          fontSize: 16,
                          color: CommonColors.appColor,
                          fontWeight: FontWeight.bold)),
                ]),
              ),
            ),
            SizedBox(height: ScreenConstant.size40),
            // Text(AppString.orContinueWith,
            //     textAlign: TextAlign.center,
            //     style: TextStyle(
            //       color: Colors.black54,
            //       fontSize: FontSize.s14,
            //       fontWeight: FontWeight.normal,
            //     )),
            // SizedBox(height: ScreenConstant.size30),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 45),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //     children: [
            //       GestureDetector(
            //         onTap: () {
            //           _authC.signInWithGoogle();
            //         },
            //         child: Image.asset(
            //           CommonImages.googleLogo,
            //           width: ScreenConstant.size36,
            //           height: ScreenConstant.size36,
            //         ),
            //       ),
            //       if (Platform.isIOS)
            //         GestureDetector(
            //           onTap: () {
            //             _authC.signInWithApple();
            //           },
            //           child: Image.asset(
            //             CommonImages.appleLogo,
            //             width: ScreenConstant.size40,
            //             height: ScreenConstant.size40,
            //           ),
            //         ),
            //       GestureDetector(
            //         onTap: () {
            //           _authC.signInWithFacebook();
            //         },
            //         child: Image.asset(
            //           CommonImages.facebookLogo,
            //           width: ScreenConstant.size36,
            //           height: ScreenConstant.size40,
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            // SizedBox(height: ScreenConstant.size30),
            GestureDetector(
              onTap: () {
                _authC.passwordTextField = TextEditingController(text: "");
                _authC.mobileTextField = TextEditingController(text: "");
                _authC.emailTextField = TextEditingController(text: "");
                _authC.confirmPasswordTextField =
                    TextEditingController(text: "");
                _authC.userNameTextField = TextEditingController(text: "");
                Get.to(const RegisterScreen());
              },
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(children: <TextSpan>[
                  const TextSpan(
                      text: "Don't have an account?  ",
                      style: TextStyle(fontSize: 15, color: Colors.black)),
                  TextSpan(
                      text: "Register",
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
}
