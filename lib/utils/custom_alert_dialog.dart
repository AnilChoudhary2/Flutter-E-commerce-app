import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yahmart/utils/screen_constants.dart';
import 'common_colors.dart';

showToastMessage({String? msg}) {
  Get.closeAllSnackbars();
  Get.rawSnackbar(
    message: msg,
    backgroundColor: CommonColors.appColor,
  );
}

showAlertDialog({String? msg}) {
  AlertDialog alert = AlertDialog(
    contentPadding: EdgeInsets.zero,
    content: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Text(
        msg!.contains("Exception") ? msg.replaceAll("Exception: ", "") : msg,
        style: TextStyle(
            color: CommonColors.blackColor,
            fontWeight: FontWeight.normal,
            fontSize: 13),
      ),
    ),
    //insetPadding: const EdgeInsets.all(10),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    actions: [
      GestureDetector(
        onTap: () {
          Get.back();
        },
        child: Container(
          alignment: Alignment.center,
          height: ScreenConstant.size30,
          width: ScreenConstant.size80,
          decoration: BoxDecoration(
              color: CommonColors.appColor,
              borderRadius: BorderRadius.circular(10)),
          child: Text(
            "Ok",
            textAlign: TextAlign.center,
            style: TextStyle(color: CommonColors.whiteColor),
          ),
        ),
      ),
    ],
  );
  showDialog(
    context: Get.context!,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

showAlertDialogOnPressed(
    {required String? msg, required Function()? onPressed}) {
  AlertDialog alert = AlertDialog(
    contentPadding: EdgeInsets.zero,
    titlePadding: const EdgeInsets.only(top: 10),

    title: Text(
      "Yahmart",
      textAlign: TextAlign.center,
      style: TextStyle(
          color: CommonColors.blackColor,
          fontWeight: FontWeight.bold,
          fontSize: 16),
    ),
    content: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Text(
        msg!,
        textAlign: TextAlign.center,
        style: TextStyle(
            color: CommonColors.blackColor,
            fontWeight: FontWeight.normal,
            fontSize: 13),
      ),
    ),
    //insetPadding: const EdgeInsets.all(10),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    actionsAlignment: MainAxisAlignment.center,
    actionsPadding: const EdgeInsets.only(bottom: 12),
    actions: [
      GestureDetector(
        onTap: onPressed,
        child: Container(
          alignment: Alignment.center,
          height: ScreenConstant.size30,
          width: ScreenConstant.size80,
          decoration: BoxDecoration(
              color: CommonColors.appColor,
              borderRadius: BorderRadius.circular(10)),
          child: Text(
            "Yes",
            textAlign: TextAlign.center,
            style: TextStyle(color: CommonColors.whiteColor),
          ),
        ),
      ),
      GestureDetector(
        onTap: () {
          Get.back();
        },
        child: Container(
          alignment: Alignment.center,
          height: ScreenConstant.size30,
          width: ScreenConstant.size80,
          decoration: BoxDecoration(
              color: CommonColors.appColor,
              borderRadius: BorderRadius.circular(10)),
          child: Text(
            "No",
            textAlign: TextAlign.center,
            style: TextStyle(color: CommonColors.whiteColor),
          ),
        ),
      ),
    ],
  );
  showDialog(
    context: Get.context!,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

noInternetDialog({required Function() onRetry}) {
  showDialog(
    context: Get.context!,
    barrierDismissible: false,
    builder: (ctx) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: const Text('No Internet Connection.'),
      content: const Text('Please check your internet connection and try.'),
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: CommonColors.appColor,
            fixedSize: const Size.fromWidth(100),
            padding: const EdgeInsets.all(10),
          ),
          child: const Text("Retry"),
          onPressed: () {
            Get.back();
            onRetry();
          },
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: CommonColors.appColor,
            fixedSize: const Size.fromWidth(100),
            padding: const EdgeInsets.all(10),
          ),
          child: const Text("Ok"),
          onPressed: () {
            Get.back();
          },
        )
      ],
    ),
  );
}

// showLoginAlertDialog() {
//   AlertDialog alert = AlertDialog(
//     contentPadding: EdgeInsets.zero,
//     titlePadding: const EdgeInsets.only(top: 10),
//     title: Text(
//       "Yahmart",
//       textAlign: TextAlign.center,
//       style: TextStyle(
//           color: CommonColors.blackColor,
//           fontWeight: FontWeight.bold,
//           fontSize: 16),
//     ),
//     content: Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
//       child: Text(
//         "Login to continue...",
//         textAlign: TextAlign.center,
//         style: TextStyle(
//             color: CommonColors.blackColor,
//             fontWeight: FontWeight.normal,
//             fontSize: 13),
//       ),
//     ),
//     //insetPadding: const EdgeInsets.all(10),
//     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//     actionsAlignment: MainAxisAlignment.center,
//     actionsPadding: const EdgeInsets.only(bottom: 12),
//     actions: [
//       GestureDetector(
//         onTap: () {
//           Get.back();
//           Get.offAll(() => const LoginScreen());
//         },
//         child: Container(
//           alignment: Alignment.center,
//           height: ScreenConstant.size30,
//           width: ScreenConstant.size80,
//           decoration: BoxDecoration(
//               color: CommonColors.appColor,
//               borderRadius: BorderRadius.circular(10)),
//           child: Text(
//             "Login",
//             textAlign: TextAlign.center,
//             style: TextStyle(color: CommonColors.whiteColor),
//           ),
//         ),
//       ),
//       GestureDetector(
//         onTap: () {
//           Get.back();
//         },
//         child: Container(
//           alignment: Alignment.center,
//           height: ScreenConstant.size30,
//           width: ScreenConstant.size80,
//           decoration: BoxDecoration(
//               color: CommonColors.appColor,
//               borderRadius: BorderRadius.circular(10)),
//           child: Text(
//             "Cancel",
//             textAlign: TextAlign.center,
//             style: TextStyle(color: CommonColors.whiteColor),
//           ),
//         ),
//       ),
//     ],
//   );
//   showDialog(
//     context: Get.context!,
//     builder: (BuildContext context) {
//       return alert;
//     },
//   );
// }

void showPopupMenu() async {
  await showMenu(
    context: Get.context!,
    position: const RelativeRect.fromLTRB(10, 90, 100, 100),
    items: [
      PopupMenuItem(
        value: 1,
        child: Text(
          "Logout",
          style: TextStyle(color: CommonColors.blackColor, fontSize: 14),
        ),
      ),
      PopupMenuItem(
        value: 2,
        child: Text(
          "Sign Up",
          style: TextStyle(color: CommonColors.blackColor, fontSize: 14),
        ),
      ),
    ],
    elevation: 8.0,
  ).then((value) {
    if (value != null) {}
  });
}
