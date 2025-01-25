class PlaceOrderModel {
  List<OrderItems>? items;
  ShippingAddress? shippingAddress;
  ShippingAddress? billingAddress;
  String? paymentType;
  PlaceOrderModel(
      {this.items,
      this.shippingAddress,
      this.billingAddress,
      this.paymentType});

  PlaceOrderModel.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <OrderItems>[];
      json['items'].forEach((v) {
        items!.add(OrderItems.fromJson(v));
      });
    }
    shippingAddress = json['shippingAddress'] != null
        ? ShippingAddress.fromJson(json['shippingAddress'])
        : null;
    billingAddress = json['billingAddress'] != null
        ? ShippingAddress.fromJson(json['billingAddress'])
        : null;
    paymentType = json['paymentType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    if (shippingAddress != null) {
      data['shippingAddress'] = shippingAddress!.toJsonId();
    }
    if (billingAddress != null) {
      data['billingAddress'] = billingAddress!.toJsonId();
    }
    data['paymentType'] = paymentType;

    return data;
  }
}

class OrderItems {
  String? productSkuId;
  int? quantity;

  OrderItems({this.productSkuId, this.quantity});

  OrderItems.fromJson(Map<String, dynamic> json) {
    productSkuId = json['productSkuId'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['productSkuId'] = productSkuId;
    data['quantity'] = quantity;
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

  Map<String, dynamic> toJsonId() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['addressId'] = addressId;
    return data;
  }
}
