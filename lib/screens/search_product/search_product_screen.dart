import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yahmart/screens/search_product/widgets/recent_and_trending_search_widget.dart';
import 'package:yahmart/screens/search_product/widgets/search_bar_widget.dart';
import 'package:yahmart/utils/common_colors.dart';
import '../../controller/search_product_controller.dart';
import '../../model/recent_search_model.dart';
import '../product_listing/product_listing_screen.dart';

class SearchProductScreen extends StatefulWidget {
  const SearchProductScreen({Key? key}) : super(key: key);

  @override
  State<SearchProductScreen> createState() => _SearchProductScreenState();
}

class _SearchProductScreenState extends State<SearchProductScreen> {
  /// put search controller.
  final SearchProductController _searchC = Get.put(SearchProductController());

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((Duration time) => init());
    super.initState();
  }

  init() {
    _searchC.getRecentData();
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
          leadingWidth: 35,
          leading: Padding(
            padding: const EdgeInsets.only(left: 5),
            child: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: CommonColors.appColor,
                ),
                onPressed: () => Get.back()),
          ),
          title: SearchBarWidget(
            onTextChange: (value) {},
            onSubmitted: (value) {
              _searchC.saveRecentData(
                modelRecent: RecentSearchModel(value, value),
              );
              Get.to(() => ProductListingScreen(searchText: value));
            },
            controller: _searchC.searchTextField,
          ),
          actions: [
            GestureDetector(
              onTap: () {
                if (_searchC.searchTextField.text.isNotEmpty) {
                  _searchC.searchTextField.clear();
                } else {
                  Get.back();
                }
              },
              child: Icon(
                Icons.clear_outlined,
                color: CommonColors.appColor,
              ),
            ),
            const SizedBox(width: 5)
          ],
        ),
        body: Obx(() {
          return _searchC.isTrendingLoading.value
              ? Center(
                  child: CircularProgressIndicator(
                    color: CommonColors.appColor,
                  ),
                )
              : ListView(
                  shrinkWrap: true,
                  children: [RecentAndTrendingSearchWidget()],
                );
        }));
  }
}
