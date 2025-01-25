import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yahmart/controller/cart_checkout_controller.dart';
import 'package:yahmart/utils/common_logics.dart';
import '../../../model/cart_list_model.dart';
import '../../../utils/common_colors.dart';
import '../../../utils/custom_alert_dialog.dart';
import '../../../widgets/network_image_widget.dart';

class CardProductTileWidget extends StatelessWidget {
  final CartListModel? cartListItem;
  CardProductTileWidget({Key? key, required this.cartListItem})
      : super(key: key);

  /// find CartCheckout controller.
  final CartCheckoutController _cartCheckoutC = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
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
                        padding: const EdgeInsets.symmetric(horizontal: 0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: NetworkImageWidget(
                            imageUrl: cartListItem!
                                .productVariant!.product!.productBannerImage!
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
                            cartListItem!.productVariant!.product!.productName!,
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
                              cartListItem!.productVariant!.attributes!.length,
                              (index) => Text(
                                "${CommonLogics.toTitleCase(cartListItem!.productVariant!.attributes![index].attributeName!)}: ${CommonLogics.toTitleCase(cartListItem!.productVariant!.attributes![index].attributeValue!)}, ",
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
                                cartListItem!.productVariant!.product!
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
                                              inputString: (cartListItem!
                                                          .productVariant!
                                                          .basePrice! *
                                                      cartListItem!.quantity!)
                                                  .toString()),
                                      style: const TextStyle(
                                        color: Colors.black54,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        decoration: TextDecoration.lineThrough,
                                      ),
                                    ),
                                    TextSpan(
                                      text:
                                          "   ₹ ${CommonLogics.convertValueInThousandFormat(inputString: (cartListItem!.productVariant!.salePrice! * cartListItem!.quantity!).toString())}",
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextSpan(
                                      text:
                                          "   ${CommonLogics.getCalculatedDiscount(basePrice: (cartListItem!.productVariant!.basePrice! * cartListItem!.quantity!), salePrice: (cartListItem!.productVariant!.salePrice! * cartListItem!.quantity!))}% off",
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _shoppingItem(),
                  GestureDetector(
                    onTap: () {
                      _cartCheckoutC.productAddToCartFromCounter(
                          skuId: cartListItem!.productVariant!.productSkuId,
                          qty: 0);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 9, vertical: 5),
                      decoration: BoxDecoration(
                          color: CommonColors.appBgColor,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                              color: CommonColors.appColor, width: .5)),
                      child: Text(
                        'Remove',
                        style: TextStyle(
                          color: CommonColors.blackColor,
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ));
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
              if (cartListItem!.quantity! > 1) {
                _cartCheckoutC.productAddToCartFromCounter(
                    skuId: cartListItem!.productVariant!.productSkuId,
                    qty: cartListItem!.quantity! - 1);
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
              cartListItem!.quantity.toString(),
              style: const TextStyle(
                color: Colors.orange,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              if (cartListItem!.productVariant!.availableStock! >
                  cartListItem!.quantity!) {
                _cartCheckoutC.productAddToCartFromCounter(
                    skuId: cartListItem!.productVariant!.productSkuId,
                    qty: cartListItem!.quantity! + 1);
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
