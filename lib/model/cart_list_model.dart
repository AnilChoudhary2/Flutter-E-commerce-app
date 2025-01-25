import 'package:yahmart/model/product_details_model.dart';

class CartListModel {
  String? productSkuId;
  int? userId;
  int? quantity;
  int? salePrice;
  ProductVariant? productVariant;
  String? createdDate;

  CartListModel(
      {this.productSkuId,
      this.userId,
      this.quantity,
      this.salePrice,
      this.productVariant,
      this.createdDate});

  CartListModel.fromJson(Map<String, dynamic> json) {
    productSkuId = json['productSkuId'];
    userId = json['userId'];
    quantity = json['quantity'];
    salePrice = json['salePrice'];
    productVariant = json['productVariant'] != null
        ? ProductVariant.fromJson(json['productVariant'])
        : null;
    createdDate = json['createdDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['productSkuId'] = productSkuId;
    data['userId'] = userId;
    data['quantity'] = quantity;
    data['salePrice'] = salePrice;
    if (productVariant != null) {
      data['productVariant'] = productVariant!.toJson();
    }
    data['createdDate'] = createdDate;
    return data;
  }
}

class ProductVariant {
  String? productSkuId;
  Product? product;
  List<Attributes>? attributes;
  int? basePrice;
  int? salePrice;
  int? availableStock;
  String? barCode;
  List<Images>? images;
  ShippingRequirements? shippingRequirements;

  ProductVariant(
      {this.productSkuId,
      this.product,
      this.attributes,
      this.basePrice,
      this.salePrice,
      this.availableStock,
      this.barCode,
      this.images,
      this.shippingRequirements});

  ProductVariant.fromJson(Map<String, dynamic> json) {
    productSkuId = json['productSkuId'];
    product =
        json['product'] != null ? Product.fromJson(json['product']) : null;
    if (json['attributes'] != null) {
      attributes = <Attributes>[];
      json['attributes'].forEach((v) {
        attributes!.add(Attributes.fromJson(v));
      });
    }
    basePrice = json['basePrice'];
    salePrice = json['salePrice'];
    availableStock = json['availableStock'];
    barCode = json['barCode'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(Images.fromJson(v));
      });
    }
    shippingRequirements = json['shippingRequirements'] != null
        ? ShippingRequirements.fromJson(json['shippingRequirements'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['productSkuId'] = productSkuId;
    if (product != null) {
      data['product'] = product!.toJson();
    }
    if (attributes != null) {
      data['attributes'] = attributes!.map((v) => v.toJson()).toList();
    }
    data['basePrice'] = basePrice;
    data['salePrice'] = salePrice;
    data['availableStock'] = availableStock;
    data['barCode'] = barCode;
    if (images != null) {
      data['images'] = images!.map((v) => v.toJson()).toList();
    }
    if (shippingRequirements != null) {
      data['shippingRequirements'] = shippingRequirements!.toJson();
    }
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
  bool? isReapproved;
  String? productBannerImage;
  String? productType;
  String? createdDate;
  String? updatedDate;

  Product(
      {this.productId,
      this.productName,
      this.productDescription,
      this.isPublic,
      this.isArchive,
      this.isRejected,
      this.isReapproved,
      this.productBannerImage,
      this.productType,
      this.createdDate,
      this.updatedDate});

  Product.fromJson(Map<String, dynamic> json) {
    productId = json['productId'];
    productName = json['productName'];
    productDescription = json['productDescription'];
    isPublic = json['isPublic'];
    isArchive = json['isArchive'];
    isRejected = json['isRejected'];
    isReapproved = json['isReapproved'];
    productBannerImage = json['productBannerImage'];
    productType = json['productType'];
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
    data['isReapproved'] = isReapproved;
    data['productBannerImage'] = productBannerImage;
    data['productType'] = productType;
    data['createdDate'] = createdDate;
    data['updatedDate'] = updatedDate;
    return data;
  }
}
