import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yahmart/controller/orders_notification_controller.dart';
import 'package:yahmart/screens/notification/widgets/notification_cart.dart';
import 'package:yahmart/utils/common_logics.dart';
import '../../utils/common_colors.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
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
      _ordersNC.getNotificationList(shouldShowLoader: false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CommonColors.appBgColor,
      body: Obx(() {
        return _ordersNC.isNotificationListLoading.value
            ? Center(
                child: CircularProgressIndicator(
                  color: CommonColors.appColor,
                ),
              )
            : ScrollConfiguration(
                behavior: const ScrollBehavior().copyWith(overscroll: false),
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return NotificationCart(
                        index: index,
                      );
                    }),
              );
      }),
    );
  }
}
