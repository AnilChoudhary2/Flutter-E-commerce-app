class ProductWishlistModel {
  String? productSkuId;
  Product? product;
  int? basePrice;
  int? salePrice;
  int? availableStock;
  String? barCode;

  ProductWishlistModel(
      {this.productSkuId,
      this.product,
      this.basePrice,
      this.salePrice,
      this.availableStock,
      this.barCode});

  ProductWishlistModel.fromJson(Map<String, dynamic> json) {
    productSkuId = json['productSkuId'];
    product =
        json['product'] != null ? Product.fromJson(json['product']) : null;
    basePrice = json['basePrice'];
    salePrice = json['salePrice'];
    availableStock = json['availableStock'];
    barCode = json['barCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['productSkuId'] = productSkuId;
    if (product != null) {
      data['product'] = product!.toJson();
    }
    data['basePrice'] = basePrice;
    data['salePrice'] = salePrice;
    data['availableStock'] = availableStock;
    data['barCode'] = barCode;
    return data;
  }
}

class Product {
  String? productId;
  String? productName;
  String? productDescription;
  bool? isPublic;
  bool? isArchive;
  bool? isRejected;
  String? productBannerImage;
  String? productType;
  num? avgRating;
  num? ratingCount;
  String? createdDate;
  String? updatedDate;

  Product(
      {this.productId,
      this.productName,
      this.productDescription,
      this.isPublic,
      this.isArchive,
      this.isRejected,
      this.productBannerImage,
      this.productType,
      this.avgRating,
      this.ratingCount,
      this.createdDate,
      this.updatedDate});

  Product.fromJson(Map<String, dynamic> json) {
    productId = json['productId'];
    productName = json['productName'];
    productDescription = json['productDescription'];
    isPublic = json['isPublic'];
    isArchive = json['isArchive'];
    isRejected = json['isRejected'];
    productBannerImage = json['productBannerImage'];
    productType = json['productType'];
    avgRating = json['avgRating'];
    ratingCount = json['ratingCount'];
    createdDate = json['createdDate'];
    updatedDate = json['updatedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['productId'] = productId;
    data['productName'] = productName;
    data['productDescription'] = productDescription;
    data['isPublic'] = isPublic;
    data['isArchive'] = isArchive;
    data['isRejected'] = isRejected;
    data['productBannerImage'] = productBannerImage;
    data['productType'] = productType;
    data['avgRating'] = avgRating;
    data['ratingCount'] = ratingCount;
    data['createdDate'] = createdDate;
    data['updatedDate'] = updatedDate;
    return data;
  }
}
