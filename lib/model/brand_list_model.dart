import 'package:get/get.dart';

class BrandListModel {
  String? brandId;
  int? creatorId;
  String? brandName;
  String? brandImageUrl;
  RxBool? isSelected = false.obs;

  BrandListModel(
      {this.brandId,
      this.creatorId,
      this.brandName,
      this.brandImageUrl,
      this.isSelected});

  BrandListModel.fromJson(Map<String, dynamic> json) {
    brandId = json['brandId'];
    creatorId = json['creatorId'];
    brandName = json['brandName'];
    brandImageUrl = json['brandImageUrl'];
    isSelected!.value = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['brandId'] = brandId;
    data['creatorId'] = creatorId;
    data['brandName'] = brandName;
    data['brandImageUrl'] = brandImageUrl;
    return data;
  }
}
