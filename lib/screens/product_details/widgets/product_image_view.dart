import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yahmart/utils/screen_constants.dart';
import 'package:yahmart/widgets/full_screen_network_image_widget.dart';
import '../../../controller/product_controller.dart';
import '../../../controller/product_details_controller.dart';
import '../../../utils/common_colors.dart';
import '../../../utils/common_logics.dart';

class ProductImageView extends StatelessWidget {
  ProductImageView({Key? key}) : super(key: key);

  /// find product detail controller.
  final ProductDetailsController _productDetailsC = Get.find();

  /// find product controller.
  final ProductController _productC = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(left: 16, top: 10, bottom: 5),
        color: CommonColors.whiteColor,
        height: MediaQuery.of(context).size.height / 1.9,
        width: MediaQuery.of(context).size.width,
        child: Obx(() {
          return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 8,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 12,
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Container(
                              alignment: Alignment.center,
                              child: FullScreenNetworkImageWidget(
                                imageUrl: _productDetailsC.selectedVariants!
                                    .images!.first.variantImage!,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 5,
                            right: 5,
                            child: GestureDetector(
                              onTap: () {
                                _productC.addRemoveProductFromWishList(
                                    skuId: _productDetailsC
                                        .selectedVariants!.productSkuId,
                                    isFavFlag: _productDetailsC
                                        .productDetailsData!
                                        .isWishlisted!
                                        .value);
                              },
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: CommonColors.whiteColor),
                                child: Icon(
                                  _productDetailsC.productDetailsData!
                                          .isWishlisted!.value
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  size: 20,
                                  color: _productDetailsC.productDetailsData!
                                          .isWishlisted!.value
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
                      flex: 5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Text(
                                  _productDetailsC
                                      .productDetailsData!.productName!,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87),
                                ),
                              ),
                              _productDetailsC.productDetailsData!.avgRating !=
                                          null &&
                                      _productDetailsC
                                              .productDetailsData!.avgRating! >
                                          0
                                  ? Container(
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 6,
                                        vertical: 3,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.green,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text(
                                        "${_productDetailsC.productDetailsData!.avgRating.toString()} *",
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
                          const Spacer(),
                          Text(
                            _productDetailsC
                                .productDetailsData!.productDescription!,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.black87),
                          ),
                          const Spacer(),
                          RichText(
                            text: TextSpan(
                              children: <TextSpan>[
                                const TextSpan(
                                  text: "₹ ",
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      CommonLogics.convertValueInThousandFormat(
                                          inputString: _productDetailsC
                                              .selectedVariants!.basePrice
                                              .toString()),
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: _productDetailsC
                                                .selectedVariants!.basePrice! >
                                            99999
                                        ? 11
                                        : _productDetailsC.selectedVariants!
                                                    .basePrice! >
                                                9999
                                            ? 13
                                            : 15,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      "  ₹ ${CommonLogics.convertValueInThousandFormat(inputString: _productDetailsC.selectedVariants!.salePrice!.toString())}",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: _productDetailsC
                                                .selectedVariants!.salePrice! >
                                            99999
                                        ? 17
                                        : _productDetailsC.selectedVariants!
                                                    .salePrice! >
                                                9999
                                            ? 19
                                            : 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      "    ${CommonLogics.getCalculatedDiscount(basePrice: _productDetailsC.selectedVariants!.basePrice!, salePrice: _productDetailsC.selectedVariants!.salePrice!)}% off",
                                  style: TextStyle(
                                    color: CommonColors.yellowColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 4,
                child: ScrollConfiguration(
                  behavior: const ScrollBehavior().copyWith(overscroll: false),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(
                          _productDetailsC.variantsImage.length, (index) {
                        return GestureDetector(
                          onTap: () {},
                          child: Card(
                            elevation: 2,
                            margin: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: Container(
                              width: ScreenConstant.size85,
                              height: ScreenConstant.size100,
                              margin: const EdgeInsets.all(4),
                              child: FullScreenNetworkImageWidget(
                                imageUrl: _productDetailsC.variantsImage[index]
                                    .toString(),
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ),
              ),
            ],
          );
        }));
  }
}
