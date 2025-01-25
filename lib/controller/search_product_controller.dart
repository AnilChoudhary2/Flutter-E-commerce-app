import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/recent_search_model.dart';
import '../repository/repository.dart';

class SearchProductController extends GetxController {
  Repository repository = Repository();
  RxList<RecentSearchModel?> recentSearchList = <RecentSearchModel>[].obs;
  TextEditingController searchTextField = TextEditingController(text: "");
  RxBool isTrendingLoading = true.obs;
  RxList<String?> trendingSearch = <String>[
    "Laptop",
    "Mobile",
    "IPhone",
    "Vivo",
    "Oppo",
    "T-Shirt",
    "Men's Shirt",
    "Toy's",
    "Watches",
    "Handbag"
  ].obs;
  //onInit() function call first time when controller is create.
  @override
  void onInit() {
    repository.initRepo();
    super.onInit();
  }

  void saveRecentData({RecentSearchModel? modelRecent}) async {
    if (recentSearchList.length > 8) {
      recentSearchList.removeAt(0);
    }
    bool isContain = false;
    int pos = 0;
    if (recentSearchList.isNotEmpty) {
      for (int i = 0; i < recentSearchList.length; i++) {
        if (recentSearchList[i]!.id != modelRecent!.id) {
          isContain = false;
        } else {
          isContain = true;
          pos = i;
          break;
        }
      }
      if (isContain) {
        recentSearchList[pos] = modelRecent;
      } else {
        recentSearchList.add(modelRecent);
      }
    } else {
      recentSearchList.add(modelRecent);
    }
    log("recentSearchList = $recentSearchList");
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String jsonData = jsonEncode(recentSearchList);
    log(jsonData);
    sharedPreferences.setString("RECENT_SEARCH_DATA", jsonData);
    getRecentData();
  }

  void getRecentData() async {
    List<RecentSearchModel> recentSearchDuplicateList = <RecentSearchModel>[];
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? recentSearchString =
        sharedPreferences.getString("RECENT_SEARCH_DATA");
    if (recentSearchString == null || recentSearchString.isEmpty) {
      recentSearchList = <RecentSearchModel>[].obs;
    } else {
      try {
        var recentSearchJson = jsonDecode(recentSearchString);
        recentSearchJson.forEach((tagJson) {
          recentSearchDuplicateList.add(RecentSearchModel.fromJson(tagJson));
        });
        log("searchData:- $recentSearchDuplicateList");
      } catch (e, stackTrace) {
        log("getRecentData error => ${stackTrace.toString()}");
      }
      recentSearchList.clear();
      recentSearchList.assignAll(recentSearchDuplicateList);
    }
    isTrendingLoading(false);
    recentSearchList.refresh();
    update();
  }

  void clearRecentSearchList() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("RECENT_SEARCH_DATA", "");
    recentSearchList.clear();
  }
}
