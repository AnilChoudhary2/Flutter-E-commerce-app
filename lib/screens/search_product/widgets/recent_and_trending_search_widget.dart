import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yahmart/model/recent_search_model.dart';
import '../../../controller/search_product_controller.dart';
import '../../../utils/common_colors.dart';
import '../../../utils/custom_alert_dialog.dart';
import '../../../utils/screen_constants.dart';
import '../../product_listing/product_listing_screen.dart';

class RecentAndTrendingSearchWidget extends StatelessWidget {
  RecentAndTrendingSearchWidget({Key? key}) : super(key: key);

  /// find product controller.
  final SearchProductController _searchC = Get.find();
  @override
  Widget build(BuildContext context) {
    return Obx(() => SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Divider(
                height: 1,
                color: CommonColors.borderColor,
                thickness: 1,
              ),
              Container(
                  width: double.infinity,
                  color: Colors.grey.withOpacity(.3),
                  padding: EdgeInsets.only(
                      left: ScreenConstant.size15,
                      top: ScreenConstant.size13,
                      bottom: ScreenConstant.size13,
                      right: ScreenConstant.size15),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Trending Search Products",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          )),
                      GestureDetector(
                        child: Icon(
                          Icons.refresh,
                          color: CommonColors.appColor,
                        ),
                        onTap: () {},
                      )
                    ],
                  )),
              Divider(
                height: 1,
                color: CommonColors.borderColor,
                thickness: 1,
              ),
              const SizedBox(height: 10),
              Container(
                margin: EdgeInsets.only(
                    left: ScreenConstant.size16, right: ScreenConstant.size16),
                child: Wrap(
                  children: List.generate(
                      _searchC.trendingSearch.length,
                      (index) => GestureDetector(
                            onTap: () {
                              _searchC.saveRecentData(
                                modelRecent: RecentSearchModel(
                                    _searchC.trendingSearch[index],
                                    _searchC.trendingSearch[index]),
                              );
                              Get.to(() => ProductListingScreen(
                                    searchText: _searchC.trendingSearch[index],
                                  ));
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 10),
                              margin: const EdgeInsets.only(top: 12, right: 8),
                              height: 30,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                    color: CommonColors.borderColor, width: 1),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(13)),
                                boxShadow: const [
                                  BoxShadow(
                                      color: Colors.transparent,
                                      spreadRadius: 0,
                                      blurRadius: 0,
                                      offset: Offset(0, 0))
                                ],
                              ),
                              child: Text(
                                _searchC.trendingSearch[index]!,
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                softWrap: false,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 13,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                          )),
                ),
              ),
              const SizedBox(height: 15),
              _searchC.recentSearchList.isNotEmpty
                  ? SizedBox(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 12),
                          Divider(
                            height: 1,
                            color: CommonColors.borderColor,
                            thickness: 1,
                          ),
                          Container(
                              width: double.infinity,
                              color: Colors.grey.withOpacity(.3),
                              padding: EdgeInsets.only(
                                  left: ScreenConstant.size15,
                                  top: ScreenConstant.size13,
                                  bottom: ScreenConstant.size13,
                                  right: ScreenConstant.size15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text("Recent Search",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      )),
                                  GestureDetector(
                                    onTap: () {
                                      _searchC.recentSearchList.isNotEmpty
                                          ? showAlertDialogOnPressed(
                                              msg:
                                                  'Are you sure you want to clear recent list?',
                                              onPressed: () {
                                                _searchC
                                                    .clearRecentSearchList();
                                                Get.back();
                                              })
                                          : Container();
                                    },
                                    child: const Text(
                                      "Clear",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  )
                                ],
                              )),
                          Divider(
                            height: 1,
                            color: CommonColors.borderColor,
                            thickness: 1,
                          ),
                          ListView.separated(
                            reverse: true,
                            separatorBuilder: (context, index) => Divider(
                              color: CommonColors.borderColor,
                            ),
                            shrinkWrap: true,
                            physics: const ScrollPhysics(),
                            padding: EdgeInsets.only(
                                top: ScreenConstant.size7,
                                bottom: ScreenConstant.size7),
                            itemCount: _searchC.recentSearchList.length,
                            itemBuilder: (ctx, index) {
                              return Container(
                                  padding: EdgeInsets.only(
                                      left: ScreenConstant.size16,
                                      top: ScreenConstant.size7,
                                      right: ScreenConstant.size16,
                                      bottom: ScreenConstant.size7),
                                  child: GestureDetector(
                                    behavior: HitTestBehavior.opaque,
                                    onTap: () {
                                      Get.to(() => ProductListingScreen(
                                          searchText: _searchC
                                              .recentSearchList[index]!.title));
                                    },
                                    child: Text(
                                      _searchC.recentSearchList[index]!.title!,
                                      textAlign: TextAlign.start,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      softWrap: false,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ));
                            },
                          ),
                        ],
                      ),
                    )
                  : Container(),
            ],
          ),
        ));
  }
}
