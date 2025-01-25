import 'package:get/get.dart';

class PriceRangeModel {
  int? minPrice;
  int? maxPrice;
  RxBool? isSelected = false.obs;

  PriceRangeModel({this.minPrice, this.maxPrice, this.isSelected});
}
