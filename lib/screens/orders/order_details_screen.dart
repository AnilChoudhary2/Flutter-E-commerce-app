import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yahmart/screens/orders/widgets/order_basic_details_widget.dart';
import 'package:yahmart/widgets/share_button.dart';
import '../../controller/home_controller.dart';
import '../../controller/orders_notification_controller.dart';
import '../../controller/product_controller.dart';
import '../../utils/common_colors.dart';
import '../../utils/common_logics.dart';
import '../../utils/screen_constants.dart';
import '../../widgets/no_data_screen_widget.dart';
import '../../widgets/outline_border_button.dart';
import '../home/home_screen.dart';
import '../product_details/widgets/you_may_like_also_widget.dart';
import 'add_review_screen.dart';
import 'widgets/delivery_address_widget.dart';
import 'widgets/order_item_details.dart';
import 'widgets/order_summary_widget.dart';

class OrderDetailsScreen extends StatefulWidget {
  final String? orderId;
  const OrderDetailsScreen({Key? key, required this.orderId}) : super(key: key);

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  /// find orders notification controller.
  final OrdersNotificationController _ordersNC = Get.find();

  /// find product controller.
  final ProductController _productC = Get.find();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((Duration time) => init());
    super.initState();
  }

  init() async {
    await _ordersNC.getOrdersDetails(orderId: widget.orderId);
    await _productC.getProductList();
  }

  Future<bool> _onWillPopeScopeBack() async {
    if (Get.isRegistered<HomeController>()) {
      Get.back();
    } else {
      final HomeController homeC = Get.put(HomeController());
      Get.to(() => const HomeScreen());
      homeC.selectedTabIndex(1);
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPopeScopeBack,
      child: Scaffold(
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
                onPressed: _onWillPopeScopeBack),
            title: Text(
              "Order Details",
              style: TextStyle(
                  color: CommonColors.appColor,
                  fontWeight: FontWeight.bold,
                  fontSize: FontSize.s16),
            ),
            actions: const [
              // Obx(() {
              //   return _ordersNC.isOrdersDetailsLoading.value
              //       ? Container()
              //       : ShareButton(
              //           onPressed: () async {
              //             String? productImage = _ordersNC.orderDetailsData!
              //                     .productVariant!.product!.productBannerImage!
              //                     .startsWith("http")
              //                 ? _ordersNC.orderDetailsData!.productVariant!
              //                     .product!.productBannerImage
              //                 : "https://yahmartindia.in/api/v1/${_ordersNC.orderDetailsData!.productVariant!.product!.productBannerImage}";
              //             await CommonLogics.saveAndShare(
              //               productImage!,
              //               '${_ordersNC.orderDetailsData!.productVariant!.product!.productName}\n$productImage\n\nhttps://yahmartindia.in/product/${_ordersNC.orderDetailsData!.productVariant!.product!}\nYou can find our app from below url,\n\n Android:\nhttps://play.google.com/store/apps/details?id=com.app.yahmartindia\niOS:\nhttps://apps.apple.com/us/app/yahmart-india-private-limited/id6446877479',
              //             );
              //           },
              //         );
              // }),
              SizedBox(width: 15),
            ],
          ),
          body: Obx(() {
            return _ordersNC.isOrdersDetailsLoading.value
                ? Center(
                    child: CircularProgressIndicator(
                      color: CommonColors.appColor,
                    ),
                  )
                : ScrollConfiguration(
                    behavior:
                        const ScrollBehavior().copyWith(overscroll: false),
                    child: RefreshIndicator(
                        onRefresh: () async {
                          _ordersNC.getOrdersDetails(
                              shouldShowLoader: false, orderId: widget.orderId);
                          return;
                        },
                        child: _ordersNC.orderDetailsData!.productVariant !=
                                null
                            ? ListView(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: Column(
                                      children: [
                                        OrderItemDetails(),
                                        DeliveryAddressWidget(),
                                        OrderBasicDetailsWidget(),
                                        OrderSummaryWidget(),
                                        const SizedBox(height: 10),
                                        if (_ordersNC.orderDetailsData!.status!
                                                    .value ==
                                                "DELIVEREY_COMPLETE" ||
                                            _ordersNC.orderDetailsData!.status!
                                                    .value ==
                                                "RETURN_COMPLETE" ||
                                            _ordersNC.orderDetailsData!.status!
                                                    .value ==
                                                "REPLACEMENT_COMPLETE")
                                          Row(
                                            children: [
                                              Expanded(
                                                child: OutlineBorderButtonView(
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 10),
                                                  "Add Review",
                                                  onPressed: () async {
                                                    Get.to(() =>
                                                        const AddReviewScreen());
                                                  },
                                                  backgroundColor:
                                                      CommonColors.whiteColor,
                                                  color:
                                                      CommonColors.blackColor,
                                                  fontSize: FontSize.s15,
                                                ),
                                              ),
                                              const SizedBox(width: 10),
                                              Expanded(
                                                  child:
                                                      OutlineBorderButtonView(
                                                "Place Order",
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 10),
                                                onPressed: () async {
                                                  _ordersNC.placeNewOrder();
                                                },
                                                backgroundColor:
                                                    CommonColors.appColor,
                                                color: CommonColors.whiteColor,
                                                fontSize: FontSize.s15,
                                              )),
                                            ],
                                          ),
                                        const SizedBox(height: 10),
                                      ],
                                    ),
                                  ),
                                  YouMayLikeAlsoWidget(),
                                ],
                              )
                            : const NoDataScreen()),
                  );
          })),
    );
  }
}
