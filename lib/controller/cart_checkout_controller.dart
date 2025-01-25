import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yahmart/model/add_to_cart_model.dart';
import 'package:yahmart/model/cart_list_model.dart';
import 'package:yahmart/model/place_order_model.dart';
import 'package:yahmart/model/user_data_model.dart';
import 'package:yahmart/screens/checkout/checkout_screen.dart';
import 'package:yahmart/screens/checkout/thank_you_screen.dart';
import 'package:yahmart/utils/custom_alert_dialog.dart';
import 'package:yahmart/widgets/loader_dialog.dart';
import '../model/coupon_code_model.dart';
import '../model/order_create_model.dart';
import '../repository/repository.dart';
import '../utils/common_logics.dart';

class CartCheckoutController extends GetxController {
  Repository repository = Repository();
  RxInt cartQuantity = 0.obs;
  RxDouble cartTotalDiscount = 0.0.obs;
  RxInt cartTotalAmount = 0.obs;
  RxInt cartSalePriceTotal = 0.obs;
  RxInt cartBasePriceTotal = 0.obs;
  RxBool isCartListLoading = true.obs;
  RxString byNowSingleProductId = "".obs;
  CartListModel? buyNowProduct = CartListModel().obs();
  RxList<Addresses> addressesList = <Addresses>[].obs;
  RxList<CartListModel> myCartList = <CartListModel>[].obs;
  AddToCartModel? addToCartModel = AddToCartModel().obs();
  RxString selectedPaymentMethod = "COD".obs;
  Addresses? deliveryAddress = Addresses().obs();
  PlaceOrderModel placeOrderModel = PlaceOrderModel().obs();
  OrderCreateModel orderCreateModel = OrderCreateModel().obs();
  List<OrderItems>? orderItems = <OrderItems>[].obs;
  CouponCodeModel? selectedCouponCode = CouponCodeModel().obs();
  RxList<CouponCodeModel> allCouponList = <CouponCodeModel>[].obs;
  final TextEditingController couponCodeTextField =
      TextEditingController(text: "");

  //onInit() function call first time when controller is create.
  @override
  void onInit() async {
    await repository.initRepo();
    bool isLogin = CommonLogics.checkUserLogin();
    if (isLogin) {
      await getCartList();
      await getDeliveryAddress();
    }
    allCouponList.clear();
    allCouponList.addAll([
      CouponCodeModel(
          couponCode: "SAVE100",
          codeValue: "SAVE100",
          offerValue: "Flat 10% off on your 10,000 order",
          isSelected: false.obs),
      CouponCodeModel(
          couponCode: "VIVO203",
          codeValue: "VIVO203",
          offerValue: "Flat 18% off on vivo mobile phone.",
          isSelected: false.obs),
      CouponCodeModel(
          couponCode: "YAHMARTFIRST",
          codeValue: "YAHMARTFIRST",
          offerValue: "Flat 25% off on your first order.",
          isSelected: false.obs),
    ]);
    super.onInit();
  }

  goForCheckout() {
    if (addressesList.isNotEmpty) {
      deliveryAddress = addressesList.first;
    }
    Get.to(() => const CheckoutScreen());
  }

  myCartPlaceOrder() async {
    if (deliveryAddress!.addressId != null) {
      log(selectedPaymentMethod.value);
      orderItems!.clear();
      for (var cart in myCartList) {
        orderItems!.add(OrderItems(
            productSkuId: cart.productSkuId, quantity: cart.quantity));
      }
      var address = ShippingAddress(
        addressId: deliveryAddress!.addressId!,
      );

      placeOrderModel = PlaceOrderModel(
          items: orderItems,
          shippingAddress: address,
          billingAddress: address,
          paymentType: selectedPaymentMethod.value);
      log(placeOrderModel.toJson().toString());
      await callPlaceOrderApi();
    } else {
      showToastMessage(msg: "Please add delivery address.");
    }
  }

  singleProductPlaceOrder() async {
    if (deliveryAddress!.addressId != null) {
      log(selectedPaymentMethod.value);
      orderItems!.clear();
      orderItems!.add(OrderItems(
        productSkuId: buyNowProduct!.productSkuId,
        quantity: buyNowProduct!.quantity,
      ));
      var address = ShippingAddress(
        addressId: deliveryAddress!.addressId!,
      );
      placeOrderModel = PlaceOrderModel(
          items: orderItems,
          shippingAddress: address,
          billingAddress: address,
          paymentType: selectedPaymentMethod.value);
      log(placeOrderModel.toJson().toString());
      await callPlaceOrderApi();
    } else {
      showToastMessage(msg: "Please add delivery address.");
    }
  }

  callPlaceOrderApi() async {
    try {
      showLoaderDialog();
      var response = await repository.postApiCall(
          url: "order/create", body: placeOrderModel.toJson());
      hideLoaderDialog();
      if (response != null) {
        orderCreateModel = OrderCreateModel.fromJson(response);
        Get.offAll(() => ThankYouScreen());
      } else {
        log("response != null => True");
      }
    } catch (e, stackTrace) {
      hideLoaderDialog();
      if (kDebugMode) {
        showAlertDialog(msg: e.toString());
      }
      log("callPlaceOrderApi error => ${stackTrace.toString()}");
    }
  }

  updateCouponCode() {
    update(['checkout_screen']);
  }

  getCartList({bool shouldShowLoader = true}) async {
    try {
      if (shouldShowLoader) isCartListLoading(true);
      var response = await repository.getApiCall(url: "product/cart/list");
      myCartList.clear();
      if (response != null) {
        response.forEach((element) async {
          myCartList.add(CartListModel.fromJson(element));
        });
        cartQuantity(myCartList.length);
        cartSalePriceTotal(0);
        cartBasePriceTotal(0);
        cartTotalAmount(0);
        cartTotalDiscount(0);
        for (int i = 0; i < myCartList.length; i++) {
          cartSalePriceTotal += (myCartList[i].productVariant!.salePrice! *
              myCartList[i].quantity!);
          cartBasePriceTotal += (myCartList[i].productVariant!.basePrice! *
              myCartList[i].quantity!);
          cartTotalDiscount.value =
              (cartBasePriceTotal.value - cartSalePriceTotal.value)
                  .floorToDouble();
        }
        if (byNowSingleProductId.value.isNotEmpty) {
          CartListModel singleProduct = myCartList.firstWhere(
              (element) => element.productSkuId == byNowSingleProductId.value);
          buyNowProduct = singleProduct;
        }
        update(['checkout_screen']);
      } else {
        log("response != null => True");
      }
      log("cartQuantity length => ${myCartList.length.toString()}");
      if (shouldShowLoader) isCartListLoading(false);
    } catch (e, stackTrace) {
      if (shouldShowLoader) isCartListLoading(false);
      if (kDebugMode) {
        showAlertDialog(msg: e.toString());
      }
      log("getCartList error => ${stackTrace.toString()}");
    }
  }

  productAddToCart({
    required qty,
    required skuId,
  }) async {
    CartListModel cartList = myCartList.firstWhere(
        (e) => e.productSkuId == skuId,
        orElse: () => CartListModel());
    if (qty == 1 && cartList.productSkuId == skuId) {
      showToastMessage(msg: "Product already exists in your cart.");
    } else {
      try {
        showLoaderDialog();
        var body = {"productSkuId": skuId, "quantity": qty};
        var response =
            await repository.postApiCall(url: "product/add-cart", body: body);
        hideLoaderDialog();
        if (response != null) {
          addToCartModel = AddToCartModel.fromJson(response);
        } else {
          log("response != null => True");
        }
        getCartList(shouldShowLoader: false);
      } catch (e, stackTrace) {
        hideLoaderDialog();
        if (kDebugMode) {
          showAlertDialog(msg: e.toString());
        }
        log("productAddToCart error => ${stackTrace.toString()}");
      }
    }
  }

  productAddToCartFromCounter({
    required qty,
    required skuId,
  }) async {
    try {
      showLoaderDialog();
      var body = {"productSkuId": skuId, "quantity": qty};
      var response =
          await repository.postApiCall(url: "product/add-cart", body: body);
      hideLoaderDialog();
      if (response != null) {
        addToCartModel = AddToCartModel.fromJson(response);
      } else {
        log("response != null => True");
      }
      getCartList(shouldShowLoader: false);
    } catch (e, stackTrace) {
      hideLoaderDialog();
      if (kDebugMode) {
        showAlertDialog(msg: e.toString());
      }
      log("productAddToCart error => ${stackTrace.toString()}");
    }
  }

  changeDeliveryAddress({required Addresses newAddress}) {
    deliveryAddress = newAddress;
    update(['checkout_screen']);
    Get.back();
  }

  getDeliveryAddress() async {
    try {
      List<dynamic>? response =
          await repository.getApiCall(url: "address/list");
      addressesList.clear();

      if (response != null && response.isNotEmpty) {
        for (var element in response) {
          addressesList.add(Addresses.fromJson(element));
        }
        addressesList.first.isSelected!(true);
        addressesList.refresh();
        deliveryAddress = addressesList.first;
        update(['checkout_screen']);
      } else {
        log("response != null => True");
      }
      log("addressesList length => ${addressesList.length.toString()}");
    } catch (e, stackTrace) {
      if (kDebugMode) {
        showAlertDialog(msg: e.toString());
      }
      log("getDeliveryAddress error => ${stackTrace.toString()}");
    }
  }

  addDeliveryAddress({required body}) async {
    try {
      showLoaderDialog();
      var response =
          await repository.postApiCall(url: "address/add", body: body);
      if (response != null) {
        await getDeliveryAddress();
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
      log("addDeliveryAddress error => ${stackTrace.toString()}");
    }
  }
}
