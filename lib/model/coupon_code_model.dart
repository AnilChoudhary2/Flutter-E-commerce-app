import 'package:get/get.dart';

class CouponCodeModel {
  String? couponCode;
  String? codeValue;
  String? offerValue;
  RxBool? isSelected = false.obs;

  CouponCodeModel(
      {this.couponCode, this.codeValue, this.offerValue, this.isSelected});
}
