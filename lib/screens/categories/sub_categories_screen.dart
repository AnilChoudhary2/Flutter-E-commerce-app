import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yahmart/model/category_list_model.dart';
import 'package:yahmart/screens/categories/widgets/category_widget.dart';
import '../../utils/common_colors.dart';
import '../../utils/screen_constants.dart';
import '../product_listing/product_listing_screen.dart';

class SubCategoriesScreen extends StatelessWidget {
  final List<SubCategory> subCategories;
  final String catName;
  const SubCategoriesScreen(
      {Key? key, required this.subCategories, required this.catName})
      : super(key: key);

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
            catName,
            style: TextStyle(
                color: CommonColors.appColor,
                fontWeight: FontWeight.bold,
                fontSize: FontSize.s16),
          ),
        ),
        body: ScrollConfiguration(
          behavior: const ScrollBehavior().copyWith(overscroll: false),
          child: GridView.count(
            padding: const EdgeInsets.only(
              top: 10,
            ),
            crossAxisCount: 3,
            childAspectRatio: (1 / 1),
            shrinkWrap: true,
            children: List.generate(subCategories.length, (index) {
              return GestureDetector(
                onTap: () {
                  Get.to(() => ProductListingScreen(
                        categoryId: subCategories[index].categoryId,
                      ));
                },
                child: CategoryWidget(
                  categoryId: subCategories[index].categoryId,
                  catImage: subCategories[index].categoryBannerImage,
                  catName: subCategories[index].categoryName,
                ),
              );
            }),
          ),
        ));
  }
}
