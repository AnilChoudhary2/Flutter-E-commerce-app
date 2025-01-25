import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:yahmart/model/notification_model.dart';
import '../model/order_details_model.dart';
import '../model/order_list_model.dart';
import '../repository/repository.dart';
import '../screens/buy_now/buy_now_screen.dart';
import '../utils/common_logics.dart';
import '../utils/custom_alert_dialog.dart';
import '../widgets/loader_dialog.dart';
import '../widgets/login_bottom_sheet.dart';
import 'cart_checkout_controller.dart';

class OrdersNotificationController extends GetxController {
  Repository repository = Repository();
  RxList<OrderListModel> myOrdersList = <OrderListModel>[].obs;
  RxList<NotificationModel> notificationList = <NotificationModel>[].obs;
  OrderDetailsModel? orderDetailsData = OrderDetailsModel().obs();
  RxBool isNotificationListLoading = true.obs;
  RxBool isOrdersListLoading = true.obs;
  RxBool isOrdersDetailsLoading = true.obs;
  RxBool isFinishLoadMore = false.obs;
  RxInt pageNumber = 1.obs;

  @override
  void onInit() async {
    repository.initRepo();
    bool isLogin = CommonLogics.checkUserLogin();
    if (isLogin) {
      await getOrdersList();
      await getNotificationList();
    }
    super.onInit();
  }

  /// loadMore method calling when user scrolling all error page and getting get_all_error_api pagination data.
  Future<bool> loadMore() async {
    await Future.delayed(const Duration(seconds: 0, milliseconds: 2000));
    await getOrdersList(shouldShowLoader: false);
    return true;
  }

  getOrdersList(
      {bool shouldShowLoader = true, bool isPageRefresh = false}) async {
    try {
      String qParams = "pageSize=20&current=${pageNumber.value}";
      if (shouldShowLoader) isOrdersListLoading(true);
      List<dynamic>? response =
          await repository.getApiCall(url: "order/list?$qParams");
      if (isPageRefresh) myOrdersList.clear();
      if (response != null && response.isNotEmpty) {
        for (var element in response) {
          myOrdersList.add(OrderListModel.fromJson(element));
        }
        pageNumber.value += 1;
      } else {
        log("response != null => True");

        /// Changing isFinishLoadMore flag true when no more data available in pagination api.
        isFinishLoadMore(true);
        log("else loadMore(${pageNumber.toString()})");
      }
      log("myOrdersList length => ${myOrdersList.length.toString()}");
      if (shouldShowLoader) isOrdersListLoading(false);
    } catch (e, stackTrace) {
      if (shouldShowLoader) isOrdersListLoading(false);
      if (kDebugMode) {
        showAlertDialog(msg: e.toString());
      }
      log("getOrdersList error => ${stackTrace.toString()}");
    }
  }

  getOrdersDetails({bool shouldShowLoader = true, required orderId}) async {
    try {
      orderDetailsData = OrderDetailsModel();
      if (shouldShowLoader) isOrdersDetailsLoading(true);
      var response = await repository.getApiCall(url: "order/details/$orderId");
      if (response != null) {
        orderDetailsData = OrderDetailsModel.fromJson(response);
        update(["delivery_status_update"]);
      } else {
        log("response != null => True");
      }
      if (shouldShowLoader) isOrdersDetailsLoading(false);
    } catch (e, stackTrace) {
      if (shouldShowLoader) isOrdersDetailsLoading(false);
      if (kDebugMode) {
        showAlertDialog(msg: e.toString());
      }
      log("getOrdersDetails error => ${stackTrace.toString()}");
    }
  }

  callOrderCancelApi({required orderId}) async {
    try {
      var body = {"orderItemId": orderId, "status": "CANCELLED"};
      showLoaderDialog();
      var response = await repository.postApiCall(
          url: "order/cancel/$orderId", body: body);
      if (response != null) {
        await getOrdersDetails(orderId: orderId, shouldShowLoader: false);
        hideLoaderDialog();
      } else {
        log("response != null => True");
        hideLoaderDialog();
      }
    } catch (e, stackTrace) {
      hideLoaderDialog();
      if (kDebugMode) {
        showAlertDialog(msg: e.toString());
      }
      log("callOrderCancelApi error => ${stackTrace.toString()}");
    }
  }

  callOrderExchangeApi({required orderId}) async {
    try {
      var body = {"orderItemId": orderId, "status": "USER_REPLACE_REQUESTED"};
      showLoaderDialog();
      var response = await repository.postApiCall(
          url: "order/cancel/$orderId", body: body);
      if (response != null) {
        await getOrdersDetails(orderId: orderId, shouldShowLoader: false);
        hideLoaderDialog();
      } else {
        log("response != null => True");
        hideLoaderDialog();
      }
    } catch (e, stackTrace) {
      hideLoaderDialog();
      if (kDebugMode) {
        showAlertDialog(msg: e.toString());
      }
      log("callOrderCancelApi error => ${stackTrace.toString()}");
    }
  }

  callOrderRefundApi({required orderId}) async {
    try {
      var body = {"orderItemId": orderId, "status": "RETURN_REQUESTED"};
      showLoaderDialog();
      var response = await repository.postApiCall(
          url: "order/return/$orderId", body: body);
      if (response != null) {
        await getOrdersDetails(orderId: orderId, shouldShowLoader: false);
        hideLoaderDialog();
      } else {
        log("response != null => True");
        hideLoaderDialog();
      }
    } catch (e, stackTrace) {
      hideLoaderDialog();
      if (kDebugMode) {
        showAlertDialog(msg: e.toString());
      }
      log("callOrderCancelApi error => ${stackTrace.toString()}");
    }
  }

  getNotificationList({bool shouldShowLoader = true}) async {
    try {
      if (shouldShowLoader) isNotificationListLoading(true);
      var response = await repository.getApiCall(url: "notification/list");
      notificationList.clear();
      if (response != null) {
        response.forEach((element) async {
          notificationList.add(NotificationModel.fromJson(element));
        });
      } else {
        log("response != null => True");
      }
      log("notificationList length => ${notificationList.length.toString()}");
      if (shouldShowLoader) isNotificationListLoading(false);
    } catch (e, stackTrace) {
      if (shouldShowLoader) isNotificationListLoading(false);
      if (kDebugMode) {
        showAlertDialog(msg: e.toString());
      }
      log("getNotificationList error => ${stackTrace.toString()}");
    }
  }

  addProductAddReview({required body}) async {
    try {
      showLoaderDialog();
      var response =
          await repository.postApiCall(url: "product/add-review", body: body);
      if (response != null) {
        Get.back();
        hideLoaderDialog();
        showToastMessage(msg: "Review added successfully!");
      } else {
        hideLoaderDialog();
        log("response != null => True");
      }
    } catch (e, stackTrace) {
      hideLoaderDialog();
      if (kDebugMode) {
        showAlertDialog(msg: e.toString());
      }
      log("addProductAddReview error => ${stackTrace.toString()}");
    }
  }

  placeNewOrder() async {
    final CartCheckoutController cartCheckoutC = Get.find();
    bool isLogin = CommonLogics.checkUserLogin();
    if (isLogin) {
      if (orderDetailsData!.productVariant!.availableStock! > 0) {
        cartCheckoutC.byNowSingleProductId(
            orderDetailsData!.productVariant!.productSkuId);
        await cartCheckoutC.productAddToCart(
            skuId: orderDetailsData!.productVariant!.productSkuId, qty: 1);
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
}
