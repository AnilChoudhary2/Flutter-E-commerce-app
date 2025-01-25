import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loadmore/loadmore.dart';
import 'package:yahmart/controller/orders_notification_controller.dart';
import 'package:yahmart/screens/orders/order_details_screen.dart';
import 'package:yahmart/screens/orders/widgets/order_tile_widget.dart';
import '../../utils/common_colors.dart';
import '../../utils/common_logics.dart';
import '../../widgets/no_data_screen_widget.dart';

class MyOrdersScreen extends StatefulWidget {
  const MyOrdersScreen({Key? key}) : super(key: key);
  @override
  State<MyOrdersScreen> createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen> {
  /// find orders notification controller.
  final OrdersNotificationController _ordersNC = Get.find();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((Duration time) => init());
    super.initState();
  }

  init() {
    bool isLogin = CommonLogics.checkUserLogin();
    if (isLogin) {
      _ordersNC.isFinishLoadMore(false);
      _ordersNC.pageNumber(1);
      _ordersNC.getOrdersList(shouldShowLoader: false, isPageRefresh: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: CommonColors.appBgColor,
        body: Obx(() {
          return _ordersNC.isOrdersListLoading.value
              ? Center(
                  child: CircularProgressIndicator(
                    color: CommonColors.appColor,
                  ),
                )
              : ScrollConfiguration(
                  behavior: const ScrollBehavior().copyWith(overscroll: false),
                  child: RefreshIndicator(
                    onRefresh: () async {
                      _ordersNC.isFinishLoadMore(false);
                      _ordersNC.pageNumber(1);
                      await _ordersNC.getOrdersList(
                          shouldShowLoader: false, isPageRefresh: true);
                      return;
                    },
                    child: _ordersNC.myOrdersList.isNotEmpty
                        ? LoadMore(
                            isFinish: _ordersNC.isFinishLoadMore.value,
                            onLoadMore: _ordersNC.loadMore,
                            textBuilder: DefaultLoadMoreTextBuilder.english,
                            child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: _ordersNC.myOrdersList.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                      onTap: () {
                                        Get.to(() => OrderDetailsScreen(
                                              orderId: _ordersNC
                                                  .myOrdersList[index]
                                                  .orderItemId,
                                            ));
                                      },
                                      child: OrderTileWidget(
                                        orderListItem:
                                            _ordersNC.myOrdersList[index],
                                      ));
                                }))
                        : const NoDataScreen(),
                  ),
                );
        }));
  }
}
