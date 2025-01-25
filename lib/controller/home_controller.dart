import 'dart:convert';
import 'dart:developer';
import 'package:convert/convert.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pointycastle/export.dart';
import 'package:yahmart/model/home_banners_model.dart';
import 'package:yahmart/screens/orders/my_orders_screen.dart';
import 'package:yahmart/screens/user_account/account_tab.dart';
import 'package:yahmart/screens/categories/categories_tab.dart';
import 'package:yahmart/screens/home/home_tab.dart';
import 'package:yahmart/utils/common_images.dart';
import '../model/category_list_model.dart';
import '../model/uploads_image_model.dart';
import '../model/user_data_model.dart';
import '../repository/encreapt_data.dart';
import '../repository/repository.dart';
import '../screens/notification/notification_screen.dart';
import '../utils/common_logics.dart';
import '../utils/custom_alert_dialog.dart';
import '../widgets/loader_dialog.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

import '../widgets/login_bottom_sheet.dart';

class HomeController extends GetxController {
  Repository repository = Repository();
  RxInt selectedTabIndex = 2.obs;
  TextEditingController searchTextField = TextEditingController(text: "");
  UserDataModel? userDetailData = UserDataModel().obs();
  List<Products>? userProductsList = <Products>[].obs;
  List<Addresses>? userAddressesList = <Addresses>[].obs;
  RxList homeBannersList = <HomeBannersModel>[].obs;
  RxList allCategoryList = <CategoryListModel>[].obs;
  RxList homeCategoryList = <CategoryListModel>[].obs;
  RxBool isAllCatLoading = true.obs;
  RxBool isHomeCatLoading = true.obs;
  RxString? userAvatarUrl = "".obs;
  RxString? userName = "".obs;

  final List sliderImages = [CommonImages.banner1, CommonImages.banner2];

  //onInit() function call first time when controller is create.
  @override
  void onInit() async {
    await repository.initRepo();
    super.onInit();
  }

  getUserProfileData() async {
    try {
      var response = await repository.getApiCall(url: "user/details");
      userDetailData = UserDataModel.fromJson(response);
      userAvatarUrl!(userDetailData?.avatarUrl ?? "");
      userName!(userDetailData?.displayName ?? "User");
      userProductsList = userDetailData!.products;
      userAddressesList = userDetailData!.addresses;
    } catch (e, stackTrace) {
      if (kDebugMode) {
        showAlertDialog(msg: e.toString());
      }
      log("getUserProfileData error => ${stackTrace.toString()}");
    }
  }

  getHomeBannersList() async {
    try {
      var response = await repository.getApiCall(url: "advert/list");
      homeBannersList.clear();
      if (response != null) {
        response.forEach((element) async {
          homeBannersList.add(HomeBannersModel.fromJson(element));
        });
        homeBannersList.removeWhere((element) =>
            element.advertId == 1 ||
            element.advertId == 4 ||
            element.advertId == 13 ||
            element.advertId == 14 ||
            element.advertId == 15 ||
            element.advertId == 19);
        homeBannersList.refresh();
      } else {
        log("response != null => True");
      }
    } catch (e, stackTrace) {
      if (kDebugMode) {
        showAlertDialog(msg: e.toString());
      }
      log("getHomeBannersList error => ${stackTrace.toString()}");
    }
  }

  deleteUserAccount() async {
    try {
      showLoaderDialog();
      await repository.deleteApiCall(url: "user/delete-account");
      hideLoaderDialog();
      CommonLogics.logOut();
    } catch (e, stackTrace) {
      hideLoaderDialog();
      if (kDebugMode) {
        showAlertDialog(msg: e.toString());
      }
      log("deleteUserAccount error => ${stackTrace.toString()}");
    }
  }

  getHomeCategoryList({bool shouldShowLoader = true}) async {
    try {
      if (shouldShowLoader) isHomeCatLoading(true);
      var response = await repository.getApiCall(url: "category/list");
      //await repository.getApiCall(url: "category/list?isVisible=true");
      homeCategoryList.clear();
      if (response != null) {
        response.forEach((element) async {
          homeCategoryList.add(CategoryListModel.fromJson(element));
        });
        homeCategoryList.removeWhere((element) =>
            element.categoryName == "Newrrttyty" ||
            element.categoryName == "Teddy");
        homeCategoryList.refresh();
      } else {
        log("response != null => True");
      }
      log("homeCategoryList length => ${homeCategoryList.length.toString()}");
      if (shouldShowLoader) isHomeCatLoading(false);
    } catch (e, stackTrace) {
      if (shouldShowLoader) isHomeCatLoading(false);
      if (kDebugMode) {
        showAlertDialog(msg: e.toString());
      }
      log("getHomeCategoryList error => ${stackTrace.toString()}");
    }
  }

  getAllCategoryList({bool shouldShowLoader = true}) async {
    try {
      if (shouldShowLoader) isAllCatLoading(true);
      var response = await repository.getApiCall(url: "category/list");
      allCategoryList.clear();
      if (response != null) {
        response.forEach((element) async {
          allCategoryList.add(CategoryListModel.fromJson(element));
        });
        allCategoryList.removeWhere((element) =>
            element.categoryName == "Newrrttyty" ||
            element.categoryName == "Teddy");
        allCategoryList.refresh();
      } else {
        log("response != null => True");
      }
      log("allCategoryList length => ${allCategoryList.length.toString()}");
      if (shouldShowLoader) isAllCatLoading(false);
    } catch (e, stackTrace) {
      if (shouldShowLoader) isAllCatLoading(false);
      if (kDebugMode) {
        showAlertDialog(msg: e.toString());
      }
      log("getAllCategoryList error => ${stackTrace.toString()}");
    }
  }

  uploadUserProfilePicture({required XFile file}) async {
    try {
      showLoaderDialog();
      var response =
          await repository.uploadApiCall(url: "uploads/avatars", file: file);
      UploadsImageModel uploadsImageModel =
          UploadsImageModel.fromJson(response);
      userAvatarUrl!(uploadsImageModel.paths?.first);
      updateUserProfileApi(isProfilePictureUpdate: true);
      log(response.toString());
      hideLoaderDialog();
    } catch (e, stackTrace) {
      hideLoaderDialog();
      if (kDebugMode) {
        showAlertDialog(msg: e.toString());
      }
      log("uploadUserProfilePicture error => ${stackTrace.toString()}");
    }
  }

  void updateUserProfileApi(
      {bool isProfilePictureUpdate = false,
      String? userName,
      String? userEmail}) async {
    showLoaderDialog();
    final publicKeyPem = await rootBundle.loadString(
      'assets/server_public.pem',
    );
    final publicKey =
        encrypt.RSAKeyParser().parse(publicKeyPem) as RSAPublicKey;
    final encryptedSecret = hex.encode(rsaEncrypt(publicKey, key.bytes));
    final initVector = iv.base16;
    String body;
    if (isProfilePictureUpdate) {
      body = json.encode({
        'data': {
          'avatarUrl': encryptData(value: userAvatarUrl!.value),
        },
        'secretKey': encryptedSecret,
        'initVector': initVector
      });
    } else {
      body = json.encode({
        'data': {
          'displayName': encryptData(value: userName!),
          'email': encryptData(value: userEmail!),
        },
        'secretKey': encryptedSecret,
        'initVector': initVector
      });
    }
    try {
      await repository.postApiCall(url: "user/update", body: body);
      if (!isProfilePictureUpdate) {
        hideLoaderDialog();
        getUserProfileData();
      }
      hideLoaderDialog();
    } catch (e, stackTrace) {
      hideLoaderDialog();
      if (kDebugMode) {
        showAlertDialog(msg: e.toString());
      }
      log("updateUserProfileApi error => ${stackTrace.toString()}");
    }
  }

  /// home screen tab widget list.
  RxList<Widget> homeScreenTabsList = <Widget>[
    const CategoriesTab(),
    const MyOrdersScreen(),
    const HomeTab(),
    const NotificationScreen(),
    const AccountTab(),
  ].obs;

  /// home screen tab widget list.
  RxList<String> appBarTitle = <String>[
    "All Categories",
    "My Orders",
    "Yahmart",
    "Notification",
    "My Account"
  ].obs;

  /// home screen on item tab function.
  void onItemTapped(int index) {
    if (index == 0) {
      selectedTabIndex.value = index;
    } else if (index == 2) {
      selectedTabIndex.value = index;
    } else {
      bool isLogin = CommonLogics.checkUserLogin();
      if (isLogin) {
        selectedTabIndex.value = index;
      } else {
        Get.bottomSheet(const LoginBottomSheet());
      }
    }
  }
}
