import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/common_colors.dart';

void showLoaderDialog() {
  showDialog(
    context: Get.context!,
    barrierDismissible: false,
    builder: (context) {
      return WillPopScope(
        onWillPop: () async => false,
        child: Container(
          color: Colors.grey.withOpacity(.3),
          child: Center(
            child: CircularProgressIndicator(
              color: CommonColors.appColor,
            ),
          ),
        ),
      );
    },
  );
}

void hideLoaderDialog() {
  try {
    Navigator.of(Get.context!).pop(true);
  } catch (e) {
    debugPrint("error => $e");
  }
}
