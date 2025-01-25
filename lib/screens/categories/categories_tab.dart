import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yahmart/screens/categories/sub_categories_screen.dart';
import 'package:yahmart/screens/categories/widgets/category_widget.dart';
import 'package:yahmart/screens/product_listing/product_listing_screen.dart';
import '../../controller/home_controller.dart';
import '../../utils/common_colors.dart';
import '../../widgets/no_data_screen_widget.dart';

class CategoriesTab extends StatefulWidget {
  const CategoriesTab({Key? key}) : super(key: key);

  @override
  State<CategoriesTab> createState() => _CategoriesTabState();
}

class _CategoriesTabState extends State<CategoriesTab> {
  /// find home controller.
  final HomeController _homeC = Get.find();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((Duration time) => init());
    super.initState();
  }

  init() {
    _homeC.getAllCategoryList(shouldShowLoader: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: CommonColors.appBgColor,
        body: Obx(() {
          return _homeC.isAllCatLoading.value
              ? Center(
                  child: CircularProgressIndicator(
                    color: CommonColors.appColor,
                  ),
                )
              : ScrollConfiguration(
                  behavior: const ScrollBehavior().copyWith(overscroll: false),
                  child: RefreshIndicator(
                    onRefresh: () async {
                      _homeC.getAllCategoryList(shouldShowLoader: false);
                      return;
                    },
                    child: _homeC.allCategoryList.isNotEmpty
                        ? GridView.count(
                            padding: const EdgeInsets.only(
                              top: 10,
                            ),
                            crossAxisCount: 3,
                            childAspectRatio: (1 / 1),
                            shrinkWrap: true,
                            children: List.generate(
                                _homeC.allCategoryList.length, (index) {
                              return GestureDetector(
                                onTap: () {
                                  if (_homeC.allCategoryList[index]
                                      .subCategories.isNotEmpty) {
                                    Get.to(() => SubCategoriesScreen(
                                          subCategories: _homeC
                                              .allCategoryList[index]
                                              .subCategories,
                                          catName: _homeC.allCategoryList[index]
                                              .categoryName,
                                        ));
                                  } else {
                                    Get.to(() => ProductListingScreen(
                                          categoryId: _homeC
                                              .allCategoryList[index]
                                              .categoryId,
                                        ));
                                  }
                                },
                                child: CategoryWidget(
                                  categoryId:
                                      _homeC.allCategoryList[index].categoryId,
                                  catImage: _homeC.allCategoryList[index]
                                      .categoryBannerImage,
                                  catName: _homeC
                                      .allCategoryList[index].categoryName,
                                ),
                              );
                            }),
                          )
                        : const NoDataScreen(),
                  ),
                );
        }));
  }
}
