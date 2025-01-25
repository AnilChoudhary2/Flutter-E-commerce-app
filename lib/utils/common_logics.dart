import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:yahmart/screens/auth/login_screen.dart';
import 'package:yahmart/utils/common_colors.dart';
import 'package:yahmart/utils/shared_preferences.dart';
import '../main.dart';

class CommonLogics {
  ///user logout.
  static void logOut() {
    sp!.clear();
    Get.deleteAll();
    Get.offAll(() => const LoginScreen());
  }

  static bool checkUserLogin() {
    bool isLoggedIn = sp!.getBool(SpUtil.isLoggedIn) ?? false;
    if (isLoggedIn) {
      return true;
    } else {
      return false;
    }
  }

  /// get product old price.
  // static String getProductOldPrice({required int price, required double discount}) {
  //   double? oldPrice;
  //   oldPrice = price + (price / discount);
  //   return convertValueInThousandFormat(inputString: oldPrice.toStringAsFixed(0).toString());;
  // }

  /// calculate discount.
  static String getCalculatedDiscount(
      {required int basePrice, required int salePrice}) {
    String? discount;
    // discount = ((basePrice - salePrice) / 100).toString();
    discount = (100 * (basePrice - salePrice) / basePrice).toStringAsFixed(0);
    return discount != "NaN" ? discount : "0";
  }

  /// convert value in thousand format
  static String convertValueInThousandFormat({required String inputString}) {
    final f = NumberFormat.decimalPattern('hi');

    return f.format(double.parse(inputString));
    // if (inputString.isEmpty) {
    //   return "0";
    // }
    // inputString = inputString.replaceAll(",", "");
    // RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    // mathFunc(Match match) => '${match[1]},';
    // String result = removeDecimalZeroFormat(double.parse(inputString))
    //     .replaceAllMapped(reg, mathFunc);
    // return result;
  }

  static String removeDecimalZeroFormat(double n) {
    return n.toStringAsFixed(n.truncateToDouble() == n ? 0 : 2);
  }

  static int getRandomColor(int position) {
    int? color;
    if (position % 4 == 0) {
      color = CommonColors.randomClr1;
    } else if (position % 4 == 1) {
      color = CommonColors.randomClr2;
    } else if (position % 4 == 2) {
      color = CommonColors.randomClr3;
    } else if (position % 4 == 3) {
      color = CommonColors.randomClr4;
    }
    return color!;
  }

  static String runeSubstring([String? input, int? start, int? end]) {
    return String.fromCharCodes(
      input!.runes.toList().sublist(
            start!,
            end,
          ),
    );
  }

  static String toTitleCase(String value) {
    return "${value[0].toUpperCase()}${value.substring(1).toLowerCase()}";
  }

  static int randomNumber() {
    var rng = Random();
    return rng.nextInt(90000000);
  }

  static String getDateFromUtc(String utcDate, String pattern) {
    var strToDateTime = DateTime.parse(utcDate.toString());
    final convertLocal = strToDateTime.toLocal();
    var newFormat = DateFormat(pattern);
    String updatedDt = newFormat.format(convertLocal);
    return updatedDt;
  }

  /// Generates a cryptographically secure random nonce, to be included in a
  /// credential request.
  static String generateNonce([int length = 32]) {
    const charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  /// Returns the sha256 hash of [input] in hex notation.
  static String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  static Future<void> saveAndShare(String imageUrl, String contents) async {
    final RenderBox? box = Get.context?.findRenderObject() as RenderBox?;
    Uri url = Uri.parse(imageUrl);
    if (Platform.isAndroid) {
      var response = await get(url);
      final documentDirectory = (await getExternalStorageDirectory())!.path;
      File imgFile = File('$documentDirectory/demo.png');
      imgFile.writeAsBytesSync(response.bodyBytes);
      Share.shareXFiles([XFile('$documentDirectory/demo.png')],
          subject: 'Yahmart India',
          text: contents,
          sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
    } else {
      var response = await get(url);
      final documentDirectory = (await getApplicationDocumentsDirectory()).path;
      File imgFile = File('$documentDirectory/demo.png');
      imgFile.writeAsBytesSync(response.bodyBytes);
      Share.shareXFiles([XFile('$documentDirectory/demo.png')],
          subject: 'Yahmart India',
          text: contents,
          sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
    }
  }

  static String getDeliveryStatus({required String? status}) {
    String? returnStatus;
    switch (status) {
      case "PENDING":
        returnStatus = "PENDING";
        break;
      case "FAILED":
        returnStatus = "FAILED";
        break;
      case "PAYMENT_COMPLETE":
        returnStatus = "PAYMENT COMPLETE";
        break;
      case "CANCELLED":
        returnStatus = "CANCELLED";
        break;
      case "OUT_FOR_DELIVERY":
        returnStatus = "OUT FOR DELIVERY";
        break;
      case "DELIVEREY_COMPLETE":
        returnStatus = "DELIVERY COMPLETE";
        break;
      case "USER_REPLACE_REQUESTED":
        returnStatus = "REPLACE REQUESTED";
        break;
      case "VENDOR_REPLACE_ACKNOWLEDGED":
        returnStatus = "REPLACE ACKNOWLEDGED";
        break;
      case "OUT_FOR_REPLACEMENT":
        returnStatus = "OUT FOR REPLACEMENT";
        break;
      case "REPLACEMENT_ACCEPTED":
        returnStatus = "REPLACEMENT ACCEPTED";
        break;
      case "OUT_FOR_REPLACEMENT_DELIVERY":
        returnStatus = "OUT FOR REPLACEMENT DELIVERY";
        break;
      case "REPLACEMENT_COMPLETE":
        returnStatus = "REPLACEMENT COMPLETE";
        break;
      case "RETURN_REQUESTED":
        returnStatus = "RETURN REQUESTED";
        break;
      case "RETURN_ACKNOWLEDGED":
        returnStatus = "RETURN ACKNOWLEDGED";
        break;
      case "RETURN_ACCEPTED":
        returnStatus = "RETURN ACCEPTED";
        break;
      case "RETURN_COMPLETE":
        returnStatus = "RETURN COMPLETE";
        break;
      default:
        returnStatus = "";
    }
    return returnStatus;
  }
}
