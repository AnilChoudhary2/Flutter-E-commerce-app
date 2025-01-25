import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:yahmart/controller/auth_controller.dart';
import 'package:yahmart/screens/auth/widget/rounded_button_widget.dart';
import 'package:yahmart/utils/common_colors.dart';
import 'package:yahmart/utils/common_images.dart';
import 'package:yahmart/utils/constants.dart';
import 'package:yahmart/utils/screen_constants.dart';

class VerifyEmailScreen extends StatefulWidget {
  const VerifyEmailScreen({Key? key}) : super(key: key);

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  final AuthController _authC = Get.put(AuthController());

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((Duration time) => init());
    super.initState();
  }

  init() {
    _authC.timerResendButton();
  }

  @override
  dispose() {
    _authC.timer!.cancel();
    super.dispose();
  }

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
              height: ScreenConstant.size20,
            ),
            onPressed: () => Get.back(),
          ),
          title: Text(AppString.verifyYourPhone,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: FontSize.s16,
                fontWeight: FontWeight.w600,
              )),
        ),
        body: Obx(() {
          return ListView(
            primary: false,
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
              Text(AppString.pleaseEnterDigitCodeSentToEmailAddress,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: FontSize.s14,
                    fontWeight: FontWeight.normal,
                  )),
              SizedBox(height: ScreenConstant.size30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2),
                child: PinCodeTextField(
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  length: 6,
                  textStyle: TextStyle(
                    color: Colors.black,
                    fontSize: FontSize.s14,
                    fontWeight: FontWeight.bold,
                  ),
                  cursorHeight: 10,
                  obscureText: false,
                  boxShadows: [
                    BoxShadow(
                      offset: const Offset(0, 6),
                      color: Colors.grey.withOpacity(.4),
                      blurRadius: 3.0,
                    ),
                  ],
                  animationType: AnimationType.fade,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(10),
                    fieldHeight: 40,
                    fieldWidth: 40,
                    activeFillColor: Colors.white,
                    inactiveColor: Colors.white,
                    selectedColor: Colors.white,
                    selectedFillColor: Colors.white,
                    inactiveFillColor: Colors.white,
                    activeColor: Colors.white,
                    disabledColor: Colors.white,
                  ),
                  animationDuration: const Duration(milliseconds: 300),
                  backgroundColor: Colors.transparent,
                  enableActiveFill: true,
                  cursorColor: CommonColors.appColor,
                  controller: _authC.emailOtpTextField,
                  onAutoFillDisposeAction: AutofillContextAction.cancel,
                  onCompleted: (v) {
                    log("Completed");
                    _authC.verifyEmailOtp();
                  },
                  onChanged: (value) {
                    log(value);
                  },
                  beforeTextPaste: (text) {
                    log("Allowing to paste $text");
                    //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                    //but you can show anything you want here, like your pop up saying wrong paste format or etc
                    return true;
                  },
                  appContext: Get.context!,
                ),
              ),
              SizedBox(height: ScreenConstant.size20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Did not receive OTP?  ',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: FontSize.s13,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  GestureDetector(
                    onTap: _authC.enableResend.value ? _authC.resendOtp : null,
                    child: Text(AppString.resendCode,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: _authC.enableResend.value
                              ? CommonColors.appColor
                              : Colors.grey,
                          fontSize: FontSize.s13,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  if (_authC.secondsRemaining.value != 0)
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(children: <TextSpan>[
                        TextSpan(
                            text: "  after ",
                            style: TextStyle(
                              fontSize: FontSize.s13,
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                            )),
                        TextSpan(
                            text: _authC.secondsRemaining.value.toString(),
                            style: TextStyle(
                                // decoration: TextDecoration.underline,
                                fontSize: FontSize.s13,
                                color: CommonColors.appColor,
                                fontWeight: FontWeight.bold)),
                        TextSpan(
                            text: " sec.",
                            style: TextStyle(
                              fontSize: FontSize.s13,
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                            )),
                      ]),
                    ),
                ],
              ),
              SizedBox(height: ScreenConstant.size30),
              RoundedButton(
                  colour: CommonColors.appColor,
                  title: AppString.verify,
                  onPressed: _authC.verifyEmailOtp),
              SizedBox(height: ScreenConstant.size20),
            ],
          );
        }));
  }
}
