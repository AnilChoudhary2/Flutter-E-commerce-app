import 'package:get/get.dart';

class ProductSortingModel {
  String? name;
  String? keyValue;
  RxBool? isSelected = false.obs;

  ProductSortingModel({this.name, this.keyValue, this.isSelected});
}
