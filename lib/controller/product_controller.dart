import 'dart:async';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yahmart/controller/product_details_controller.dart';
import 'package:yahmart/model/brand_list_model.dart';
import 'package:yahmart/model/category_list_model.dart';
import 'package:yahmart/model/product_wishlist_model.dart';
import '../model/price_range_model.dart';
import '../model/product_list_model.dart';
import '../model/product_sorting_model.dart';
import '../repository/repository.dart';
import '../utils/common_logics.dart';
import '../utils/custom_alert_dialog.dart';
import '../widgets/loader_dialog.dart';
import '../widgets/login_bottom_sheet.dart';

class ProductController extends GetxController {
  Repository repository = Repository();
  RxBool isProductLoading = true.obs;
  RxBool isBrandListLoading = true.obs;
  RxBool isFilterCatLoading = true.obs;
  RxBool isWishlistLoading = true.obs;
  RxBool isProductListingLoading = true.obs;
  RxBool isLoadMoreLoading = false.obs;
  RxBool isFinishLoadMore = false.obs;
  RxInt pageNumber = 1.obs;
  RxInt minPrice = 0.obs;
  RxInt maxPrice = 0.obs;
  RxString searchText = "".obs;
  RxString categoryId = "".obs;
  RxString brandId = "".obs;
  RxString productSortingValue = "".obs;
  RxString? selectedFilterName = "Price Range".obs;
  RxList<ProductListModel> productListingList = <ProductListModel>[].obs;
  RxList<BrandListModel> allBrandList = <BrandListModel>[].obs;
  RxList<CategoryListModel> filterCategoryList = <CategoryListModel>[].obs;
  RxList<ProductListModel> productListData = <ProductListModel>[].obs;
  RxList<ProductListModel> productListData2 = <ProductListModel>[].obs;
  RxList<ProductWishlistModel> productWishlist = <ProductWishlistModel>[].obs;
  RxList<PriceRangeModel> priceRangeList = <PriceRangeModel>[].obs;
  RxList<String> filterTypeList =
      <String>["Price Range", "Brand", "Category"].obs;
  RxList<ProductSortingModel> productListingSorting =
      <ProductSortingModel>[].obs;

  /// used to scroll the page to starting when search, refresh screen api calls
  ScrollController productListingScrollController = ScrollController();

  /// put product details controller.
  final ProductDetailsController _productDetailsC =
      Get.put(ProductDetailsController());

  //onInit() function call first time when controller is create.
  @override
  void onInit() async {
    await repository.initRepo();
    super.onInit();
  }

  Future getProductListPagination({
    bool shouldShowLoader = true,
    bool isPageRefresh = false,
    bool shouldShowLoadingPopup = false,
    bool isLoadMore = false,
  }) async {
    try {
      String qParams = "pageSize=20&current=${pageNumber.value}";
      if (maxPrice.value > 0) {
        qParams += "&minPrice=${minPrice.value}&maxPrice=${maxPrice.value}";
      }
      if (categoryId.isNotEmpty) {
        qParams += "&categoryId=${categoryId.value}";
      }
      if (brandId.isNotEmpty) {
        qParams += "&brandId=${brandId.value}";
      }
      if (searchText.isNotEmpty) {
        qParams += "&searchText=${searchText.value}";
      }
      if (productSortingValue.isNotEmpty) {
        if (productSortingValue.value == "price_desc" ||
            productSortingValue.value == "price_asc") {
          qParams += "&sortKey=price";
          qParams +=
              "&sortDirection=${productSortingValue.value == "price_desc" ? "DESC" : "ASC"}";
        } else {
          qParams += "&sortKey=${productSortingValue.value}";
        }
      }
      if (shouldShowLoader) isProductListingLoading(true);
      if (shouldShowLoadingPopup) showLoaderDialog();
      if (isLoadMore) isLoadMoreLoading(true);
      List<dynamic>? response =
          await repository.getApiCall(url: "product/list?$qParams");
      if (isPageRefresh) productListingList.clear();
      if (response != null && response.isNotEmpty) {
        for (var element in response) {
          productListingList.add(ProductListModel.fromJson(element));
        }
        if (shouldShowLoadingPopup &&
            productListingScrollController.hasClients) {
          productListingScrollController.jumpTo(1);
        }
        update(["product_listing_page"]);
        pageNumber.value += 1;
      } else {
        /// Changing isFinishLoadMore flag true when no more data available in pagination api.
        isFinishLoadMore(true);
        log("else loadMore(${pageNumber.toString()})");
        log("response != null => True");
      }
      log("productListData length => ${productListingList.length.toString()}");
      if (shouldShowLoader) isProductListingLoading(false);
      if (isLoadMore) isLoadMoreLoading(false);
      if (shouldShowLoadingPopup) hideLoaderDialog();
    } catch (e, stackTrace) {
      if (shouldShowLoader) isProductListingLoading(false);
      if (isLoadMore) isLoadMoreLoading(false);
      if (shouldShowLoadingPopup) hideLoaderDialog();
      if (kDebugMode) {
        showAlertDialog(msg: e.toString());
      }
      log("getProductListPagination error => ${stackTrace.toString()}");
    }
  }

  getProductList({bool shouldShowLoader = true}) async {
    try {
      if (shouldShowLoader) isProductLoading(true);
      var response = await repository.getApiCall(url: "product/list");
      productListData.clear();
      productListData2.clear();
      if (response != null) {
        response.forEach((element) async {
          productListData.add(ProductListModel.fromJson(element));
        });
        productListData2.assignAll(productListData.reversed);
      } else {
        log("response != null => True");
      }
      log("productListData length => ${productListData.length.toString()}");
      if (shouldShowLoader) isProductLoading(false);
    } catch (e, stackTrace) {
      if (shouldShowLoader) isProductLoading(false);
      if (kDebugMode) {
        showAlertDialog(msg: e.toString());
      }
      log("getProductList error => ${stackTrace.toString()}");
    }
  }

  getProductWishList({bool shouldShowLoader = true}) async {
    try {
      var body = {"add": [], "remove": []};
      if (shouldShowLoader) isWishlistLoading(true);
      var response =
          await repository.postApiCall(url: "product/wishlist", body: body);
      productWishlist.clear();
      if (response != null) {
        response.forEach((element) async {
          productWishlist.add(ProductWishlistModel.fromJson(element));
        });
      } else {
        log("response != null => True");
      }
      if (shouldShowLoader) isWishlistLoading(false);
    } catch (e, stackTrace) {
      if (shouldShowLoader) isWishlistLoading(false);
      if (kDebugMode) {
        showAlertDialog(msg: e.toString());
      }
      log("getProductWishList error => ${stackTrace.toString()}");
    }
  }

  addRemoveProductFromWishList({required skuId, required isFavFlag}) async {
    bool isLogin = CommonLogics.checkUserLogin();
    if (isLogin) {
      try {
        showLoaderDialog();
        Map<String, List> body;
        if (isFavFlag) {
          body = {
            "add": [],
            "remove": [skuId]
          };
        } else {
          body = {
            "add": [skuId],
            "remove": []
          };
        }

        var response =
            await repository.postApiCall(url: "product/wishlist", body: body);
        hideLoaderDialog();
        productWishlist.clear();
        if (response != null) {
          response.forEach((element) async {
            productWishlist.add(ProductWishlistModel.fromJson(element));
          });

          int indexPosition0 = productListingList.indexWhere(
              (element) => element.variants![0].productSkuId == skuId);
          if (indexPosition0 >= 0) {
            productListingList[indexPosition0].isWishlisted?.value =
                isFavFlag ? false : true;
          }
          int indexPosition = productListData.indexWhere(
              (element) => element.variants![0].productSkuId == skuId);
          if (indexPosition >= 0) {
            productListData[indexPosition].isWishlisted?.value =
                isFavFlag ? false : true;
          }
          int indexPosition2 = productListData2.indexWhere(
              (element) => element.variants![0].productSkuId == skuId);
          if (indexPosition2 >= 0) {
            productListData2[indexPosition2].isWishlisted?.value =
                isFavFlag ? false : true;
          }
          if (_productDetailsC.productDetailsData?.variants?[0].productSkuId ==
              skuId) {
            _productDetailsC.productDetailsData!.isWishlisted!.value =
                isFavFlag ? false : true;
          }
          productListData.refresh();
          productListData2.refresh();
          update(["product_listing_page"]);
          if (isFavFlag) {
            showToastMessage(msg: "Removed successfully!");
          } else {
            showToastMessage(msg: "Added successfully!");
          }
        } else {
          log("response != null => True");
        }
      } catch (e, stackTrace) {
        hideLoaderDialog();
        if (kDebugMode) {
          showAlertDialog(msg: e.toString());
        }
        log("addRemoveProductFromWishList error => ${stackTrace.toString()}");
      }
    } else {
      Get.bottomSheet(const LoginBottomSheet());
    }
  }

  getBrandList({bool shouldShowLoader = true}) async {
    try {
      if (shouldShowLoader) isBrandListLoading(true);
      var response = await repository.getApiCall(url: "brand/list");
      allBrandList.clear();
      if (response != null) {
        response.forEach((element) async {
          allBrandList.add(BrandListModel.fromJson(element));
        });
      } else {
        log("response != null => True");
      }
      log("allBrandList length => ${allBrandList.length.toString()}");
      if (shouldShowLoader) isBrandListLoading(false);
    } catch (e, stackTrace) {
      if (shouldShowLoader) isBrandListLoading(false);
      if (kDebugMode) {
        showAlertDialog(msg: e.toString());
      }
      log("getBrandList error => ${stackTrace.toString()}");
    }
  }

  getFilterCategory({bool shouldShowLoader = true}) async {
    try {
      if (shouldShowLoader) isFilterCatLoading(true);
      var response = await repository.getApiCall(url: "category/list");
      filterCategoryList.clear();
      if (response != null) {
        response.forEach((element) async {
          filterCategoryList.add(CategoryListModel.fromJson(element));
        });
      } else {
        log("response != null => True");
      }
      log("filterCategoryList length => ${filterCategoryList.length.toString()}");
      if (shouldShowLoader) isFilterCatLoading(false);
    } catch (e, stackTrace) {
      if (shouldShowLoader) isFilterCatLoading(false);
      if (kDebugMode) {
        showAlertDialog(msg: e.toString());
      }
      log("getFilterCategory error => ${stackTrace.toString()}");
    }
  }

  clearAllFilter() {
    for (var element in allBrandList) {
      element.isSelected!(false);
    }
    for (var element in filterCategoryList) {
      element.isSelected!(false);
    }
    for (var element in productListingSorting) {
      element.isSelected!(false);
    }
    for (var element in priceRangeList) {
      element.isSelected!(false);
    }
    allBrandList.refresh();
    filterCategoryList.refresh();
    productListingSorting.refresh();
    priceRangeList.refresh();
    minPrice = 0.obs;
    maxPrice = 0.obs;
    searchText = "".obs;
    categoryId = "".obs;
    brandId = "".obs;
    productSortingValue = "".obs;
    selectedFilterName = "Price Range".obs;
  }
}
