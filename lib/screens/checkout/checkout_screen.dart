import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yahmart/screens/checkout/widgets/address_bottom_sheet.dart';
import 'package:yahmart/screens/user_account/add_address_screen.dart';
import '../../controller/cart_checkout_controller.dart';
import '../../utils/common_colors.dart';
import '../../utils/common_logics.dart';
import '../../utils/screen_constants.dart';
import '../../widgets/outline_border_button.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({Key? key}) : super(key: key);

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  /// find CartCheckout controller.
  final CartCheckoutController _cartCheckoutC = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              onPressed: () => Get.back()),
          title: Text(
            "Checkout",
            style: TextStyle(
                color: CommonColors.appColor,
                fontWeight: FontWeight.bold,
                fontSize: FontSize.s16),
          ),
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          color: CommonColors.appBgColor,
          height: 55,
          child: Obx(() {
            return OutlineBorderButtonView(
              "Pay Now ₹ ${CommonLogics.convertValueInThousandFormat(inputString: _cartCheckoutC.cartSalePriceTotal.value.toString())}",
              onPressed: () => _cartCheckoutC.myCartPlaceOrder(),
              backgroundColor: CommonColors.appColor,
              color: CommonColors.whiteColor,
            );
          }),
        ),
        body: GetBuilder(
            id: 'checkout_screen',
            init: _cartCheckoutC,
            builder: (dynamic controller) {
              return ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${_cartCheckoutC.myCartList.length.toString()} Items in your cart",
                        maxLines: 1,
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.normal,
                            color: Colors.black54),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text(
                            "TOTAL",
                            maxLines: 1,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.normal,
                                color: Colors.black54),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            "₹ ${CommonLogics.convertValueInThousandFormat(inputString: _cartCheckoutC.cartSalePriceTotal.value.toString())}",
                            maxLines: 1,
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  _cartCheckoutC.deliveryAddress!.addressId != null
                      ? Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Deliver to:",
                                  maxLines: 1,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                                GestureDetector(
                                    onTap: () {
                                      Get.bottomSheet(
                                        AddressBottomSheet(),
                                      );
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 5),
                                      decoration: BoxDecoration(
                                          color: CommonColors.appBgColor,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border: Border.all(
                                              color: CommonColors.appColor)),
                                      child: Text(
                                        "Change",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: CommonColors.yellowColor),
                                      ),
                                    ))
                              ],
                            ),
                            const SizedBox(height: 14),
                            ListTile(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 16),
                              selectedTileColor: CommonColors.whiteColor,
                              selected: true,
                              selectedColor: CommonColors.blackColor,
                              title: Padding(
                                padding: const EdgeInsets.only(bottom: 5.0),
                                child: Text(
                                  _cartCheckoutC.deliveryAddress!.addressKind ??
                                      "".toString(),
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                              ),
                              subtitle: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      "${_cartCheckoutC.deliveryAddress!.houseNumber!}, ${_cartCheckoutC.deliveryAddress!.addressText!}, ${_cartCheckoutC.deliveryAddress!.streetName!}"),
                                  Text(
                                      "${_cartCheckoutC.deliveryAddress!.city!}, ${_cartCheckoutC.deliveryAddress!.state!}"),
                                  Text(
                                      "${_cartCheckoutC.deliveryAddress!.pincode!}, ${_cartCheckoutC.deliveryAddress!.country!}"),
                                  Text(_cartCheckoutC.deliveryAddress!.mobile ??
                                      ""),
                                ],
                              ),
                            ),
                          ],
                        )
                      : Container(),
                  const SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                        color: CommonColors.whiteColor,
                        borderRadius: BorderRadius.circular(8)),
                    child: GestureDetector(
                      onTap: () {
                        Get.to(() => const AddAddressScreen());
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          IconButton(
                            onPressed: () {
                              Get.to(() => const AddAddressScreen());
                            },
                            icon: Icon(
                              Icons.add,
                              color: CommonColors.yellowColor,
                            ),
                          ),
                          Text(
                            'Add Delivery Address',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: CommonColors.yellowColor),
                          ),
                          const SizedBox(width: 3)
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Payment method",
                    maxLines: 1,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  const SizedBox(height: 16),
                  Obx(() {
                    return Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                          color: CommonColors.whiteColor,
                          borderRadius: BorderRadius.circular(8)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Radio<String>(
                                value: "ONLINE",
                                groupValue:
                                    _cartCheckoutC.selectedPaymentMethod.value,
                                onChanged: (value) {
                                  _cartCheckoutC.selectedPaymentMethod(value);
                                },
                              ),
                              const SizedBox(width: 10),
                              const Text(
                                "Credit Debit Card/ UPI & Wallet",
                                maxLines: 1,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              // SvgPicture.asset(
                              //   CommonImages.razorpayIcon,
                              //   height: 20.0,
                              //   width: 20.0,
                              //   //  allowDrawingOutsideViewBox: true,
                              // ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Radio<String>(
                                value: "COD",
                                groupValue:
                                    _cartCheckoutC.selectedPaymentMethod.value,
                                onChanged: (value) {
                                  _cartCheckoutC.selectedPaymentMethod(value);
                                },
                              ),
                              const SizedBox(width: 10),
                              const Text(
                                "Cash On Delivery",
                                maxLines: 1,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    );
                  }),
                  // Container(
                  //   child: Image.asset(height: 200, CommonImages.creditIcon),
                  // )
                ],
              );
            }));
  }
}
