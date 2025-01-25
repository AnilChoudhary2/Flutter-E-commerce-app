import 'package:get/get.dart';

class UserDataModel {
  int? userId;
  String? email;
  String? phone;
  bool? isTwoFactorEnabled;
  String? displayName;
  String? avatarUrl;
  List<Products>? products;
  List<Addresses>? addresses;

  UserDataModel({
    this.userId,
    this.email,
    this.phone,
    this.isTwoFactorEnabled,
    this.displayName,
    this.avatarUrl,
    this.products,
    this.addresses,
  });

  UserDataModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    email = json['email'];
    phone = json['phone'];
    isTwoFactorEnabled = json['isTwoFactorEnabled'];
    displayName = json['displayName'];
    avatarUrl = json['avatarUrl'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(Products.fromJson(v));
      });
    }
    if (json['addresses'] != null) {
      addresses = <Addresses>[];
      json['addresses'].forEach((v) {
        addresses!.add(Addresses.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['email'] = email;
    data['phone'] = phone;
    data['isTwoFactorEnabled'] = isTwoFactorEnabled;
    data['displayName'] = displayName;
    data['avatarUrl'] = avatarUrl;
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    if (addresses != null) {
      data['addresses'] = addresses!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Products {
  String? productId;
  String? productName;
  String? productDescription;
  bool? isPublic;
  String? productBannerImage;
  String? productType;
  String? createdDate;

  Products(
      {this.productId,
      this.productName,
      this.productDescription,
      this.isPublic,
      this.productBannerImage,
      this.productType,
      this.createdDate});

  Products.fromJson(Map<String, dynamic> json) {
    productId = json['productId'];
    productName = json['productName'];
    productDescription = json['productDescription'];
    isPublic = json['isPublic'];
    productBannerImage = json['productBannerImage'];
    productType = json['productType'];
    createdDate = json['createdDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['productId'] = productId;
    data['productName'] = productName;
    data['productDescription'] = productDescription;
    data['isPublic'] = isPublic;
    data['productBannerImage'] = productBannerImage;
    data['productType'] = productType;
    data['createdDate'] = createdDate;
    return data;
  }
}

class Addresses {
  String? addressId;
  String? houseNumber;
  String? streetName;
  String? state;
  String? city;
  String? country;
  String? addressKind;
  String? pincode;
  String? mobile;
  num? latitude;
  num? longitude;
  String? addressType;
  String? addressText;
  RxBool? isSelected = false.obs;

  Addresses(
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
      this.isSelected});

  Addresses.fromJson(Map<String, dynamic> json) {
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
    return data;
  }
}
