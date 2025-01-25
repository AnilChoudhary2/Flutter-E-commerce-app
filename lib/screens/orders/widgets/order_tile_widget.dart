import 'package:flutter/material.dart';
import 'package:yahmart/utils/common_colors.dart';
import 'package:yahmart/utils/common_logics.dart';
import '../../../model/order_list_model.dart';
import '../../../widgets/network_image_widget.dart';

class OrderTileWidget extends StatelessWidget {
  final OrderListModel orderListItem;
  const OrderTileWidget({Key? key, required this.orderListItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      margin: const EdgeInsets.only(bottom: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 30,
                child: ClipOval(
                  child: NetworkImageWidget(
                    imageUrl: orderListItem
                        .productVariant!.product!.productBannerImage
                        .toString(),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      orderListItem.productVariant!.product!.productName!,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: List.generate(
                        orderListItem.productVariant!.attributes!.length,
                        (index) => Text(
                          "${CommonLogics.toTitleCase(orderListItem.productVariant!.attributes![index].attributeName!)}: ${CommonLogics.toTitleCase(orderListItem.productVariant!.attributes![index].attributeValue!)}, ",
                          maxLines: 1,
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.normal,
                              color: Colors.black54),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total Item",
                style: TextStyle(
                  color: CommonColors.greyColor535353,
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                ),
              ),
              Text(
                "${orderListItem.quantity.toString()} item",
                style: TextStyle(
                  color: CommonColors.greyColor535353,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total Price",
                style: TextStyle(
                  color: CommonColors.greyColor535353,
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                ),
              ),
              Text(
                "   ₹ ${CommonLogics.convertValueInThousandFormat(inputString: (orderListItem.salePrice! * orderListItem.quantity!).toString())}",
                style: TextStyle(
                  color: CommonColors.greyColor535353,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Delivery Status",
                style: TextStyle(
                  color: CommonColors.greyColor535353,
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                ),
              ),
              Text(
                CommonLogics.getDeliveryStatus(status: orderListItem.status),
                style: TextStyle(
                  color: CommonColors.yellowColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
