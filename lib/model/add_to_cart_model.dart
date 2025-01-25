class AddToCartModel {
  int? userId;
  String? productSkuId;
  int? quantity;
  int? salePrice;

  AddToCartModel(
      {this.userId, this.productSkuId, this.quantity, this.salePrice});

  AddToCartModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    productSkuId = json['productSkuId'];
    quantity = json['quantity'];
    salePrice = json['salePrice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['productSkuId'] = productSkuId;
    data['quantity'] = quantity;
    data['salePrice'] = salePrice;
    return data;
  }
}
