import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yahmart/controller/orders_notification_controller.dart';
import '../../../utils/common_colors.dart';
import '../../../utils/common_logics.dart';
import '../../../utils/screen_constants.dart';

class OrderSummaryWidget extends StatelessWidget {
  OrderSummaryWidget({Key? key}) : super(key: key);

  /// find product controller.
  final OrdersNotificationController _ordersNotificationC = Get.find();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: CommonColors.whiteColor,
          borderRadius: BorderRadius.circular(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Price (${_ordersNotificationC.orderDetailsData!.quantity} item)",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: CommonColors.blackColor,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                "₹ ${CommonLogics.convertValueInThousandFormat(inputString: (_ordersNotificationC.orderDetailsData!.productVariant!.basePrice! * _ordersNotificationC.orderDetailsData!.quantity!).toString())}",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: FontSize.s14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Discount",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: CommonColors.blackColor,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                "- ₹ ${CommonLogics.convertValueInThousandFormat(inputString: ((_ordersNotificationC.orderDetailsData!.productVariant!.basePrice! * _ordersNotificationC.orderDetailsData!.quantity!) - (_ordersNotificationC.orderDetailsData!.salePrice! * _ordersNotificationC.orderDetailsData!.quantity!)).toStringAsFixed(0))}",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: CommonColors.yellowColor,
                  fontSize: FontSize.s14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Coupon",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: CommonColors.blackColor,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                "₹ 0",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: FontSize.s14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Delivery Charge",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: CommonColors.blackColor,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                "₹ 0",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: FontSize.s14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total Amount",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: CommonColors.blackColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "₹ ${CommonLogics.convertValueInThousandFormat(inputString: (_ordersNotificationC.orderDetailsData!.salePrice! * _ordersNotificationC.orderDetailsData!.quantity!).toString())}",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
