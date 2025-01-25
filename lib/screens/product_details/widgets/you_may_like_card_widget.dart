import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yahmart/model/product_list_model.dart';
import 'package:yahmart/utils/common_colors.dart';
import 'package:yahmart/widgets/network_image_widget.dart';
import '../../../controller/product_controller.dart';
import '../../../utils/common_logics.dart';

class YouMayLikeCardWidget extends StatelessWidget {
  final ProductListModel? productListData;
  YouMayLikeCardWidget({Key? key, required this.productListData})
      : super(key: key);

  /// find product controller.
  final ProductController _productC = Get.find();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.only(top: 5, left: 8, right: 8, bottom: 0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 6,
              child: Stack(
                children: [
                  Container(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: NetworkImageWidget(
                          imageUrl:
                              productListData!.productBannerImage!.toString(),
                        ),
                      )),
                  Positioned(
                    top: 2,
                    right: 2,
                    child: GestureDetector(
                      onTap: () async {
                        _productC.addRemoveProductFromWishList(
                            skuId: productListData!.variants![0].productSkuId,
                            isFavFlag: productListData!.isWishlisted!.value);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: CommonColors.whiteColor),
                        child: Icon(
                          productListData!.isWishlisted!.value
                              ? Icons.favorite
                              : Icons.favorite_border,
                          size: 14,
                          color: productListData!.isWishlisted!.value
                              ? CommonColors.favColor
                              : CommonColors.blackColor,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              flex: 6,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          productListData!.productName!,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87),
                        ),
                      ),
                      productListData!.avgRating != null &&
                              productListData!.avgRating! > 0
                          ? Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 3),
                              decoration: BoxDecoration(
                                  // boxShadow: [
                                  //   BoxShadow(
                                  //     offset: const Offset(0, 6),
                                  //     color: Colors.grey.withOpacity(.4),
                                  //     blurRadius: 3.0,
                                  //   ),
                                  // ],
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Text(
                                "${productListData?.avgRating.toString()} *",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: CommonColors.whiteColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            )
                          : Container(),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Text(
                    productListData!.productDescription!,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87),
                  ),
                  const SizedBox(height: 8),
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
                          text: CommonLogics.convertValueInThousandFormat(
                              inputString: productListData!
                                  .variants![0].basePrice
                                  .toString()),
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize:
                                productListData!.variants![0].basePrice! > 99999
                                    ? 11
                                    : productListData!.variants![0].basePrice! >
                                            9999
                                        ? 12
                                        : 13,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                        TextSpan(
                          text:
                              "  ₹ ${CommonLogics.convertValueInThousandFormat(inputString: productListData!.variants![0].salePrice.toString())}",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize:
                                productListData!.variants![0].salePrice! > 99999
                                    ? 15
                                    : productListData!.variants![0].salePrice! >
                                            9999
                                        ? 17
                                        : 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    "${CommonLogics.getCalculatedDiscount(basePrice: productListData!.variants![0].basePrice!, salePrice: productListData!.variants![0].salePrice!)}% off",
                    style: TextStyle(
                      color: CommonColors.yellowColor,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
