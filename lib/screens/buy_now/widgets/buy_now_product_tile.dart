import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yahmart/controller/cart_checkout_controller.dart';
import 'package:yahmart/utils/common_logics.dart';
import '../../../utils/common_colors.dart';
import '../../../utils/custom_alert_dialog.dart';
import '../../../widgets/network_image_widget.dart';

class BuyNowProductTile extends StatelessWidget {
  BuyNowProductTile({Key? key}) : super(key: key);

  /// find CartCheckout controller.
  final CartCheckoutController _cartCheckoutC = Get.find();

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        id: 'checkout_screen',
        init: _cartCheckoutC,
        builder: (dynamic controller) {
          return Container(
              decoration: BoxDecoration(
                  color: CommonColors.whiteColor,
                  borderRadius: BorderRadius.circular(8)),
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Container(
                              height: 100,
                              width: 70,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: NetworkImageWidget(
                                  imageUrl: _cartCheckoutC
                                      .buyNowProduct!
                                      .productVariant!
                                      .product!
                                      .productBannerImage!
                                      .toString(),
                                ),
                              )),
                        ),
                        const SizedBox(
                          width: 14,
                        ),
                        Expanded(
                            flex: 9,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _cartCheckoutC.buyNowProduct!.productVariant!
                                      .product!.productName!,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87),
                                ),
                                const SizedBox(height: 3),
                                Row(
                                  children: List.generate(
                                    _cartCheckoutC.buyNowProduct!
                                        .productVariant!.attributes!.length,
                                    (index) => Text(
                                      "${CommonLogics.toTitleCase(_cartCheckoutC.buyNowProduct!.productVariant!.attributes![index].attributeName!)}: ${CommonLogics.toTitleCase(_cartCheckoutC.buyNowProduct!.productVariant!.attributes![index].attributeValue!)}, ",
                                      maxLines: 1,
                                      textAlign: TextAlign.start,
                                      style: const TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black54),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 3),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 3),
                                    Text(
                                      _cartCheckoutC
                                          .buyNowProduct!
                                          .productVariant!
                                          .product!
                                          .productDescription!,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black87),
                                    ),
                                    const SizedBox(height: 5),
                                    RichText(
                                      text: TextSpan(
                                        children: <TextSpan>[
                                          const TextSpan(
                                            text: "₹ ",
                                            style: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          TextSpan(
                                            text: CommonLogics
                                                .convertValueInThousandFormat(
                                                    inputString: (_cartCheckoutC
                                                                .buyNowProduct!
                                                                .productVariant!
                                                                .basePrice! *
                                                            _cartCheckoutC
                                                                .buyNowProduct!
                                                                .quantity!)
                                                        .toString()),
                                            style: const TextStyle(
                                              color: Colors.black54,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              decoration:
                                                  TextDecoration.lineThrough,
                                            ),
                                          ),
                                          TextSpan(
                                            text:
                                                "   ₹ ${CommonLogics.convertValueInThousandFormat(inputString: (_cartCheckoutC.buyNowProduct!.productVariant!.salePrice! * _cartCheckoutC.buyNowProduct!.quantity!).toString())}",
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          TextSpan(
                                            text:
                                                "   ${CommonLogics.getCalculatedDiscount(basePrice: (_cartCheckoutC.buyNowProduct!.productVariant!.basePrice! * _cartCheckoutC.buyNowProduct!.quantity!), salePrice: (_cartCheckoutC.buyNowProduct!.productVariant!.salePrice! * _cartCheckoutC.buyNowProduct!.quantity!))}% off",
                                            style: TextStyle(
                                              color: CommonColors.yellowColor,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ))
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        _shoppingItem(),
                      ],
                    )
                  ],
                ),
              ));
        });
  }

  Widget _shoppingItem() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: CommonColors.appColor, width: .5)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              if (_cartCheckoutC.buyNowProduct!.quantity! > 1) {
                _cartCheckoutC.productAddToCartFromCounter(
                    skuId: _cartCheckoutC
                        .buyNowProduct!.productVariant!.productSkuId,
                    qty: _cartCheckoutC.buyNowProduct!.quantity! - 1);
              }
            },
            child: Container(
              padding: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                color: CommonColors.appBgColor,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(5),
                    bottomLeft: Radius.circular(5)),
              ),
              child: Icon(
                Icons.remove,
                color: CommonColors.appColor,
                size: 18,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
            child: Text(
              _cartCheckoutC.buyNowProduct!.quantity.toString(),
              style: const TextStyle(
                color: Colors.orange,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              if (_cartCheckoutC
                      .buyNowProduct!.productVariant!.availableStock! >
                  _cartCheckoutC.buyNowProduct!.quantity!) {
                _cartCheckoutC.productAddToCartFromCounter(
                    skuId: _cartCheckoutC
                        .buyNowProduct!.productVariant!.productSkuId,
                    qty: _cartCheckoutC.buyNowProduct!.quantity! + 1);
              } else {
                showAlertDialog(msg: "Product out of stock");
              }
            },
            child: Container(
              padding: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                color: CommonColors.appBgColor,
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(5),
                    bottomRight: Radius.circular(5)),
              ),
              child: Icon(
                Icons.add,
                color: CommonColors.appColor,
                size: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
