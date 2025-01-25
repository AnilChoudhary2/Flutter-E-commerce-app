import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yahmart/screens/coupons/coupons_screen.dart';
import 'package:yahmart/screens/favorite_product/favorite_product_screen.dart';
import 'package:yahmart/utils/custom_alert_dialog.dart';
import 'package:yahmart/widgets/user_Image.dart';
import '../../controller/home_controller.dart';
import '../../utils/common_colors.dart';
import '../../utils/common_images.dart';
import '../../utils/common_logics.dart';
import '../../utils/screen_constants.dart';
import '../my_cart/my_cart_screen.dart';
import '../orders/help_and_support_screen.dart';
import 'my_profile_screen.dart';
import 'privacy_policy_screen.dart';

class AccountTab extends StatefulWidget {
  const AccountTab({Key? key}) : super(key: key);

  @override
  State<AccountTab> createState() => _AccountTabState();
}

class _AccountTabState extends State<AccountTab> {
  /// find home controller.
  final HomeController _homeC = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CommonColors.appBgColor,
      body: ScrollConfiguration(
        behavior: const ScrollBehavior().copyWith(overscroll: false),
        child: ListView(
          children: [
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16),
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                leading: SizedBox(height: 50, width: 50, child: UserImage()),
                title: Obx(() => Text(
                      _homeC.userName!.value,
                      style: TextStyle(
                          fontSize: 18,
                          color: CommonColors.blackColor,
                          fontWeight: FontWeight.bold),
                    )),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  // String deviceFcmToken = sp!.getString(SpUtil.deviceFcmToken);
                  // Clipboard.setData(ClipboardData(text: deviceFcmToken));
                  Get.to(() => (MyProfileScreen()));
                },
              ),
            ),
            const SizedBox(height: 10),
            accountItems(
                image: CommonImages.cartIcon,
                name: 'My Carts',
                onPressed: () {
                  Get.to(() => (const MyCartScreen()));
                }),
            accountItems(
                image: CommonImages.hartIcon,
                name: 'My Wishlist',
                onPressed: () {
                  Get.to(() => (const FavoriteProductScreen()));
                }),
            accountItems(
                image: CommonImages.bellIcon,
                name: 'My Notification',
                onPressed: () {
                  _homeC.selectedTabIndex(3);
                }),
            accountItems(
                image: CommonImages.couponIcon,
                name: 'Coupons',
                onPressed: () {
                  Get.to(() => (const CouponsScreen()));
                }),
            accountItems(
                image: CommonImages.privacyPolicyIcon,
                name: 'Privacy Policy',
                onPressed: () {
                  Get.to(() => (const PrivacyPolicyScreen()));
                }),
            accountItems(
                image: CommonImages.helpCenterIcon,
                name: 'Help & Support',
                onPressed: () {
                  Get.to(() => (const HelpAndSupportScreen()));
                }),
            accountItems(
                image: CommonImages.logoutIcon,
                name: 'LogOut',
                onPressed: () {
                  showAlertDialogOnPressed(
                      msg: 'Are you sure you want to logout? ',
                      onPressed: () {
                        CommonLogics.logOut();
                      });
                }),
            Container(
              color: CommonColors.whiteColor,
              margin: const EdgeInsets.only(bottom: 10),
              child: ListTile(
                leading: Container(
                    width: 20,
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    )),
                minLeadingWidth: 40,
                title: Text(
                  "Delete Account",
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: FontSize.s14,
                      fontWeight: FontWeight.w500),
                ),
                onTap: () {
                  showAlertDialogOnPressed(
                      msg: 'Are you sure you want to delete account?',
                      onPressed: () {
                        Get.back();
                        _homeC.deleteUserAccount();
                      });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  accountItems(
      {required String? image,
      required String? name,
      required Function()? onPressed}) {
    return Container(
      color: CommonColors.whiteColor,
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: Container(
            width: 25,
            alignment: Alignment.center,
            child: Image.asset(
              image!,
              color: Colors.black,
            )),
        minLeadingWidth: 40,
        title: Text(
          name!,
          style: TextStyle(
              color: Colors.black,
              fontSize: FontSize.s14,
              fontWeight: FontWeight.bold),
        ),
        onTap: onPressed,
      ),
    );
  }
}
