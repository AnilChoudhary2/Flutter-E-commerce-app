import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/orders_notification_controller.dart';
import '../../../utils/common_colors.dart';
import '../../../utils/common_logics.dart';
import '../../../utils/common_values.dart';
import '../../../utils/custom_alert_dialog.dart';
import '../../../utils/screen_constants.dart';
import '../../../widgets/outline_border_button.dart';
import '../help_and_support_screen.dart';
import 'order_return_bottom_sheet.dart';

class OrderBasicDetailsWidget extends StatelessWidget {
  OrderBasicDetailsWidget({Key? key}) : super(key: key);

  /// find orders notification controller.
  final OrdersNotificationController _ordersNC = Get.find();
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        id: 'delivery_status_update',
        init: _ordersNC,
        builder: (dynamic controller) {
          return Container(
            margin: const EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
                color: CommonColors.whiteColor,
                borderRadius: BorderRadius.circular(8)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 12, top: 8, bottom: 10),
                  child: Text(
                    "ORDER DETAILS",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87),
                  ),
                ),
                Container(
                  color: CommonColors.appBgColor,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Customer Name",
                        style: TextStyle(
                          color: CommonColors.greyColor535353,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        child: Text(
                          _ordersNC.orderDetailsData!.order!.user!.displayName!
                              .toString(),
                          maxLines: 1,
                          textAlign: TextAlign.end,
                          //overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: CommonColors.greyColor535353,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Order ID",
                        style: TextStyle(
                          color: CommonColors.greyColor535353,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        child: Text(
                          _ordersNC.orderDetailsData!.orderItemId!.toString(),
                          maxLines: 1,
                          textAlign: TextAlign.end,
                          //overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: CommonColors.greyColor535353,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: CommonColors.appBgColor,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Order Placed",
                        style: TextStyle(
                          color: CommonColors.greyColor535353,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        CommonLogics.getDateFromUtc(
                          _ordersNC.orderDetailsData!.order!.createdDate!,
                          CommonValues.ddMmYyyyAa,
                        ),
                        style: TextStyle(
                          color: CommonColors.greyColor535353,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Delivery Date",
                        style: TextStyle(
                          color: CommonColors.greyColor535353,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        CommonLogics.getDateFromUtc(
                          _ordersNC.orderDetailsData!.order!.deliveryDate!,
                          CommonValues.ddMmYyyyAa,
                        ),
                        style: TextStyle(
                          color: CommonColors.greyColor535353,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: CommonColors.appBgColor,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Estimated Delivery",
                        style: TextStyle(
                          color: CommonColors.greyColor535353,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        CommonLogics.getDateFromUtc(
                          _ordersNC.orderDetailsData!.order!.createdDate!,
                          CommonValues.ddMmYyyyAa,
                        ),
                        style: TextStyle(
                          color: CommonColors.greyColor535353,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Delivery Status",
                        style: TextStyle(
                          color: CommonColors.greyColor535353,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        CommonLogics.getDeliveryStatus(
                            status: _ordersNC.orderDetailsData!.status!.value),
                        style: TextStyle(
                          color: CommonColors.yellowColor,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: CommonColors.appBgColor,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Payment Mode",
                        style: TextStyle(
                          color: CommonColors.greyColor535353,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        _ordersNC.orderDetailsData?.order?.paymentType ?? "",
                        style: TextStyle(
                          color: CommonColors.greyColor535353,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 12),
                  child: Row(
                    children: [
                      Expanded(
                        child: OutlineBorderButtonView(
                          "Help & Support",
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          onPressed: () async {
                            Get.to(() => const HelpAndSupportScreen());
                          },
                          backgroundColor: CommonColors.whiteColor,
                          color: CommonColors.blackColor,
                          fontSize: FontSize.s15,
                        ),
                      ),
                      const SizedBox(width: 20),
                      if (_ordersNC.orderDetailsData!.status!.value ==
                              "DELIVEREY_COMPLETE" ||
                          _ordersNC.orderDetailsData!.status!.value ==
                              "REPLACEMENT_COMPLETE")
                        Expanded(
                          child: OutlineBorderButtonView(
                            "Return",
                            onPressed: () async {
                              Get.bottomSheet(OrderReturnBottomSheet());
                            },
                            backgroundColor: CommonColors.appColor,
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            color: CommonColors.whiteColor,
                            fontSize: FontSize.s15,
                          ),
                        ),
                      if (_ordersNC.orderDetailsData!.status!.value ==
                              "PENDING" ||
                          _ordersNC.orderDetailsData!.status!.value ==
                              "PAYMENT_COMPLETE" ||
                          _ordersNC.orderDetailsData!.status!.value ==
                              "OUT_FOR_DELIVERY")
                        Expanded(
                          child: OutlineBorderButtonView(
                            "Cancel",
                            onPressed: () async {
                              showAlertDialogOnPressed(
                                  msg:
                                      'Are you sure you want to cancel this order?',
                                  onPressed: () {
                                    Get.back();
                                    _ordersNC.callOrderCancelApi(
                                        orderId: _ordersNC
                                            .orderDetailsData!.orderItemId);
                                  });
                            },
                            backgroundColor: CommonColors.appColor,
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            color: CommonColors.whiteColor,
                            fontSize: FontSize.s15,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
