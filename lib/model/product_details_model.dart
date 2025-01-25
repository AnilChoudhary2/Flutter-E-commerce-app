import 'package:get/get.dart';

class ProductDetailsModel {
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
  List<AttributeOptions>? attributeOptions;

  ProductDetailsModel(
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
      this.attributeOptions});

  ProductDetailsModel.fromJson(Map<String, dynamic> json) {
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
    if (json['attributeOptions'] != null) {
      attributeOptions = <AttributeOptions>[];
      json['attributeOptions'].forEach((v) {
        attributeOptions!.add(AttributeOptions.fromJson(v));
      });
    }
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
    if (attributeOptions != null) {
      data['attributeOptions'] =
          attributeOptions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Vendor {
  int? userId;
  String? email;
  String? phone;
  bool? isTwoFactorEnabled;
  bool? isActive;
  String? displayName;
  String? avatarUrl;
  String? createdDate;
  String? updatedDate;

  Vendor(
      {this.userId,
      this.email,
      this.phone,
      this.isTwoFactorEnabled,
      this.isActive,
      this.displayName,
      this.avatarUrl,
      this.createdDate,
      this.updatedDate});

  Vendor.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    email = json['email'];
    phone = json['phone'];
    isTwoFactorEnabled = json['isTwoFactorEnabled'];
    isActive = json['isActive'];
    displayName = json['displayName'];
    avatarUrl = json['avatarUrl'];
    createdDate = json['createdDate'];
    updatedDate = json['updatedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['email'] = email;
    data['phone'] = phone;
    data['isTwoFactorEnabled'] = isTwoFactorEnabled;
    data['isActive'] = isActive;
    data['displayName'] = displayName;
    data['avatarUrl'] = avatarUrl;
    data['createdDate'] = createdDate;
    data['updatedDate'] = updatedDate;
    return data;
  }
}

class Brand {
  String? brandId;
  int? creatorId;
  String? brandName;
  String? brandImageUrl;

  Brand({this.brandId, this.creatorId, this.brandName, this.brandImageUrl});

  Brand.fromJson(Map<String, dynamic> json) {
    brandId = json['brandId'];
    creatorId = json['creatorId'];
    brandName = json['brandName'];
    brandImageUrl = json['brandImageUrl'];
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

class Category {
  String? categoryId;
  String? categoryName;
  bool? isPublic;
  bool? isVisible;
  String? categoryBannerImage;

  Category(
      {this.categoryId,
      this.categoryName,
      this.isPublic,
      this.isVisible,
      this.categoryBannerImage});

  Category.fromJson(Map<String, dynamic> json) {
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

class Variants {
  String? productSkuId;
  List<Attributes>? attributes;
  int? basePrice;
  int? salePrice;
  int? availableStock;
  String? barCode;
  List<Images>? images;
  ShippingRequirements? shippingRequirements;

  Variants(
      {this.productSkuId,
      this.attributes,
      this.basePrice,
      this.salePrice,
      this.availableStock,
      this.barCode,
      this.images,
      this.shippingRequirements});

  Variants.fromJson(Map<String, dynamic> json) {
    productSkuId = json['productSkuId'];
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

class Attributes {
  String? attributeValue;
  String? attributeName;
  int? attributeId;

  Attributes({this.attributeValue, this.attributeName, this.attributeId});

  Attributes.fromJson(Map<String, dynamic> json) {
    attributeValue = json['attributeValue'];
    attributeName = json['attributeName'];
    attributeId = json['attributeId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['attributeValue'] = attributeValue;
    data['attributeName'] = attributeName;
    data['attributeId'] = attributeId;
    return data;
  }
}

class Images {
  String? productSkuId;
  String? variantImage;

  Images({this.productSkuId, this.variantImage});

  Images.fromJson(Map<String, dynamic> json) {
    productSkuId = json['productSkuId'];
    variantImage = json['variantImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['productSkuId'] = productSkuId;
    data['variantImage'] = variantImage;
    return data;
  }
}

class ShippingRequirements {
  int? height;
  int? width;
  int? length;
  int? weight;

  ShippingRequirements({this.height, this.width, this.length, this.weight});

  ShippingRequirements.fromJson(Map<String, dynamic> json) {
    height = int.parse(json['height'].floor().toString());
    width = int.parse(json['width'].floor().toString());
    length = int.parse(json['length'].floor().toString());
    weight = int.parse(json['weight'].floor().toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['height'] = height;
    data['width'] = width;
    data['length'] = length;
    data['weight'] = weight;
    return data;
  }
}

class Gallery {
  String? productId;
  String? productImage;

  Gallery({this.productId, this.productImage});

  Gallery.fromJson(Map<String, dynamic> json) {
    productId = json['productId'];
    productImage = json['productImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['productId'] = productId;
    data['productImage'] = productImage;
    return data;
  }
}

class AttributeOptions {
  String? attributeName;
  RxString? selectedAttribute = "".obs;
  List<String>? attributeOptions;

  AttributeOptions({this.attributeName, this.attributeOptions});

  AttributeOptions.fromJson(Map<String, dynamic> json) {
    attributeName = json['attributeName'];
    attributeOptions = json['attributeOptions'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['attributeName'] = attributeName;
    data['attributeOptions'] = attributeOptions;
    return data;
  }
}
