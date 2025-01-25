import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upgrader/upgrader.dart';
import 'package:yahmart/controller/home_controller.dart';
import 'package:yahmart/screens/home/widgets/home_search_text_field.dart';
import 'package:yahmart/screens/home/widgets/low_price_store_widget.dart';
import 'package:yahmart/utils/common_colors.dart';
import 'package:yahmart/screens/home/widgets/home_carousel_slider.dart';
import 'package:yahmart/widgets/view_all_row.dart';
import '../../controller/product_controller.dart';
import '../product_details/product_details_screen.dart';
import '../product_details/widgets/you_may_like_card_widget.dart';
import 'widgets/home_categories_widget.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  /// find home controller.
  final HomeController _homeC = Get.find();

  /// find product controller.
  final ProductController _productC = Get.find();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((Duration time) => init());
    super.initState();
  }

  init() {}

  @override
  Widget build(BuildContext context) {
    return UpgradeAlert(
      upgrader: Upgrader(
        // debugDisplayAlways: true,
        // debugLogging: true,
        showReleaseNotes: false,
        shouldPopScope: () => true,
        canDismissDialog: false,
        showLater: false,
        showIgnore: false,
        durationUntilAlertAgain: const Duration(minutes: 1),
        dialogStyle: Platform.isIOS
            ? UpgradeDialogStyle.cupertino
            : UpgradeDialogStyle.material,
      ),
      child: Scaffold(
        backgroundColor: CommonColors.appBgColor,
        body: RefreshIndicator(
          onRefresh: () async {
            await _homeC.getHomeCategoryList(shouldShowLoader: false);
            await _productC.getProductList(shouldShowLoader: false);
            await _homeC.getHomeBannersList();
          },
          child: ScrollConfiguration(
              behavior: const ScrollBehavior().copyWith(overscroll: false),
              child: ListView(
                children: [
                  const SizedBox(height: 10),
                  HomeCategoriesWidget(),
                  const SizedBox(height: 15),
                  HomeSearchTextField(),
                  const SizedBox(height: 10),
                  HomeCarouselSlider(),
                  const SizedBox(height: 10),
                  Column(
                    children: [
                      ViewAllRow(
                        title: 'Low Price Store',
                        onPressed: () {},
                      ),
                      const SizedBox(height: 10),
                      LowPriceStoreWidget(),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Column(
                    children: [
                      ViewAllRow(
                        title: 'Popular',
                        onPressed: () {},
                      ),
                      const SizedBox(height: 10),
                      LowPriceStoreWidget(),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Obx(() {
                    return Column(
                      children: [
                        _productC.productListData.isNotEmpty
                            ? SizedBox(
                                height: 300,
                                child: Column(
                                  children: [
                                    ViewAllRow(
                                      title: 'Trending Product',
                                      onPressed: () {},
                                    ),
                                    const SizedBox(height: 10),
                                    Expanded(
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                          children: List.generate(
                                              _productC.productListData.length,
                                              (index) {
                                            return GestureDetector(
                                                onTap: () {
                                                  Get.to(() =>
                                                      ProductDetailsScreen(
                                                        productId: _productC
                                                            .productListData[
                                                                index]
                                                            .productId,
                                                        brandName: _productC
                                                            .productListData[
                                                                index]
                                                            .brand!
                                                            .brandName!,
                                                      ));
                                                },
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 6, bottom: 0),
                                                  width: 180,
                                                  child: YouMayLikeCardWidget(
                                                    productListData: _productC
                                                        .productListData[index],
                                                  ),
                                                ));
                                          }),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : Container(),
                        const SizedBox(height: 10),
                        _productC.productListData2.isNotEmpty
                            ? SizedBox(
                                height: 300,
                                child: Column(
                                  children: [
                                    ViewAllRow(
                                      title: 'Best Product For You',
                                      onPressed: () {},
                                    ),
                                    const SizedBox(height: 10),
                                    Expanded(
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                          children: List.generate(
                                              _productC.productListData2.length,
                                              (index) {
                                            return GestureDetector(
                                                onTap: () {
                                                  Get.to(() =>
                                                      ProductDetailsScreen(
                                                        productId: _productC
                                                            .productListData2[
                                                                index]
                                                            .productId,
                                                        brandName: _productC
                                                            .productListData2[
                                                                index]
                                                            .brand!
                                                            .brandName!,
                                                      ));
                                                },
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 6, bottom: 0),
                                                  width: 180,
                                                  child: YouMayLikeCardWidget(
                                                    productListData: _productC
                                                            .productListData2[
                                                        index],
                                                  ),
                                                ));
                                          }),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : Container(),
                      ],
                    );
                  }),
                  const SizedBox(height: 50),
                ],
              )),
        ),
      ),
    );
  }
}
