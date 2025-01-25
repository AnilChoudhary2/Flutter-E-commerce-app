import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yahmart/controller/cart_checkout_controller.dart';
import 'package:yahmart/model/faq_list_model.dart';
import '../model/check_delivery_availability_model.dart';
import '../model/product_details_model.dart';
import '../model/review_list_model.dart';
import '../repository/repository.dart';
import '../screens/buy_now/buy_now_screen.dart';
import '../utils/common_logics.dart';
import '../utils/custom_alert_dialog.dart';
import '../widgets/loader_dialog.dart';
import '../widgets/login_bottom_sheet.dart';

class ProductDetailsController extends GetxController {
  Repository repository = Repository();
  RxBool isProductDetailsLoading = true.obs;
  RxBool isFaqListLoading = true.obs;
  RxBool isReviewListLoading = true.obs;
  RxString availableCourierMessage = "".obs;
  RxList<String> sizeList = <String>[].obs;
  RxList<String> variantsImage = <String>[].obs;
  RxList<FaqListModel> faqList = <FaqListModel>[].obs;
  RxList<ReviewListModel> reviewList = <ReviewListModel>[].obs;
  ProductDetailsModel? productDetailsData = ProductDetailsModel().obs();
  List<Variants>? productVariants = <Variants>[].obs;
  Variants? selectedVariants = Variants().obs();
  List<AttributeOptions>? attributeOptions = <AttributeOptions>[].obs;
  List<AvailableCourierCompanies>? availableCourier =
      <AvailableCourierCompanies>[].obs;
  List<Gallery>? productGallery = <Gallery>[].obs;
  final TextEditingController pinCodeTextField =
      TextEditingController(text: "");
  Map<String, String> selectedAttributes = {};

  /// used to scroll the page to starting when search, refresh screen api calls
  ScrollController productDetailsScrollController = ScrollController();

  @override
  void onInit() {
    repository.initRepo();
    //if (Get.isRegistered<ProductController>()) {}
    super.onInit();
  }

  addToCartProduct() async {
    final CartCheckoutController cartCheckoutC = Get.find();
    bool isLogin = CommonLogics.checkUserLogin();
    if (isLogin) {
      if (selectedVariants!.availableStock! > 0) {
        log(selectedAttributes.values.toString());
        // if (selectedAttributes.isNotEmpty) {
        await cartCheckoutC.productAddToCart(
            skuId: selectedVariants!.productSkuId, qty: 1);
        showToastMessage(msg: "Added successfully!");
        // } else {
        //   if (productDetailsScrollController.hasClients) {
        //     productDetailsScrollController.animateTo(
        //       1,
        //       duration: const Duration(seconds: 1),
        //       curve: Curves.easeIn,
        //     );
        //   }
        //   showToastMessage(msg: "Please select product variation first");
        // }
      } else {
        showToastMessage(msg: "Product out of stock.");
      }
    } else {
      Get.bottomSheet(const LoginBottomSheet());
    }
  }

  buyNowProduct() async {
    final CartCheckoutController cartCheckoutC = Get.find();
    bool isLogin = CommonLogics.checkUserLogin();
    if (isLogin) {
      if (selectedVariants!.availableStock! > 0) {
        log(selectedAttributes.values.toString());
        cartCheckoutC.byNowSingleProductId(selectedVariants!.productSkuId);
        await cartCheckoutC.productAddToCart(
            skuId: selectedVariants!.productSkuId, qty: 1);
        if (cartCheckoutC.addressesList.isNotEmpty) {
          cartCheckoutC.deliveryAddress = cartCheckoutC.addressesList.first;
        }
        Get.to(() => const BuyNowScreen());
      } else {
        showToastMessage(msg: "Product out of stock.");
      }
    } else {
      Get.bottomSheet(const LoginBottomSheet());
    }
  }

  getProductDetails(
      {bool shouldShowLoader = true, required String productId}) async {
    selectedAttributes.clear();
    try {
      if (shouldShowLoader) isProductDetailsLoading(true);
      var response =
          await repository.getApiCall(url: "product/details/$productId");
      if (response != null) {
        variantsImage.clear();
        productVariants!.clear();
        productGallery!.clear();
        attributeOptions!.clear();
        selectedVariants = Variants();
        productDetailsData = ProductDetailsModel.fromJson(response);
        productVariants = productDetailsData!.variants;
        productGallery = productDetailsData!.gallery;
        selectedVariants = productVariants![0];
        attributeOptions = productDetailsData!.attributeOptions;
        for (var i = 0; i < attributeOptions!.length; i++) {
          selectedAttributes[attributeOptions![i].attributeName!] =
              attributeOptions![i].attributeOptions![0];
        }
        handleUpdate();
        update(["select_size_widget"]);
        for (var variants in productVariants!) {
          variantsImage.add(variants.images![0].variantImage!);
        }
      } else {
        log("response != null => True");
      }
      if (shouldShowLoader) isProductDetailsLoading(false);
    } catch (e, stackTrace) {
      if (shouldShowLoader) isProductDetailsLoading(false);
      if (kDebugMode) {
        showAlertDialog(msg: e.toString());
      }
      log("getProductDetails error => ${stackTrace.toString()}");
    }
  }

  selectSizeFun({required int index, required int jIndex}) {
    // final condition = selectedAttributes.containsKey(
    //       attributeOptions![index].attributeName!,
    //     ) &&
    //     selectedAttributes[attributeOptions![index].attributeName!] ==
    //         attributeOptions![index].attributeOptions![jIndex];
    //
    // if (condition) {
    //   selectedAttributes.remove(attributeOptions![index].attributeName!);
    // } else {
    selectedAttributes[attributeOptions![index].attributeName!] =
        attributeOptions![index].attributeOptions![jIndex];
    // }
    handleUpdate();
    update(["select_size_widget"]);
  }

  void handleUpdate() {
    final variantAttributes = productVariants!.map((variant) {
      return VariantEntry(
          variant.attributes!.map((attr) {
            return '${attr.attributeName}|${attr.attributeValue}';
          }).toList(),
          variant);
    });

    final selectedAttributesEntries = selectedAttributes.entries
        .map((entry) => '${entry.key}|${entry.value}')
        .toList();

    final filtered = variantAttributes
        .where(
          (variant) => selectedAttributesEntries.every(
            (entry) => variant.attributeEntries.contains(entry),
          ),
        )
        .toList();

    if (filtered.isNotEmpty) {
      selectedVariants = filtered[0].data;
    }
  }

  getFaqList({bool shouldShowLoader = true, required String productId}) async {
    try {
      if (shouldShowLoader) isFaqListLoading(true);
      var response =
          await repository.getApiCall(url: "product/faq-list/$productId");
      faqList.clear();
      if (response != null) {
        response.forEach((element) async {
          faqList.add(FaqListModel.fromJson(element));
        });
      } else {
        log("response != null => True");
      }
      log("faqList length => ${faqList.length.toString()}");
      if (shouldShowLoader) isFaqListLoading(false);
    } catch (e, stackTrace) {
      if (shouldShowLoader) isFaqListLoading(false);
      if (kDebugMode) {
        showAlertDialog(msg: e.toString());
      }
      log("getFaqList error => ${stackTrace.toString()}");
    }
  }

  addProductFaq({required body}) async {
    try {
      showLoaderDialog();
      var response =
          await repository.postApiCall(url: "product/add-faq", body: body);
      if (response != null) {
        await getFaqList(productId: productDetailsData!.productId!);
        Get.back();
        hideLoaderDialog();
      } else {
        hideLoaderDialog();
        log("response != null => True");
      }
    } catch (e, stackTrace) {
      hideLoaderDialog();
      if (kDebugMode) {
        showAlertDialog(msg: e.toString());
      }
      log("addProductFaq error => ${stackTrace.toString()}");
    }
  }

  getReviewList(
      {bool shouldShowLoader = true, required String productId}) async {
    try {
      if (shouldShowLoader) isReviewListLoading(true);
      var response = await repository.getApiCall(
          url: "product/review-list/$productId?pageSize=10&current=1");
      reviewList.clear();
      if (response != null) {
        response.forEach((element) async {
          reviewList.add(ReviewListModel.fromJson(element));
        });
      } else {
        log("response != null => True");
      }
      log("faqList length => ${reviewList.length.toString()}");
      if (shouldShowLoader) isReviewListLoading(false);
    } catch (e, stackTrace) {
      if (shouldShowLoader) isReviewListLoading(false);
      if (kDebugMode) {
        showAlertDialog(msg: e.toString());
      }
      log("getReviewList error => ${stackTrace.toString()}");
    }
  }

  checkDeliveryAvailability() async {
    if (pinCodeTextField.value.text == "") {
      showToastMessage(msg: "Please enter a valid pincode");
    } else {
      try {
        showLoaderDialog();
        var body = {
          "pincode": pinCodeTextField.text.toString(),
          "productSkuId": selectedVariants!.productSkuId
        };
        var response = await repository.postApiCall(
            url: "product/check-availability", body: body);
        if (response != null) {
          CheckDeliveryAvailabilityModel checkDeliveryAvailabilityModel =
              CheckDeliveryAvailabilityModel.fromJson(response);
          availableCourier =
              checkDeliveryAvailabilityModel.data?.availableCourierCompanies ??
                  [];
          availableCourierMessage(response["message"]);
          update(["select_size_widget"]);
        } else {
          log("response != null => True");
        }
        log("availableCourier length => ${availableCourier?.length.toString()}");
        hideLoaderDialog();
      } catch (e, stackTrace) {
        hideLoaderDialog();
        showAlertDialog(msg: e.toString());
        log("getReviewList error => ${stackTrace.toString()}");
      }
    }
  }
}

class VariantEntry {
  final List<String> attributeEntries;
  final Variants data;

  VariantEntry(this.attributeEntries, this.data);
}
