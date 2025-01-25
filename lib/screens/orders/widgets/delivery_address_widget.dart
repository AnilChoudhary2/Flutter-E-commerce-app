import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/orders_notification_controller.dart';
import '../../../utils/common_colors.dart';

class DeliveryAddressWidget extends StatelessWidget {
  DeliveryAddressWidget({Key? key}) : super(key: key);

  /// find orders notification controller.
  final OrdersNotificationController _ordersNC = Get.find();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: CommonColors.whiteColor,
          borderRadius: BorderRadius.circular(8)),
      margin: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 12, top: 8, bottom: 10),
            child: Text(
              "DELIVERY ADDRESS",
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87),
            ),
          ),
          const Divider(
            thickness: 1,
            height: 1,
          ),
          const SizedBox(height: 6),
          ListTile(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
            subtitle: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${_ordersNC.orderDetailsData!.order!.shippingAddress!.houseNumber!}, ${_ordersNC.orderDetailsData!.order!.shippingAddress!.addressText!}, ${_ordersNC.orderDetailsData!.order!.shippingAddress!.streetName!}",
                  style: TextStyle(
                    color: CommonColors.greyColor535353,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  "${_ordersNC.orderDetailsData!.order!.shippingAddress!.city!}, ${_ordersNC.orderDetailsData!.order!.shippingAddress!.state!}",
                  style: TextStyle(
                    color: CommonColors.greyColor535353,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  "${_ordersNC.orderDetailsData!.order!.shippingAddress!.pincode!}, ${_ordersNC.orderDetailsData!.order!.shippingAddress!.country!}",
                  style: TextStyle(
                    color: CommonColors.greyColor535353,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  _ordersNC.orderDetailsData!.order!.shippingAddress!.mobile ??
                      "",
                  style: TextStyle(
                    color: CommonColors.greyColor535353,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 6)
        ],
      ),
    );
  }
}
