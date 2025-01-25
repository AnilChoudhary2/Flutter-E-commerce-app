import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yahmart/screens/product_listing/widgets/product_listing_card.dart';
import 'package:yahmart/utils/common_colors.dart';
import 'package:yahmart/widgets/no_data_screen_widget.dart';
import '../../controller/product_controller.dart';
import '../../model/price_range_model.dart';
import '../../model/product_sorting_model.dart';
import '../../widgets/cart_button.dart';
import '../../widgets/favorite_button.dart';
import '../product_details/product_details_screen.dart';
import 'widgets/footer_widget.dart';

class ProductListingScreen extends StatefulWidget {
  final String? categoryId;
  final String? searchText;
  const ProductListingScreen({Key? key, this.categoryId, this.searchText})
      : super(key: key);

  @override
  State<ProductListingScreen> createState() => _ProductListingScreenState();
}

class _ProductListingScreenState extends State<ProductListingScreen> {
  /// find product controller.
  final ProductController _productC = Get.find();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((Duration time) => init());
    super.initState();
  }

  init() async {
    _productC.minPrice(0);
    _productC.maxPrice(0);
    _productC.isFinishLoadMore(false);
    _productC.isLoadMoreLoading(false);
    _productC.pageNumber(1);
    _productC.categoryId(widget.categoryId ?? "");
    _productC.searchText(widget.searchText ?? "");
    _productC.productSortingValue("");
    await _productC.getProductListPagination(
      isPageRefresh: true,
    );
    _productC.productListingSorting.clear();
    _productC.productListingSorting.addAll([
      ProductSortingModel(
          name: "Price - High to Low",
          keyValue: "price_desc",
          isSelected: false.obs),
      ProductSortingModel(
          name: "Price - Lowest to Highest",
          keyValue: "price_asc",
          isSelected: false.obs),
      ProductSortingModel(
          name: "Rating", keyValue: "rating", isSelected: false.obs),
      ProductSortingModel(
          name: "Date", keyValue: "date", isSelected: false.obs),
      // ProductSortingModel(
      //     name: "Discount", keyValue: "Discount", isSelected: false.obs)
    ]);
    _productC.priceRangeList.clear();
    _productC.priceRangeList.addAll([
      PriceRangeModel(minPrice: 0, maxPrice: 1000, isSelected: false.obs),
      PriceRangeModel(minPrice: 1000, maxPrice: 10000, isSelected: false.obs),
      PriceRangeModel(minPrice: 10000, maxPrice: 50000, isSelected: false.obs),
      PriceRangeModel(minPrice: 50000, maxPrice: 100000, isSelected: false.obs),
      PriceRangeModel(
          minPrice: 100000, maxPrice: 1000000, isSelected: false.obs),
    ]);
    await _productC.getBrandList();
    await _productC.getFilterCategory();
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
            "Products",
            style: TextStyle(
                color: CommonColors.blackColor,
                fontSize: 16,
                fontWeight: FontWeight.w500),
            overflow: TextOverflow.ellipsis,
          ),
          actions: [const FavoriteButton(), CartButton()],
        ),
        bottomNavigationBar: Obx(() {
          return _productC.isProductListingLoading.value
              ? Container(
                  height: 10,
                )
              : const FooterWidget();
        }),
        body: Obx(() {
          return _productC.isProductListingLoading.value
              ? Center(
                  child: CircularProgressIndicator(
                    color: CommonColors.appColor,
                  ),
                )
              : ScrollConfiguration(
                  behavior: const ScrollBehavior().copyWith(overscroll: false),
                  child: _productC.productListingList.isNotEmpty
                      ? NotificationListener<ScrollNotification>(
                          onNotification: (scrollNotification) {
                            if (scrollNotification.metrics.pixels ==
                                scrollNotification.metrics.maxScrollExtent) {
                              if (!_productC.isFinishLoadMore.value) {
                                if (_productC.isLoadMoreLoading.isFalse) {
                                  _productC.getProductListPagination(
                                      isLoadMore: true,
                                      shouldShowLoader: false);
                                }
                              }
                            }
                            return true;
                          },
                          child: Column(
                            children: [
                              Expanded(
                                child: RefreshIndicator(
                                  onRefresh: () => Future.sync(
                                    () async {
                                      _productC.minPrice(0);
                                      _productC.maxPrice(0);
                                      _productC.categoryId("");
                                      _productC.searchText("");
                                      _productC.brandId("");
                                      _productC.productSortingValue("");
                                      _productC.isFinishLoadMore(false);
                                      _productC.isLoadMoreLoading(false);
                                      _productC.pageNumber(1);
                                      _productC.getProductListPagination(
                                          shouldShowLoader: false,
                                          isPageRefresh: true);
                                    },
                                  ),
                                  child: GridView.count(
                                    controller: _productC
                                        .productListingScrollController,
                                    addAutomaticKeepAlives: true,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    crossAxisCount: 2,
                                    childAspectRatio: (1 / 1.5),
                                    // shrinkWrap: true,
                                    children: List.generate(
                                        _productC.productListingList.length,
                                        (index) {
                                      return GestureDetector(
                                          onTap: () {
                                            Get.to(() => ProductDetailsScreen(
                                                  productId: _productC
                                                      .productListingList[index]
                                                      .productId,
                                                  brandName: _productC
                                                      .productListingList[index]
                                                      .brand!
                                                      .brandName!,
                                                ));
                                          },
                                          child: ProductListingCard(
                                            productListData: _productC
                                                .productListingList[index],
                                          ));
                                    }),
                                  ),
                                ),
                              ),
                              _productC.isLoadMoreLoading.value
                                  ? Center(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8),
                                        child: CircularProgressIndicator(
                                          color: CommonColors.appColor,
                                        ),
                                      ),
                                    )
                                  : Container()
                            ],
                          ))
                      : const NoDataScreen(),
                );
        }));
  }
}
