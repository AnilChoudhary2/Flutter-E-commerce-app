import 'order_details_model.dart';

class OrderCreateModel {
  String? orderId;
  User? user;
  ShippingAddress? shippingAddress;
  ShippingAddress? billingAddress;
  Transaction? transaction;
  String? status;
  String? paymentType;
  int? totalAmount;
  int? totalDiscount;
  String? createdDate;
  String? deliveryDate;
  List<Items>? items;

  OrderCreateModel(
      {this.orderId,
      this.user,
      this.shippingAddress,
      this.billingAddress,
      this.transaction,
      this.status,
      this.paymentType,
      this.totalAmount,
      this.totalDiscount,
      this.createdDate,
      this.deliveryDate,
      this.items});

  OrderCreateModel.fromJson(Map<String, dynamic> json) {
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
    totalAmount = json['totalAmount'];
    totalDiscount = json['totalDiscount'];
    createdDate = json['createdDate'];
    deliveryDate = json['deliveryDate'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(Items.fromJson(v));
      });
    }
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
    data['totalAmount'] = totalAmount;
    data['totalDiscount'] = totalDiscount;
    data['createdDate'] = createdDate;
    data['deliveryDate'] = deliveryDate;
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class User {
  int? userId;

  User({this.userId});

  User.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
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

class Items {
  String? orderItemId;
  Order? order;
  ProductVariant? productVariant;
  int? quantity;
  int? salePrice;
  String? status;

  Items(
      {this.orderItemId,
      this.order,
      this.productVariant,
      this.quantity,
      this.salePrice,
      this.status});

  Items.fromJson(Map<String, dynamic> json) {
    orderItemId = json['orderItemId'];
    order = json['order'] != null ? Order.fromJson(json['order']) : null;
    productVariant = json['productVariant'] != null
        ? ProductVariant.fromJson(json['productVariant'])
        : null;
    quantity = json['quantity'];
    salePrice = json['salePrice'];
    status = json['status'];
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
    return data;
  }
}

class Order {
  String? orderId;

  Order({this.orderId});

  Order.fromJson(Map<String, dynamic> json) {
    orderId = json['orderId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['orderId'] = orderId;
    return data;
  }
}

class ProductVariant {
  String? productSkuId;
  int? basePrice;
  int? salePrice;
  int? availableStock;
  String? barCode;

  ProductVariant(
      {this.productSkuId,
      this.basePrice,
      this.salePrice,
      this.availableStock,
      this.barCode});

  ProductVariant.fromJson(Map<String, dynamic> json) {
    productSkuId = json['productSkuId'];
    basePrice = json['basePrice'];
    salePrice = json['salePrice'];
    availableStock = json['availableStock'];
    barCode = json['barCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['productSkuId'] = productSkuId;
    data['basePrice'] = basePrice;
    data['salePrice'] = salePrice;
    data['availableStock'] = availableStock;
    data['barCode'] = barCode;
    return data;
  }
}
