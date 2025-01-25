import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yahmart/controller/cart_checkout_controller.dart';
import 'package:yahmart/utils/screen_constants.dart';
import '../../model/coupon_code_model.dart';
import '../../utils/common_colors.dart';
import '../../utils/common_logics.dart';
import '../../widgets/outline_border_button.dart';
import '../checkout/widgets/address_bottom_sheet.dart';
import '../my_cart/widgets/check_coupon_code_widget.dart';
import '../user_account/add_address_screen.dart';
import 'widgets/buy_now_product_price_list.dart';
import 'widgets/buy_now_product_tile.dart';

class BuyNowScreen extends StatefulWidget {
  const BuyNowScreen({Key? key}) : super(key: key);

  @override
  State<BuyNowScreen> createState() => _BuyNowScreenState();
}

class _BuyNowScreenState extends State<BuyNowScreen> {
  /// find CartCheckout controller.
  final CartCheckoutController _cartCheckoutC = Get.find();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((Duration time) => init());
    super.initState();
  }

  init() {
    _cartCheckoutC.getCartList();
    _cartCheckoutC.selectedCouponCode = CouponCodeModel().obs();
    _cartCheckoutC.couponCodeTextField.clear();
    for (var element in _cartCheckoutC.allCouponList) {
      element.isSelected!(false);
    }
  }

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
            "Buy Now",
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
            return _cartCheckoutC.isCartListLoading.value ||
                    _cartCheckoutC.myCartList.isEmpty
                ? Container(
                    height: 10,
                  )
                : OutlineBorderButtonView(
                    "Place Order ₹ ${CommonLogics.convertValueInThousandFormat(inputString: (_cartCheckoutC.buyNowProduct!.productVariant!.salePrice! * _cartCheckoutC.buyNowProduct!.quantity!).toString())}",
                    onPressed: () => _cartCheckoutC.singleProductPlaceOrder(),
                    backgroundColor: CommonColors.appColor,
                    color: CommonColors.whiteColor,
                  );
          }),
        ),
        body: Obx(() {
          return _cartCheckoutC.isCartListLoading.value
              ? Center(
                  child: CircularProgressIndicator(
                    color: CommonColors.appColor,
                  ),
                )
              : ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  children: [
                    GetBuilder(
                        id: 'checkout_screen',
                        init: _cartCheckoutC,
                        builder: (dynamic controller) {
                          return _cartCheckoutC.buyNowProduct!.productVariant !=
                                  null
                              ? BuyNowProductTile()
                              : Container();
                        }),
                    const SizedBox(height: 20),
                    GetBuilder(
                        id: 'checkout_screen',
                        init: _cartCheckoutC,
                        builder: (dynamic controller) {
                          return _cartCheckoutC.deliveryAddress!.addressId !=
                                  null
                              ? Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
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
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 15,
                                                      vertical: 5),
                                              decoration: BoxDecoration(
                                                  color:
                                                      CommonColors.appBgColor,
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  border: Border.all(
                                                      color: CommonColors
                                                          .appColor)),
                                              child: Text(
                                                "Change",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    color: CommonColors
                                                        .yellowColor),
                                              ),
                                            ))
                                      ],
                                    ),
                                    const SizedBox(height: 14),
                                    ListTile(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 12, horizontal: 16),
                                      selectedTileColor:
                                          CommonColors.whiteColor,
                                      selected: true,
                                      selectedColor: CommonColors.blackColor,
                                      title: Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 5.0),
                                        child: Text(
                                          _cartCheckoutC.deliveryAddress!
                                                  .addressKind ??
                                              "".toString(),
                                          style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        ),
                                      ),
                                      subtitle: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              "${_cartCheckoutC.deliveryAddress!.houseNumber!}, ${_cartCheckoutC.deliveryAddress!.addressText!}, ${_cartCheckoutC.deliveryAddress!.streetName!}"),
                                          Text(
                                              "${_cartCheckoutC.deliveryAddress!.city!}, ${_cartCheckoutC.deliveryAddress!.state!}"),
                                          Text(
                                              "${_cartCheckoutC.deliveryAddress!.pincode!}, ${_cartCheckoutC.deliveryAddress!.country!}"),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              : Container();
                        }),
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
                    CheckCouponCodeWidget(),
                    const SizedBox(height: 10),
                    GetBuilder(
                        id: 'checkout_screen',
                        init: _cartCheckoutC,
                        builder: (dynamic controller) {
                          return _cartCheckoutC.buyNowProduct!.productVariant !=
                                  null
                              ? BuyNowProductPriceList()
                              : Container();
                        }),
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
                                  groupValue: _cartCheckoutC
                                      .selectedPaymentMethod.value,
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
                                  groupValue: _cartCheckoutC
                                      .selectedPaymentMethod.value,
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
                    const SizedBox(height: 16),
                  ],
                );
        }));
  }
}
