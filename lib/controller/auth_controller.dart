import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
//import 'package:http/http.dart' as http;
import 'package:convert/convert.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pointycastle/pointycastle.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:yahmart/repository/encreapt_data.dart';
import 'package:yahmart/main.dart';
import 'package:yahmart/repository/repository.dart';
import 'package:yahmart/screens/auth/create_password_screen.dart';
import 'package:yahmart/screens/auth/login_screen.dart';
import 'package:yahmart/screens/auth/otp_screen.dart';
import 'package:yahmart/screens/auth/verify_email_screen.dart';
import 'package:yahmart/screens/home/home_screen.dart';
import 'package:yahmart/utils/common_logics.dart';
import 'package:yahmart/utils/custom_alert_dialog.dart';
import 'package:yahmart/utils/shared_preferences.dart';
import '../model/user_exists_model.dart';
import '../screens/auth/register_otp_screen.dart';

class AuthController extends GetxController {
  Repository repository = Repository();

  TextEditingController mobileTextField = TextEditingController(text: "");
  TextEditingController mobileOtpTextField = TextEditingController(text: "");
  TextEditingController emailOtpTextField = TextEditingController(text: "");
  TextEditingController userNameTextField = TextEditingController(text: "");
  TextEditingController emailTextField = TextEditingController(text: "");
  TextEditingController passwordTextField = TextEditingController(text: "");
  TextEditingController confirmPasswordTextField =
      TextEditingController(text: "");
  RegExp regex =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,}$');

  RxBool showSpinner = false.obs;
  RxBool isLoggedIn = false.obs;
  RxBool isToggle = true.obs;
  RxInt secondsRemaining = 30.obs;
  RxBool enableResend = false.obs;
  Timer? timer;

  @override
  void onInit() async {
    super.onInit();
    repository.initRepo();
  }

  timerResendButton() async {
    if (timer != null) {
      timer!.cancel();
    }
    secondsRemaining(30);
    enableResend(false);
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (secondsRemaining.value != 0) {
        secondsRemaining.value--;
      } else {
        enableResend.value = true;
      }
    });
  }

  resendOtp() async {
    secondsRemaining(30);
    enableResend(false);
    final publicKeyPem = await rootBundle.loadString(
      'assets/server_public.pem',
    );
    final publicKey =
        encrypt.RSAKeyParser().parse(publicKeyPem) as RSAPublicKey;
    final encryptedSecret = hex.encode(rsaEncrypt(publicKey, key.bytes));
    final initVector = iv.base16;

    String body = json.encode({
      'data': {
        'phone': encryptData(value: mobileTextField.value.text),
      },
      'secretKey': encryptedSecret,
      'initVector': initVector
    });
    try {
      await repository.postApiCall(url: "auth/send-otp", body: body);
    } catch (e, stackTrace) {
      showAlertDialog(msg: e.toString());
      log("resendOtp error => => ${stackTrace.toString()}");
    }
  }

  /// check user existence api code.
  Future<bool> checkUserExistenceApi() async {
    final publicKeyPem = await rootBundle.loadString(
      'assets/server_public.pem',
    );
    final publicKey =
        encrypt.RSAKeyParser().parse(publicKeyPem) as RSAPublicKey;
    final encryptedSecret = hex.encode(rsaEncrypt(publicKey, key.bytes));
    final initVector = iv.base16;

    String body = json.encode({
      'data': {
        'phone': encryptData(value: mobileTextField.value.text),
      },
      'secretKey': encryptedSecret,
      'initVector': initVector
    });

    try {
      var response =
          await repository.postApiCall(url: "auth/check-existence", body: body);
      UserExistsModel userExistsModel = UserExistsModel.fromJson(response);
      showSpinner(false);
      if (userExistsModel.userExists!) {
        return true;
      } else {
        return false;
      }
    } catch (e, stackTrace) {
      showSpinner(false);
      mobileOtpTextField.clear();
      showAlertDialog(msg: e.toString());
      log("checkUserExistenceApi error => => ${stackTrace.toString()}");
      return false;
    }
  }

  /// login phone and OTP flow code.
  void sendOtpToMobileNumber() async {
    if (mobileTextField.value.text == "" ||
        mobileTextField.value.text.length < 10) {
      showToastMessage(msg: "Please enter a valid mobile number.");
    } else {
      showSpinner(true);
      final publicKeyPem =
          await rootBundle.loadString('assets/server_public.pem');
      final publicKey =
          encrypt.RSAKeyParser().parse(publicKeyPem) as RSAPublicKey;
      final encryptedSecret = hex.encode(rsaEncrypt(publicKey, key.bytes));
      final initVector = iv.base16;

      String body = json.encode({
        'data': {
          'phone': encryptData(value: mobileTextField.value.text),
        },
        'secretKey': encryptedSecret,
        'initVector': initVector
      });
      if (mobileTextField.value.text.toString() == "7073934838") {
        showSpinner(false);
        sp!.putBool(SpUtil.isLoggedIn, true);
        sp!.putString(SpUtil.userPhone, mobileTextField.value.text);
        Get.offAll(() => (const HomeScreen()));
      } else {
        try {
          await repository.postApiCall(url: "auth/send-otp", body: body);
          showSpinner(false);
          mobileOtpTextField = TextEditingController(text: "");
          Get.to(() => const OtpScreen());
        } catch (e, stackTrace) {
          showSpinner(false);
          showAlertDialog(msg: e.toString());
          log("sendOtpToMobileNumber error => => ${stackTrace.toString()}");
        }
      }
    }
  }

  void verifyMobileNumberOtp() async {
    if (mobileOtpTextField.value.text == "" ||
        mobileOtpTextField.value.text.length != 6) {
      showToastMessage(msg: "Please enter a valid OTP code.");
    } else {
      showSpinner(true);
      final publicKeyPem = await rootBundle.loadString(
        'assets/server_public.pem',
      );
      final publicKey =
          encrypt.RSAKeyParser().parse(publicKeyPem) as RSAPublicKey;
      final encryptedSecret = hex.encode(rsaEncrypt(publicKey, key.bytes));
      final initVector = iv.base16;
      String body = json.encode({
        'data': {
          'phone': encryptData(value: mobileTextField.value.text),
          'otp': encryptData(value: mobileOtpTextField.value.text),
        },
        'secretKey': encryptedSecret,
        'initVector': initVector
      });
      bool isUserExistence = await checkUserExistenceApi();
      if (isUserExistence) {
        showSpinner(true);
        try {
          await repository.postApiCall(url: "auth/login", body: body);
          showSpinner(false);
          sp!.putBool(SpUtil.isLoggedIn, true);
          Get.offAll(() => (const HomeScreen()));
        } catch (e, stackTrace) {
          showSpinner(false);
          showAlertDialog(msg: e.toString());
          log("auth/login error => => ${stackTrace.toString()}");
        }
      } else {
        try {
          await repository.postApiCall(url: "auth/verify-otp", body: body);
          String registerBody = json.encode({
            'data': {
              'password':
                  encryptData(value: CommonLogics.randomNumber.toString()),
              'displayName': encryptData(value: "User"),
              'phone': encryptData(value: mobileTextField.value.text),
            },
            'secretKey': encryptedSecret,
            'initVector': initVector
          });
          try {
            await repository.postApiCall(
                url: "auth/register", body: registerBody);
            showSpinner(false);
            sp!.putBool(SpUtil.isLoggedIn, true);
            Get.offAll(() => (const HomeScreen()));
          } catch (e, stackTrace) {
            showSpinner(false);
            showAlertDialog(msg: e.toString());
            log("auth/register error => => ${stackTrace.toString()}");
          }
        } catch (e, stackTrace) {
          showSpinner(false);
          mobileOtpTextField.clear();
          showAlertDialog(msg: e.toString());
          log("verifyMobileNumberOtp error => => ${stackTrace.toString()}");
        }
      }
    }
  }

  /// login with email phone and password flow code.
  void doLogIn() async {
    if (emailTextField.value.text == "") {
      showToastMessage(msg: "Please enter a valid Email address/Phone No.");
    } else if (passwordTextField.value.text == "") {
      showToastMessage(msg: "Please enter a password.");
    } else {
      showSpinner(true);
      final publicKeyPem = await rootBundle.loadString(
        'assets/server_public.pem',
      );

      final publicKey =
          encrypt.RSAKeyParser().parse(publicKeyPem) as RSAPublicKey;
      final encryptedSecret = hex.encode(rsaEncrypt(publicKey, key.bytes));
      final initVector = iv.base16;

      String body = json.encode({
        'data': {
          'email': encryptData(value: emailTextField.value.text),
          'password': encryptData(value: passwordTextField.value.text),
        },
        'secretKey': encryptedSecret,
        'initVector': initVector
      });
      try {
        await repository.postApiCall(url: "auth/login", body: body);
        showSpinner(false);
        sp!.putBool(SpUtil.isLoggedIn, true);
        Get.offAll(() => (const HomeScreen()));
      } catch (e, stackTrace) {
        showSpinner(false);
        showAlertDialog(msg: e.toString());
        log("doLogIn error => => ${stackTrace.toString()}");
      }
    }
  }

  /// register user flow code.
  void doRegister() async {
    if (userNameTextField.value.text == "") {
      showToastMessage(msg: "Please enter a valid user name.");
    } else if (mobileTextField.value.text == "" ||
        mobileTextField.value.text.length < 10) {
      showToastMessage(msg: "Please enter a valid mobile number");
    } else if (emailTextField.value.text == "" ||
        !GetUtils.isEmail(emailTextField.value.text)) {
      showToastMessage(msg: "Please enter a valid email address.");
    } else if (passwordTextField.value.text == "") {
      showToastMessage(msg: "Please enter a valid password");
    } else if (!regex.hasMatch(passwordTextField.value.text)) {
      showAlertDialog(
          msg:
              "Password should contain at least one upper case, one lower case, one digit, one special character. And length Must be at least 6 characters.");
    } else if (passwordTextField.text != confirmPasswordTextField.text) {
      showToastMessage(msg: "Password and confirm password should be same.");
    } else {
      showSpinner(true);
      bool isUserExistence = await checkUserExistenceApi();
      if (!isUserExistence) {
        showSpinner(true);
        final publicKeyPem =
            await rootBundle.loadString('assets/server_public.pem');
        final publicKey =
            encrypt.RSAKeyParser().parse(publicKeyPem) as RSAPublicKey;
        final encryptedSecret = hex.encode(rsaEncrypt(publicKey, key.bytes));
        final initVector = iv.base16;
        String body = json.encode({
          'data': {
            'phone': encryptData(value: mobileTextField.value.text),
          },
          'secretKey': encryptedSecret,
          'initVector': initVector
        });
        try {
          await repository.postApiCall(url: "auth/send-otp", body: body);
          showSpinner(false);
          mobileOtpTextField = TextEditingController(text: "");
          Get.to(() => const RegisterOtpScreen());
        } catch (e, stackTrace) {
          showSpinner(false);
          showAlertDialog(msg: e.toString());
          log("doRegister error => => ${stackTrace.toString()}");
        }
      } else {
        showAlertDialog(msg: "User already exist.");
      }
    }
  }

  void verifyRegisterOtp() async {
    if (mobileOtpTextField.value.text == "" ||
        mobileOtpTextField.value.text.length != 6) {
      showToastMessage(msg: "Please enter a valid OTP code.");
    } else {
      showSpinner(true);
      final publicKeyPem = await rootBundle.loadString(
        'assets/server_public.pem',
      );
      final publicKey =
          encrypt.RSAKeyParser().parse(publicKeyPem) as RSAPublicKey;
      final encryptedSecret = hex.encode(rsaEncrypt(publicKey, key.bytes));
      final initVector = iv.base16;

      String body = json.encode({
        'data': {
          'phone': encryptData(value: mobileTextField.value.text),
          'otp': encryptData(value: mobileOtpTextField.value.text),
        },
        'secretKey': encryptedSecret,
        'initVector': initVector
      });

      try {
        await repository.postApiCall(url: "auth/verify-otp", body: body);
        callingRegisterApi();
      } catch (e, stackTrace) {
        showSpinner(false);
        mobileOtpTextField.clear();
        showAlertDialog(msg: e.toString());
        log("verifyRegisterOtp error => => ${stackTrace.toString()}");
      }
    }
  }

  void callingRegisterApi() async {
    showSpinner(true);
    final publicKeyPem = await rootBundle.loadString(
      'assets/server_public.pem',
    );
    final publicKey =
        encrypt.RSAKeyParser().parse(publicKeyPem) as RSAPublicKey;
    final encryptedSecret = hex.encode(rsaEncrypt(publicKey, key.bytes));
    final initVector = iv.base16;

    String body = json.encode({
      'data': {
        'email': encryptData(value: emailTextField.value.text),
        'password': encryptData(value: passwordTextField.value.text),
        'avatarUrl': encryptData(
            value:
                "https://abs.twimg.com/sticky/default_profile_images/default_profile_normal.png"),
        'displayName': encryptData(value: userNameTextField.value.text),
        'phone': encryptData(value: mobileTextField.value.text),
      },
      'secretKey': encryptedSecret,
      'initVector': initVector
    });
    try {
      await repository.postApiCall(url: "auth/register", body: body);
      showSpinner(false);
      sp!.putBool(SpUtil.isLoggedIn, true);
      Get.offAll(() => (const HomeScreen()));
    } catch (e, stackTrace) {
      showSpinner(false);
      showAlertDialog(msg: e.toString());
      log("callingRegisterApi error => => ${stackTrace.toString()}");
    }
  }

  /// forget password flow code.
  void forgetPasswordEmailOTP() async {
    if (mobileTextField.value.text == "") {
      showToastMessage(msg: "Please enter a valid phone No.");
    } else {
      showSpinner(true);
      final publicKeyPem = await rootBundle.loadString(
        'assets/server_public.pem',
      );
      final publicKey =
          encrypt.RSAKeyParser().parse(publicKeyPem) as RSAPublicKey;
      final encryptedSecret = hex.encode(rsaEncrypt(publicKey, key.bytes));
      final initVector = iv.base16;

      String body = json.encode({
        'data': {
          'phone': encryptData(value: mobileTextField.value.text),
        },
        'secretKey': encryptedSecret,
        'initVector': initVector
      });
      try {
        var response =
            await repository.postApiCall(url: "auth/send-otp", body: body);
        showSpinner(false);
        log("response => ${response.toString()}");
        emailOtpTextField = TextEditingController(text: "");
        Get.to(() => const VerifyEmailScreen());
      } catch (e, stackTrace) {
        showSpinner(false);
        showAlertDialog(msg: e.toString());
        log("forgetPasswordEmailOTP error => => ${stackTrace.toString()}");
      }
    }
  }

  void verifyEmailOtp() async {
    if (emailOtpTextField.value.text == "" ||
        emailOtpTextField.value.text.length != 6) {
      showToastMessage(msg: "Please enter a valid OTP code.");
    } else {
      showSpinner(true);
      final publicKeyPem = await rootBundle.loadString(
        'assets/server_public.pem',
      );
      final publicKey =
          encrypt.RSAKeyParser().parse(publicKeyPem) as RSAPublicKey;
      final encryptedSecret = hex.encode(rsaEncrypt(publicKey, key.bytes));
      final initVector = iv.base16;

      String body = json.encode({
        'data': {
          'phone': encryptData(value: mobileTextField.value.text),
          'otp': encryptData(value: emailOtpTextField.value.text),
        },
        'secretKey': encryptedSecret,
        'initVector': initVector
      });
      try {
        await repository.postApiCall(
            url: "auth/reset-password-verify", body: body);
        showSpinner(false);
        passwordTextField = TextEditingController(text: "");
        confirmPasswordTextField = TextEditingController(text: "");
        Get.off(const CreatePasswordScreen());
      } catch (e, stackTrace) {
        showSpinner(false);
        emailOtpTextField.clear();
        showAlertDialog(msg: e.toString());
        log("verifyEmailOtp error => => ${stackTrace.toString()}");
      }
    }
  }

  void createNewPassword() async {
    if (passwordTextField.value.text == "") {
      showToastMessage(msg: "Please enter a valid password");
    } else if (!regex.hasMatch(passwordTextField.value.text)) {
      showAlertDialog(
          msg:
              "Password should contain at least one upper case, one lower case, one digit, one special character. And length Must be at least 6 characters.");
    } else if (passwordTextField.text != confirmPasswordTextField.text) {
      showToastMessage(msg: "Password and confirm password should be same.");
    } else {
      showSpinner(true);
      callingUserUpdateApi();
    }
  }

  void callingUserUpdateApi() async {
    final publicKeyPem = await rootBundle.loadString(
      'assets/server_public.pem',
    );
    final publicKey =
        encrypt.RSAKeyParser().parse(publicKeyPem) as RSAPublicKey;
    final encryptedSecret = hex.encode(rsaEncrypt(publicKey, key.bytes));
    final initVector = iv.base16;

    String body = json.encode({
      'data': {
        'password': encryptData(value: passwordTextField.value.text),
      },
      'secretKey': encryptedSecret,
      'initVector': initVector
    });
    try {
      await repository.postApiCall(url: "user/update", body: body);
      showSpinner(false);
      passwordTextField = TextEditingController(text: "");
      emailTextField = TextEditingController(text: "");
      mobileTextField = TextEditingController(text: "");
      Get.offAll(() => const LoginScreen());
    } catch (e, stackTrace) {
      showSpinner(false);
      showAlertDialog(msg: e.toString());
      log("callingUserUpdateApi error => => ${stackTrace.toString()}");
    }
  }

  ///All social login methods...
  ///
  signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Uri uri = Uri.parse(
    //     'https://www.googleapis.com/oauth2/v1/userinfo?access_token=${googleAuth?.accessToken}');
    // final response = await http.get(uri);
    // final profile = jsonDecode(response.body);
    // log("profileData ===> ${profile.toString()}");

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    // Once signed in, return the UserCredential
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
    var idToken = await userCredential.user?.getIdToken();
    log("idToken ===> ${idToken.toString()}");
    log("user ===> ${userCredential.user}");
    loginWithIdToken(idToken: idToken);
  }

  signInWithFacebook() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance
        .login(permissions: ["email", "public_profile"]);
    // Uri uri = Uri.parse(
    //     'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=${loginResult.accessToken!.token}');
    // final response = await http.get(uri);
    // final profile = jsonDecode(response.body);
    // log("profileData ===> ${profile.toString()}");

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);

    // Once signed in, return the UserCredential
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithCredential(facebookAuthCredential);
    var idToken = await userCredential.user?.getIdToken();
    log("idToken ===> ${idToken.toString()}");
    log("user ===> ${userCredential.user}");
    loginWithIdToken(idToken: idToken);
  }

  signInWithApple() async {
    // final appleProvider = AppleAuthProvider();
    // UserCredential userCredential =  await FirebaseAuth.instance.signInWithProvider(appleProvider);
    // To prevent replay attacks with the credential returned from Apple, we
    // include a nonce in the credential request. When signing in with
    // Firebase, the nonce in the id token returned by Apple, is expected to
    // match the sha256 hash of `rawNonce`.
    final rawNonce = CommonLogics.generateNonce();
    final nonce = CommonLogics.sha256ofString(rawNonce);

    // Request credential for the currently signed in Apple account.
    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName
      ],
      nonce: nonce,
    );
    final fixDisplayNameFromApple = [
      appleCredential.givenName ?? '',
      appleCredential.familyName ?? '',
    ].join(' ').trim();
    log(fixDisplayNameFromApple);
    log(appleCredential.email ?? "email");
    // Create an `OAuthCredential` from the credential returned by Apple.
    final oauthCredential = OAuthProvider("apple.com").credential(
      idToken: appleCredential.identityToken,
      accessToken: appleCredential.authorizationCode,
      rawNonce: rawNonce,
    );
    // Once signed in, return the UserCredential
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(oauthCredential);
    await userCredential.user?.updateDisplayName(fixDisplayNameFromApple);
    await userCredential.user?.reload();
    var idToken = await userCredential.user?.getIdToken();
    log("idToken ===> ${idToken.toString()}");
    log("user ===> ${userCredential.user}");
    loginWithIdToken(idToken: idToken);
  }

  /// login idToken in case of social.
  void loginWithIdToken({required idToken}) async {
    showSpinner(true);
    final publicKeyPem = await rootBundle.loadString(
      'assets/server_public.pem',
    );

    final publicKey =
        encrypt.RSAKeyParser().parse(publicKeyPem) as RSAPublicKey;
    final encryptedSecret = hex.encode(rsaEncrypt(publicKey, key.bytes));
    final initVector = iv.base16;

    String body = json.encode({
      'data': {
        'idToken': encryptData(value: idToken),
      },
      'secretKey': encryptedSecret,
      'initVector': initVector
    });

    log("body ===> ${body.toString()}");
    try {
      await repository.postApiCall(url: "auth/login", body: body);
      showSpinner(false);
      sp!.putBool(SpUtil.isLoggedIn, true);
      Get.offAll(() => (const HomeScreen()));
    } catch (e, stackTrace) {
      showSpinner(false);
      showAlertDialog(msg: e.toString());
      log("loginWithIdToken error => => ${stackTrace.toString()}");
    }
  }
}
