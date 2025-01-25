import 'package:get/get.dart';
import 'package:yahmart/model/product_details_model.dart';

class ProductListModel {
  String? productId;
  Vendor? vendor;
  String? productName;
  String? productDescription;
  Brand? brand;
  Category? category;
  bool? isPublic;
  bool? isArchive;
  bool? isRejected;
  bool? isReapproved;
  String? productBannerImage;
  String? productType;
  num? avgRating;
  num? ratingCount;
  List<Variants>? variants;
  List<Gallery>? gallery;
  List<String>? tags;
  String? createdDate;
  String? updatedDate;
  RxBool? isWishlisted = false.obs;
  int? totalCount;

  ProductListModel(
      {this.productId,
      this.vendor,
      this.productName,
      this.productDescription,
      this.brand,
      this.category,
      this.isPublic,
      this.isArchive,
      this.isRejected,
      this.isReapproved,
      this.productBannerImage,
      this.productType,
      this.avgRating,
      this.ratingCount,
      this.variants,
      this.gallery,
      this.tags,
      this.createdDate,
      this.updatedDate,
      this.isWishlisted,
      this.totalCount});

  ProductListModel.fromJson(Map<String, dynamic> json) {
    productId = json['productId'];
    vendor = json['vendor'] != null ? Vendor.fromJson(json['vendor']) : null;
    productName = json['productName'];
    productDescription = json['productDescription'];
    brand = json['brand'] != null ? Brand.fromJson(json['brand']) : null;
    category =
        json['category'] != null ? Category.fromJson(json['category']) : null;
    isPublic = json['isPublic'];
    isArchive = json['isArchive'];
    isRejected = json['isRejected'];
    isReapproved = json['isReapproved'];
    productBannerImage = json['productBannerImage'];
    productType = json['productType'];
    avgRating = json['avgRating'];
    ratingCount = json['ratingCount'];
    if (json['variants'] != null) {
      variants = <Variants>[];
      json['variants'].forEach((v) {
        variants!.add(Variants.fromJson(v));
      });
    }
    if (json['gallery'] != null) {
      gallery = <Gallery>[];
      json['gallery'].forEach((v) {
        gallery!.add(Gallery.fromJson(v));
      });
    }
    tags = json['tags'].cast<String>();
    createdDate = json['createdDate'];
    updatedDate = json['updatedDate'];
    isWishlisted!.value = json['isWishlisted'];
    totalCount = json['totalCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['productId'] = productId;
    if (vendor != null) {
      data['vendor'] = vendor!.toJson();
    }
    data['productName'] = productName;
    data['productDescription'] = productDescription;
    if (brand != null) {
      data['brand'] = brand!.toJson();
    }
    if (category != null) {
      data['category'] = category!.toJson();
    }
    data['isPublic'] = isPublic;
    data['isArchive'] = isArchive;
    data['isRejected'] = isRejected;
    data['isReapproved'] = isReapproved;
    data['productBannerImage'] = productBannerImage;
    data['productType'] = productType;
    data['avgRating'] = avgRating;
    data['ratingCount'] = ratingCount;
    if (variants != null) {
      data['variants'] = variants!.map((v) => v.toJson()).toList();
    }
    if (gallery != null) {
      data['gallery'] = gallery!.map((v) => v.toJson()).toList();
    }
    data['tags'] = tags;
    data['createdDate'] = createdDate;
    data['updatedDate'] = updatedDate;
    data['isWishlisted'] = isWishlisted!.value;
    data['totalCount'] = totalCount;
    return data;
  }
}
