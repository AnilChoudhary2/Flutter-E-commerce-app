class OrderListModel {
  String? orderItemId;
  Order? order;
  ProductVariant? productVariant;
  int? quantity;
  int? salePrice;
  String? status;
  int? totalCount;

  OrderListModel(
      {this.orderItemId,
      this.order,
      this.productVariant,
      this.quantity,
      this.salePrice,
      this.status,
      this.totalCount});

  OrderListModel.fromJson(Map<String, dynamic> json) {
    orderItemId = json['orderItemId'];
    order = json['order'] != null ? Order.fromJson(json['order']) : null;
    productVariant = json['productVariant'] != null
        ? ProductVariant.fromJson(json['productVariant'])
        : null;
    quantity = json['quantity'];
    salePrice = json['salePrice'];
    status = json['status'];
    totalCount = json['totalCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['orderItemId'] = orderItemId;
    if (order != null) {
      data['order'] = order!.toJson();
    }
    if (productVariant != null) {
      data['productVariant'] = productVariant!.toJson();
    }
    data['quantity'] = quantity;
    data['salePrice'] = salePrice;
    data['status'] = status;
    data['totalCount'] = totalCount;
    return data;
  }
}

class Order {
  String? orderId;
  ShippingAddress? shippingAddress;
  ShippingAddress? billingAddress;
  String? status;
  String? createdDate;
  String? deliveryDate;

  Order(
      {this.orderId,
      this.shippingAddress,
      this.billingAddress,
      this.status,
      this.createdDate,
      this.deliveryDate});

  Order.fromJson(Map<String, dynamic> json) {
    orderId = json['orderId'];
    shippingAddress = json['shippingAddress'] != null
        ? ShippingAddress.fromJson(json['shippingAddress'])
        : null;
    billingAddress = json['billingAddress'] != null
        ? ShippingAddress.fromJson(json['billingAddress'])
        : null;
    status = json['status'];
    createdDate = json['createdDate'];
    deliveryDate = json['deliveryDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['orderId'] = orderId;
    if (shippingAddress != null) {
      data['shippingAddress'] = shippingAddress!.toJson();
    }
    if (billingAddress != null) {
      data['billingAddress'] = billingAddress!.toJson();
    }
    data['status'] = status;
    data['createdDate'] = createdDate;
    data['deliveryDate'] = deliveryDate;
    return data;
  }
}

class ShippingAddress {
  String? addressId;
  String? houseNumber;
  String? streetName;
  String? state;
  String? city;
  String? country;
  String? addressKind;
  String? pincode;
  double? latitude;
  double? longitude;
  String? addressType;
  String? addressText;
  String? deletedAt;

  ShippingAddress(
      {this.addressId,
      this.houseNumber,
      this.streetName,
      this.state,
      this.city,
      this.country,
      this.addressKind,
      this.pincode,
      this.latitude,
      this.longitude,
      this.addressType,
      this.addressText,
      this.deletedAt});

  ShippingAddress.fromJson(Map<String, dynamic> json) {
    addressId = json['addressId'];
    houseNumber = json['houseNumber'];
    streetName = json['streetName'];
    state = json['state'];
    city = json['city'];
    country = json['country'];
    addressKind = json['addressKind'];
    pincode = json['pincode'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    addressType = json['addressType'];
    addressText = json['addressText'];
    deletedAt = json['deletedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['addressId'] = addressId;
    data['houseNumber'] = houseNumber;
    data['streetName'] = streetName;
    data['state'] = state;
    data['city'] = city;
    data['country'] = country;
    data['addressKind'] = addressKind;
    data['pincode'] = pincode;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['addressType'] = addressType;
    data['addressText'] = addressText;
    data['deletedAt'] = deletedAt;
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

  ProductVariant(
      {this.productSkuId,
      this.product,
      this.attributes,
      this.basePrice,
      this.salePrice,
      this.availableStock,
      this.barCode});

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
