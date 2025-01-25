import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yahmart/screens/product_details/widgets/bottom_widget.dart';
import 'package:yahmart/screens/product_details/widgets/check_delivery_date_widget.dart';
import 'package:yahmart/screens/product_details/widgets/product_details_view.dart';
import 'package:yahmart/screens/product_details/widgets/product_image_view.dart';
import 'package:yahmart/screens/product_details/widgets/question_answer_widget.dart';
import 'package:yahmart/screens/product_details/widgets/ratings_reviews_widget.dart';
import 'package:yahmart/screens/product_details/widgets/suggestion_banner_widget.dart';
import 'package:yahmart/screens/product_details/widgets/you_may_like_also_widget.dart';
import 'package:yahmart/utils/common_colors.dart';
import '../../controller/product_controller.dart';
import '../../controller/product_details_controller.dart';
import '../../utils/common_logics.dart';
import '../../widgets/cart_button.dart';
import '../../widgets/share_button.dart';
import 'widgets/offer_bottom_sheet.dart';
import 'widgets/select_size_widget.dart';

class ProductDetailsScreen extends StatefulWidget {
  final String? productId;
  final String? brandName;
  const ProductDetailsScreen(
      {Key? key, required this.productId, required this.brandName})
      : super(key: key);

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  /// find product detail controller.
  final ProductDetailsController _productDetailsC = Get.find();

  /// find product controller.
  final ProductController _productC = Get.find();
  String? productName;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((Duration time) => init());
    super.initState();
  }

  init() async {
    productName = widget.brandName!;
    _productDetailsC.pinCodeTextField.clear();
    _productDetailsC.availableCourier!.clear();
    _productDetailsC.availableCourierMessage("");
    await _productDetailsC.getProductDetails(
        shouldShowLoader: true, productId: widget.productId!);
    Future.delayed(const Duration(seconds: 1), () {
      if (Get.isBottomSheetOpen == true) {
        Get.back();
      }
      Get.bottomSheet(
        isDismissible: false,
        enableDrag: false,
        OfferBottomSheet(),
      );
    });
    await _productDetailsC.getFaqList(
        shouldShowLoader: true, productId: widget.productId!);
    await _productDetailsC.getReviewList(
        shouldShowLoader: true, productId: widget.productId!);
    await _productC.getProductList();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        backgroundColor: CommonColors.appBgColor,
        appBar: AppBar(
          centerTitle: false,
          elevation: 0,
          backgroundColor: CommonColors.appBgColor,
          titleSpacing: 0,
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: CommonColors.appColor,
              ),
              onPressed: () => Get.back()),
          title: Text(
            productName ?? "",
            style: TextStyle(
                color: CommonColors.blackColor,
                fontSize: 16,
                fontWeight: FontWeight.w500),
            overflow: TextOverflow.ellipsis,
          ),
          actions: [
            _productDetailsC.isProductDetailsLoading.value
                ? Container()
                : ShareButton(
                    onPressed: () async {
                      String? productImage = _productDetailsC
                              .productDetailsData!.productBannerImage!
                              .startsWith("http")
                          ? _productDetailsC
                              .productDetailsData!.productBannerImage!
                          : "https://yahmartindia.in/api/v1/${_productDetailsC.productDetailsData!.productBannerImage!}";
                      await CommonLogics.saveAndShare(
                        productImage,
                        '${_productDetailsC.productDetailsData!.productName}\n\nhttps://yahmartindia.in/product/${_productDetailsC.productDetailsData!.productId}\n\nYou can find our app from below url,\n\n Android:\nhttps://play.google.com/store/apps/details?id=com.app.yahmartindia\niOS:\nhttps://apps.apple.com/us/app/yahmart-india-private-limited/id6446877479',
                      );
                    },
                  ),
            CartButton()
          ],
        ),
        bottomNavigationBar: _productDetailsC.isProductDetailsLoading.value
            ? Container(
                height: 10,
              )
            : BottomWidget(
                onPressedAddToCart: () => _productDetailsC.addToCartProduct(),
                onPressedBuyNow: () => _productDetailsC.buyNowProduct(),
              ),
        body: GetBuilder(
            id: 'select_size_widget',
            init: _productDetailsC,
            builder: (dynamic controller) {
              return _productDetailsC.isProductDetailsLoading.value
                  ? Center(
                      child: CircularProgressIndicator(
                        color: CommonColors.appColor,
                      ),
                    )
                  : ScrollConfiguration(
                      behavior:
                          const ScrollBehavior().copyWith(overscroll: false),
                      child: ListView(
                        controller:
                            _productDetailsC.productDetailsScrollController,
                        children: [
                          ProductImageView(),
                          const SizedBox(height: 10),
                          SelectSizeWidget(),
                          SizedBox(
                              height:
                                  _productDetailsC.attributeOptions!.isNotEmpty
                                      ? 10
                                      : 0),
                          CheckDeliveryDateWidget(),
                          const SizedBox(height: 10),
                          ProductDetailsView(),
                          const SizedBox(height: 10),
                          const SuggestionBannerWidget(),
                          const SizedBox(height: 10),
                          RatingsReviewsWidget(),
                          const SizedBox(height: 10),
                          QuestionAnswerWidget(),
                          const SizedBox(height: 10),
                          YouMayLikeAlsoWidget(),
                          const SizedBox(height: 10),
                        ],
                      ),
                    );
            }),
      );
    });
  }
}
