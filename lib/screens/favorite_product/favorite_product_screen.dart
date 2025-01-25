import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yahmart/controller/product_controller.dart';
import 'package:yahmart/screens/favorite_product/widgets/fav_product_tile_widget.dart';
import 'package:yahmart/widgets/no_data_screen_widget.dart';
import '../../utils/common_colors.dart';
import '../../utils/screen_constants.dart';
import '../product_details/product_details_screen.dart';

class FavoriteProductScreen extends StatefulWidget {
  const FavoriteProductScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteProductScreen> createState() => _FavoriteProductScreenState();
}

class _FavoriteProductScreenState extends State<FavoriteProductScreen> {
  /// find product controller.
  final ProductController _productC = Get.find();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((Duration time) => init());
    super.initState();
  }

  init() {
    _productC.getProductWishList();
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
            "My Wishlist",
            style: TextStyle(
                color: CommonColors.appColor,
                fontWeight: FontWeight.bold,
                fontSize: FontSize.s16),
          ),
        ),
        body: Obx(() {
          return _productC.isWishlistLoading.value
              ? Center(
                  child: CircularProgressIndicator(
                    color: CommonColors.appColor,
                  ),
                )
              : ScrollConfiguration(
                  behavior: const ScrollBehavior().copyWith(overscroll: false),
                  child: RefreshIndicator(
                    onRefresh: () async {
                      _productC.getProductWishList(shouldShowLoader: false);
                      return;
                    },
                    child: _productC.productWishlist.isNotEmpty
                        ? ListView.builder(
                            shrinkWrap: true,
                            itemCount: _productC.productWishlist.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                  onTap: () {
                                    Get.to(() => ProductDetailsScreen(
                                          productId: _productC
                                              .productWishlist[index]
                                              .product
                                              ?.productId,
                                          brandName: _productC
                                              .productWishlist[index]
                                              .product!
                                              .productName!,
                                        ));
                                  },
                                  child: FavProductTileWidget(
                                    productWishlist:
                                        _productC.productWishlist[index],
                                  ));
                            })
                        : const NoDataScreen(),
                  ),
                );
        }));
  }
}
