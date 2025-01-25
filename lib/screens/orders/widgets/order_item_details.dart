import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/orders_notification_controller.dart';
import '../../../utils/common_colors.dart';
import '../../../utils/common_logics.dart';
import '../../../widgets/network_image_widget.dart';

class OrderItemDetails extends StatelessWidget {
  OrderItemDetails({Key? key}) : super(key: key);

  /// find orders notification controller.
  final OrdersNotificationController _ordersNC = Get.find();
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
            color: CommonColors.whiteColor,
            borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                    height: 100,
                    width: 70,
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: NetworkImageWidget(
                        imageUrl: _ordersNC.orderDetailsData!.productVariant!
                            .product!.productBannerImage!
                            .toString(),
                      ),
                    )),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                  flex: 9,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _ordersNC.orderDetailsData!.productVariant!.product!
                            .productName!,
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
                          _ordersNC.orderDetailsData!.productVariant!
                              .attributes!.length,
                          (index) => Text(
                            "${CommonLogics.toTitleCase(_ordersNC.orderDetailsData!.productVariant!.attributes![index].attributeName!)}: ${CommonLogics.toTitleCase(_ordersNC.orderDetailsData!.productVariant!.attributes![index].attributeValue!)}, ",
                            maxLines: 1,
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.normal,
                                color: Colors.black54),
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 3),
                          Text(
                            _ordersNC.orderDetailsData!.productVariant!.product!
                                .productDescription!,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.black87),
                          ),
                          const SizedBox(height: 5),
                          RichText(
                            text: TextSpan(
                              children: <TextSpan>[
                                const TextSpan(
                                  text: "₹ ",
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      CommonLogics.convertValueInThousandFormat(
                                          inputString: _ordersNC
                                              .orderDetailsData!
                                              .productVariant!
                                              .basePrice!
                                              .toString()),
                                  style: const TextStyle(
                                    color: Colors.black54,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      "   ₹ ${CommonLogics.convertValueInThousandFormat(inputString: _ordersNC.orderDetailsData!.productVariant!.salePrice.toString())}",
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      "   ${CommonLogics.getCalculatedDiscount(basePrice: _ordersNC.orderDetailsData!.productVariant!.basePrice!, salePrice: _ordersNC.orderDetailsData!.productVariant!.salePrice!)}% off",
                                  style: TextStyle(
                                    color: CommonColors.yellowColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 3),
                        ],
                      ),
                    ],
                  ))
            ],
          ),
        ));
  }
}
