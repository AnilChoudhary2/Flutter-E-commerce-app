import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yahmart/controller/cart_checkout_controller.dart';
import 'package:yahmart/screens/my_cart/widgets/cart_product_tile_widget.dart';
import 'package:yahmart/screens/my_cart/widgets/check_coupon_code_widget.dart';
import 'package:yahmart/screens/my_cart/widgets/order_price_list_widget.dart';
import 'package:yahmart/utils/screen_constants.dart';
import '../../model/coupon_code_model.dart';
import '../../utils/common_colors.dart';
import '../../widgets/no_data_screen_widget.dart';
import '../../widgets/outline_border_button.dart';

class MyCartScreen extends StatefulWidget {
  const MyCartScreen({Key? key}) : super(key: key);

  @override
  State<MyCartScreen> createState() => _MyCartScreenState();
}

class _MyCartScreenState extends State<MyCartScreen> {
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
            "My Cart",
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
                    "Place Order",
                    onPressed: () {
                      _cartCheckoutC.goForCheckout();
                    },
                    backgroundColor: CommonColors.appColor,
                    color: CommonColors.whiteColor,
                    fontSize: FontSize.s15,
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
              : ScrollConfiguration(
                  behavior: const ScrollBehavior().copyWith(overscroll: false),
                  child: RefreshIndicator(
                    onRefresh: () async {
                      _cartCheckoutC.getCartList(shouldShowLoader: false);
                      return;
                    },
                    child: _cartCheckoutC.myCartList.isNotEmpty
                        ? ListView(
                            children: [
                              ListView.builder(
                                  physics:
                                      const NeverScrollableScrollPhysics(), // new
                                  shrinkWrap: true,
                                  itemCount: _cartCheckoutC.myCartList.length,
                                  itemBuilder: (context, index) {
                                    return CardProductTileWidget(
                                      cartListItem:
                                          _cartCheckoutC.myCartList[index],
                                    );
                                  }),
                              const SizedBox(height: 10),
                              CheckCouponCodeWidget(),
                              const SizedBox(height: 10),
                              OrderPriceListWidget(),
                              const SizedBox(height: 10),
                            ],
                          )
                        : const NoDataScreen(),
                  ),
                );
        }));
  }
}
