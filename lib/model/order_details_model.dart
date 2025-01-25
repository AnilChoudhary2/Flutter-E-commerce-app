import 'package:get/get.dart';

class OrderDetailsModel {
  String? orderItemId;
  Order? order;
  ProductVariant? productVariant;
  int? quantity;
  int? salePrice;
  RxString? status = "".obs;

  OrderDetailsModel(
      {this.orderItemId,
      this.order,
      this.productVariant,
      this.quantity,
      this.salePrice,
      this.status});

  OrderDetailsModel.fromJson(Map<String, dynamic> json) {
    orderItemId = json['orderItemId'];
    order = json['order'] != null ? Order.fromJson(json['order']) : null;
    productVariant = json['productVariant'] != null
        ? ProductVariant.fromJson(json['productVariant'])
        : null;
    quantity = json['quantity'];
    salePrice = json['salePrice'];
    status!.value = json['status'] ?? "";
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
    data['status'] = status!.value;
    return data;
  }
}

class Order {
  String? orderId;
  User? user;
  ShippingAddress? shippingAddress;
  ShippingAddress? billingAddress;
  Transaction? transaction;
  String? status;
  String? paymentType;
  String? createdDate;
  String? deliveryDate;

  Order(
      {this.orderId,
      this.user,
      this.shippingAddress,
      this.billingAddress,
      this.transaction,
      this.status,
      this.paymentType,
      this.createdDate,
      this.deliveryDate});

  Order.fromJson(Map<String, dynamic> json) {
    orderId = json['orderId'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    shippingAddress = json['shippingAddress'] != null
        ? ShippingAddress.fromJson(json['shippingAddress'])
        : null;
    billingAddress = json['billingAddress'] != null
        ? ShippingAddress.fromJson(json['billingAddress'])
        : null;
    transaction = json['transaction'] != null
        ? Transaction.fromJson(json['transaction'])
        : null;
    status = json['status'];
    paymentType = json['paymentType'];
    createdDate = json['createdDate'];
    deliveryDate = json['deliveryDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['orderId'] = orderId;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (shippingAddress != null) {
      data['shippingAddress'] = shippingAddress!.toJson();
    }
    if (billingAddress != null) {
      data['billingAddress'] = billingAddress!.toJson();
    }
    if (transaction != null) {
      data['transaction'] = transaction!.toJson();
    }
    data['status'] = status;
    data['paymentType'] = paymentType;
    data['createdDate'] = createdDate;
    data['deliveryDate'] = deliveryDate;
    return data;
  }
}

class User {
  int? userId;
  String? email;
  String? phone;
  bool? isTwoFactorEnabled;
  bool? isActive;
  String? displayName;
  String? avatarUrl;
  String? createdDate;
  String? updatedDate;

  User(
      {this.userId,
      this.email,
      this.phone,
      this.isTwoFactorEnabled,
      this.isActive,
      this.displayName,
      this.avatarUrl,
      this.createdDate,
      this.updatedDate});

  User.fromJson(Map<String, dynamic> json) {
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

class ShippingAddress {
  String? addressId;
  String? houseNumber;
  String? streetName;
  String? state;
  String? city;
  String? country;
  String? addressKind;
  String? pincode;
  String? mobile;
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
      this.mobile,
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
    mobile = json['mobile'];
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
    data['mobile'] = mobile;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['addressType'] = addressType;
    data['addressText'] = addressText;
    data['deletedAt'] = deletedAt;
    return data;
  }
}

class Transaction {
  String? transactionId;

  Transaction({this.transactionId});

  Transaction.fromJson(Map<String, dynamic> json) {
    transactionId = json['transactionId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['transactionId'] = transactionId;
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
  ShippingRequirements? shippingRequirements;

  ProductVariant(
      {this.productSkuId,
      this.product,
      this.attributes,
      this.basePrice,
      this.salePrice,
      this.availableStock,
      this.barCode,
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

class ShippingRequirements {
  int? height;
  int? width;
  int? length;
  int? weight;

  ShippingRequirements({this.height, this.width, this.length, this.weight});

  ShippingRequirements.fromJson(Map<String, dynamic> json) {
    height = json['height'];
    width = json['width'];
    length = json['length'];
    weight = json['weight'];
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
