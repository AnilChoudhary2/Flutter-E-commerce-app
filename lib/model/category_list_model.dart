import 'package:get/get.dart';

class CategoryListModel {
  String? categoryId;
  String? categoryName;
  bool? isPublic;
  bool? isVisible;
  String? categoryBannerImage;
  List<SubCategory>? subCategories;
  RxBool? isSelected = false.obs;

  CategoryListModel(
      {this.categoryId,
      this.categoryName,
      this.isPublic,
      this.isVisible,
      this.categoryBannerImage,
      this.subCategories,
      this.isSelected});

  CategoryListModel.fromJson(Map<String, dynamic> json) {
    categoryId = json['categoryId'];
    categoryName = json['categoryName'];
    isPublic = json['isPublic'];
    isVisible = json['isVisible'];
    categoryBannerImage = json['categoryBannerImage'];
    if (json['subCategories'] != null) {
      subCategories = <SubCategory>[];
      json['subCategories'].forEach((v) {
        subCategories!.add(SubCategory.fromJson(v));
      });
    }
    isSelected!.value = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['categoryId'] = categoryId;
    data['categoryName'] = categoryName;
    data['isPublic'] = isPublic;
    data['isVisible'] = isVisible;
    data['categoryBannerImage'] = categoryBannerImage;
    if (subCategories != null) {
      data['subCategories'] = subCategories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubCategory {
  String? categoryId;
  String? categoryName;
  bool? isPublic;
  bool? isVisible;
  String? categoryBannerImage;

  SubCategory(
      {this.categoryId,
      this.categoryName,
      this.isPublic,
      this.isVisible,
      this.categoryBannerImage});

  SubCategory.fromJson(Map<String, dynamic> json) {
    categoryId = json['categoryId'];
    categoryName = json['categoryName'];
    isPublic = json['isPublic'];
    isVisible = json['isVisible'];
    categoryBannerImage = json['categoryBannerImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['categoryId'] = categoryId;
    data['categoryName'] = categoryName;
    data['isPublic'] = isPublic;
    data['isVisible'] = isVisible;
    data['categoryBannerImage'] = categoryBannerImage;
    return data;
  }
}
