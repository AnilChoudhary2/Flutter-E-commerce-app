import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../controller/product_controller.dart';
import '../../utils/common_colors.dart';
import '../../utils/common_images.dart';
import '../../utils/screen_constants.dart';

class ProductFilterScreen extends StatefulWidget {
  const ProductFilterScreen({Key? key}) : super(key: key);

  @override
  State<ProductFilterScreen> createState() => _ProductFilterScreenState();
}

class _ProductFilterScreenState extends State<ProductFilterScreen> {
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
            "Filter",
            style: TextStyle(
                color: CommonColors.blackColor,
                fontSize: 16,
                fontWeight: FontWeight.w500),
            overflow: TextOverflow.ellipsis,
          ),
          actions: [
            GestureDetector(
              onTap: () {
                _productC.clearAllFilter();
              },
              child: Center(
                child: Text(
                  "Clear",
                  style: TextStyle(
                      color: CommonColors.yellowColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
            const SizedBox(width: 16),
          ],
        ),
        body: Obx(() {
          return Column(
            children: [
              Divider(
                height: 1,
                color: CommonColors.borderColor,
                thickness: 1,
              ),
              Expanded(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      flex: 4,
                      child: ListView.separated(
                        shrinkWrap: true,
                        itemCount: _productC.filterTypeList.length,
                        separatorBuilder: (context, index) {
                          return Divider(
                            height: 1,
                            color: CommonColors.borderColor,
                            thickness: 1,
                          );
                        },
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              _productC.selectedFilterName!(
                                  _productC.filterTypeList[index]);
                            },
                            child: Container(
                              color: Color(
                                  _productC.selectedFilterName!.value ==
                                          _productC.filterTypeList[index]
                                      ? CommonColors.whiteColor.value
                                      : CommonColors.appBgColor.value),
                              padding: EdgeInsets.all(ScreenConstant.size16),
                              child: Text(
                                _productC.filterTypeList[index],
                                style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87),
                              ),
                            ),
                          );
                        },
                      )),
                  Container(
                    height: double.infinity,
                    width: 1.0,
                    color: CommonColors.borderColor,
                  ),
                  if (_productC.selectedFilterName!.value == "Price Range")
                    Expanded(
                        flex: 8,
                        child: ListView.separated(
                          shrinkWrap: true,
                          itemCount: _productC.priceRangeList.length,
                          separatorBuilder: (context, index) {
                            return Divider(
                              height: 1,
                              color: CommonColors.borderColor,
                              thickness: 1,
                            );
                          },
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                if (_productC
                                    .priceRangeList[index].isSelected!.value) {
                                  _productC
                                      .priceRangeList[index].isSelected!(false);
                                  _productC.priceRangeList.refresh();
                                  _productC.minPrice(0);
                                  _productC.maxPrice(0);
                                } else {
                                  for (var element
                                      in _productC.priceRangeList) {
                                    element.isSelected!(false);
                                  }
                                  _productC
                                      .priceRangeList[index].isSelected!(true);
                                  _productC.minPrice(
                                      _productC.priceRangeList[index].minPrice);
                                  _productC.maxPrice(
                                      _productC.priceRangeList[index].maxPrice);
                                  _productC.priceRangeList.refresh();
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        "${_productC.priceRangeList[index].minPrice} - ${_productC.priceRangeList[index].maxPrice}",
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black87),
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    SvgPicture.asset(
                                      _productC.priceRangeList[index]
                                              .isSelected!.value
                                          ? CommonImages.radioBtnSelected
                                          : CommonImages.radioBtn,
                                      color: Colors.black,
                                      height: ScreenConstant.size22,
                                      width: ScreenConstant.size22,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ))
                  else if (_productC.selectedFilterName!.value == "Brand")
                    Expanded(
                        flex: 8,
                        child: ListView.separated(
                          shrinkWrap: true,
                          itemCount: _productC.allBrandList.length,
                          separatorBuilder: (context, index) {
                            return Divider(
                              height: 1,
                              color: CommonColors.borderColor,
                              thickness: 1,
                            );
                          },
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                if (_productC
                                    .allBrandList[index].isSelected!.value) {
                                  _productC
                                      .allBrandList[index].isSelected!(false);
                                  _productC.brandId("");
                                  _productC.allBrandList.refresh();
                                } else {
                                  for (var element in _productC.allBrandList) {
                                    element.isSelected!(false);
                                  }
                                  _productC
                                      .allBrandList[index].isSelected!(true);
                                  _productC.brandId(
                                      _productC.allBrandList[index].brandId);
                                  _productC.allBrandList.refresh();
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        "${_productC.allBrandList[index].brandName}",
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black87),
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    SvgPicture.asset(
                                      _productC.allBrandList[index].isSelected!
                                              .value
                                          ? CommonImages.radioBtnSelected
                                          : CommonImages.radioBtn,
                                      color: Colors.black,
                                      height: ScreenConstant.size22,
                                      width: ScreenConstant.size22,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ))
                  else if (_productC.selectedFilterName!.value == "Category")
                    Expanded(
                        flex: 8,
                        child: ListView.separated(
                          shrinkWrap: true,
                          itemCount: _productC.filterCategoryList.length,
                          separatorBuilder: (context, index) {
                            return Divider(
                              height: 1,
                              color: CommonColors.borderColor,
                              thickness: 1,
                            );
                          },
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                if (_productC.filterCategoryList[index]
                                    .isSelected!.value) {
                                  _productC.filterCategoryList[index]
                                      .isSelected!(false);
                                  _productC.categoryId("");
                                  _productC.filterCategoryList.refresh();
                                } else {
                                  for (var element
                                      in _productC.filterCategoryList) {
                                    element.isSelected!(false);
                                  }
                                  _productC.filterCategoryList[index]
                                      .isSelected!(true);
                                  _productC.categoryId(_productC
                                      .filterCategoryList[index].categoryId);
                                  _productC.filterCategoryList.refresh();
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        "${_productC.filterCategoryList[index].categoryName}",
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black87),
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    SvgPicture.asset(
                                      _productC.filterCategoryList[index]
                                              .isSelected!.value
                                          ? CommonImages.radioBtnSelected
                                          : CommonImages.radioBtn,
                                      color: Colors.black,
                                      height: ScreenConstant.size22,
                                      width: ScreenConstant.size22,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ))
                ],
              )),
              Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                        top: BorderSide(
                            width: 1, color: CommonColors.borderColor),
                      )),
                  height: 55,
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: const Text(
                            "Close",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87),
                          ),
                        ),
                      ),
                      Container(
                        height: 30,
                        width: 1.0,
                        color: CommonColors.borderColor,
                      ),
                      Expanded(
                        child: GestureDetector(
                            onTap: () {
                              Get.back();
                              _productC.isFinishLoadMore(false);
                              _productC.isLoadMoreLoading(false);
                              _productC.pageNumber(1);
                              _productC.productSortingValue("");
                              _productC.getProductListPagination(
                                  shouldShowLoader: false,
                                  isPageRefresh: true,
                                  shouldShowLoadingPopup: true);
                            },
                            child: const Text(
                              "Apply",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87),
                            )),
                      ),
                    ],
                  ))
            ],
          );
        }));
  }
}
