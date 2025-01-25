import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:yahmart/screens/coupons/coupons_screen.dart';
import 'package:yahmart/utils/common_colors.dart';
import 'package:yahmart/utils/common_images.dart';
import 'package:yahmart/utils/common_logics.dart';
import 'package:yahmart/utils/screen_constants.dart';
import '../../controller/home_controller.dart';
import '../../utils/custom_alert_dialog.dart';
import '../favorite_product/favorite_product_screen.dart';
import '../my_cart/my_cart_screen.dart';
import '../orders/help_and_support_screen.dart';
import '../user_account/privacy_policy_screen.dart';

class NavigationDrawerWidget extends StatefulWidget {
  const NavigationDrawerWidget({Key? key}) : super(key: key);

  @override
  State<NavigationDrawerWidget> createState() => _NavigationDrawerWidgetState();
}

class _NavigationDrawerWidgetState extends State<NavigationDrawerWidget> {
  /// find home controller.
  final HomeController _homeC = Get.find();

  ///instance of PackageInfo
  PackageInfo? packageInfo;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((Duration time) => init());
    _initPackageInfo();
    super.initState();
  }

  init() {
    _initPackageInfo();
  }

  ///init package info details
  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    packageInfo = info;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
            topRight: Radius.circular(12), bottomRight: Radius.circular(4)),
        child: Drawer(
          backgroundColor: CommonColors.appBgColor,
          // Disable opening the drawer with a swipe gesture.
          child: ListView(
            children: [
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  padding: const EdgeInsets.only(top: 35, left: 16, bottom: 25),
                  decoration: BoxDecoration(
                      color: CommonColors.appColor,
                      borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(12))), //BoxDecoration
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: CircleAvatar(
                      backgroundColor: CommonColors.yellowColor,
                      child: Text(
                        CommonLogics.runeSubstring(
                            _homeC.userDetailData?.displayName ??
                                "Yahmart".toUpperCase(),
                            0,
                            1),
                        style: TextStyle(
                            fontSize: 30.0, color: CommonColors.whiteColor),
                      ), //Text
                    ),
                    title: Text(
                      _homeC.userDetailData?.displayName ?? "Yahmart",
                      style: TextStyle(
                          fontSize: 18, color: CommonColors.whiteColor),
                    ),
                    subtitle: Text(
                      _homeC.userDetailData?.email ?? "yahmartindia@gmail.com",
                      style: TextStyle(
                          fontSize: 14, color: CommonColors.whiteColor),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
              const SizedBox(height: 16),
              drawerItems(
                  image: CommonImages.homeIcon,
                  name: 'Home',
                  onPressed: () {
                    Get.back();
                    _homeC.selectedTabIndex(2);
                  }),
              drawerItems(
                  image: CommonImages.categoryIcon,
                  name: 'All Categories',
                  onPressed: () {
                    Get.back();
                    _homeC.selectedTabIndex(0);
                  }),
              drawerItems(
                  image: CommonImages.otherIcon,
                  name: 'My Orders',
                  onPressed: () {
                    Get.back();
                    _homeC.selectedTabIndex(1);
                  }),
              drawerItems(
                  image: CommonImages.cartIcon,
                  name: 'My Carts',
                  onPressed: () {
                    Get.back();
                    Get.to(() => (const MyCartScreen()));
                  }),
              drawerItems(
                  image: CommonImages.accountIcon,
                  name: 'My Account',
                  onPressed: () {
                    Get.back();
                    _homeC.selectedTabIndex(4);
                  }),
              drawerItems(
                  image: CommonImages.hartIcon,
                  name: 'My Wishlist',
                  onPressed: () {
                    Get.back();
                    Get.to(() => (const FavoriteProductScreen()));
                  }),
              drawerItems(
                  image: CommonImages.bellIcon,
                  name: 'My Notification',
                  onPressed: () {
                    Get.back();
                    _homeC.selectedTabIndex(3);
                  }),
              drawerItems(
                  image: CommonImages.couponIcon,
                  name: 'Coupons',
                  onPressed: () {
                    Get.back();
                    Get.to(() => (const CouponsScreen()));
                  }),
              drawerItems(
                  image: CommonImages.privacyPolicyIcon,
                  name: 'Privacy Policy',
                  onPressed: () {
                    Get.back();
                    Get.to(() => (const PrivacyPolicyScreen()));
                  }),
              drawerItems(
                  image: CommonImages.helpCenterIcon,
                  name: 'Help & Support',
                  onPressed: () {
                    Get.back();
                    Get.to(() => (const HelpAndSupportScreen()));
                  }),
              drawerItems(
                  image: CommonImages.logoutIcon,
                  name: 'LogOut',
                  onPressed: () {
                    Get.back();
                    showAlertDialogOnPressed(
                        msg: 'Are you sure you want to logout? ',
                        onPressed: () {
                          CommonLogics.logOut();
                        });
                  }),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  "App Version: v  ${packageInfo?.version}",
                  style: TextStyle(
                      color: CommonColors.hintColor,
                      fontSize: FontSize.s14,
                      fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  drawerItems(
      {required String? image,
      required String? name,
      required Function()? onPressed}) {
    return ListTile(
      visualDensity: const VisualDensity(horizontal: 0, vertical: -2),
      minVerticalPadding: 0,
      leading: Container(
          width: 20,
          alignment: Alignment.center,
          child: Image.asset(
            image!,
            color: CommonColors.appColor,
          )),
      minLeadingWidth: 20,
      title: Padding(
        padding: const EdgeInsets.only(bottom: 5),
        child: Text(
          name!,
          style: TextStyle(
              color: CommonColors.blackColor,
              fontSize: FontSize.s14,
              fontWeight: FontWeight.w600),
        ),
      ),
      onTap: onPressed,
    );
  }
}
