import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yahmart/utils/common_logics.dart';
import '../../../controller/product_controller.dart';
import '../../../model/product_wishlist_model.dart';
import '../../../utils/common_colors.dart';
import '../../../widgets/network_image_widget.dart';

class FavProductTileWidget extends StatelessWidget {
  final ProductWishlistModel productWishlist;
  FavProductTileWidget({Key? key, required this.productWishlist})
      : super(key: key);

  /// find product controller.
  final ProductController _productC = Get.find();

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 1,
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
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
                        imageUrl: productWishlist.product!.productBannerImage!
                            .toString(),
                      ),
                    )),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                  flex: 9,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              productWishlist.product!.productName!,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              _productC.addRemoveProductFromWishList(
                                  skuId: productWishlist.productSkuId,
                                  isFavFlag: true);
                            },
                            child: Icon(
                              Icons.favorite,
                              color: CommonColors.favColor,
                            ),
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 3),
                          Text(
                            productWishlist.product!.productDescription!,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
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
                                  text:
                                      CommonLogics.convertValueInThousandFormat(
                                          inputString: productWishlist
                                              .basePrice!
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
                                      "   ₹ ${CommonLogics.convertValueInThousandFormat(inputString: productWishlist.salePrice.toString())}",
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      "   ${CommonLogics.getCalculatedDiscount(basePrice: productWishlist.basePrice!, salePrice: productWishlist.salePrice!)}% off",
                                  style: TextStyle(
                                    color: CommonColors.yellowColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 3),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              productWishlist.product!.avgRating != null &&
                                      productWishlist.product!.avgRating! > 0
                                  ? Container(
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 6, vertical: 3),
                                      decoration: BoxDecoration(
                                          color: Colors.green,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Text(
                                        "${productWishlist.product!.avgRating.toString()} *",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: CommonColors.whiteColor,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    )
                                  : Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 6, vertical: 3),
                                      child: const Text(""),
                                    ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ))
            ],
          ),
        ));
  }
}
