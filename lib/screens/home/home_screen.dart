import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:yahmart/controller/home_controller.dart';
import 'package:yahmart/utils/common_colors.dart';
import 'package:yahmart/utils/common_images.dart';
import '../../controller/cart_checkout_controller.dart';
import '../../controller/orders_notification_controller.dart';
import '../../controller/product_controller.dart';
import '../../utils/common_logics.dart';
import '../../utils/custom_alert_dialog.dart';
import '../../utils/screen_constants.dart';
import '../../widgets/cart_button.dart';
import '../../widgets/favorite_button.dart';
import '../../widgets/menu_button.dart';
import 'navigation_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  /// put home controller.
  final HomeController _homeC = Get.put(HomeController());

  /// put product controller.
  final ProductController _productC = Get.put(ProductController());

  /// put product controller.
  final CartCheckoutController _cartCheckoutC =
      Get.put(CartCheckoutController());

  /// put orders notification controller.
  final OrdersNotificationController _ordersNotificationC =
      Get.put(OrdersNotificationController());

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((Duration time) => init());
    super.initState();
  }

  init() async {
    // var res = await http
    //     .get(Uri.parse('https://yahmartindia.in/api/v1/advert/list"'));
    // print("RESPONSE$res");
    bool isLogin = CommonLogics.checkUserLogin();
    if (isLogin) {
      await _homeC.getUserProfileData();
    }
    await _homeC.getHomeBannersList();
    await _homeC.getHomeCategoryList();
    await _productC.getProductList();
    await _homeC.getAllCategoryList();
  }

  Future<bool> _onWillPop() async {
    return (await showAlertDialogOnPressed(
            msg: 'Do you want to exit from Yahmart',
            onPressed: () {
              SystemNavigator.pop();
            })) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          backgroundColor: CommonColors.appBgColor,
          drawerEnableOpenDragGesture: false,
          drawer: const NavigationDrawerWidget(),
          appBar: AppBar(
            automaticallyImplyLeading: false,
            centerTitle: false,
            elevation: 0,
            backgroundColor: CommonColors.appBgColor,
            leading: const MenuButton(),
            title: Text(
              _homeC.appBarTitle.elementAt(_homeC.selectedTabIndex.value),
              style: TextStyle(
                  color: CommonColors.appColor,
                  fontWeight: FontWeight.bold,
                  fontSize: FontSize.s16),
            ),
            actions: [
              const FavoriteButton(),
              CartButton()
              // Get.isRegistered<ProductController>()
              //     ? CartButton()
              //     : Container(width: 10)
            ],
          ),
          body: _homeC.homeScreenTabsList
              .elementAt(_homeC.selectedTabIndex.value),
          bottomNavigationBar: BottomNavigationBar(
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Image.asset(
                    CommonImages.categoryIcon,
                    height: 20,
                    width: 20,
                    color: CommonColors.whiteColor,
                  ),
                  activeIcon: Image.asset(
                    CommonImages.categoryIcon,
                    height: 20,
                    width: 20,
                    color: CommonColors.yellowColor,
                  ),
                  label: "Categories",
                ),
                BottomNavigationBarItem(
                  icon: Image.asset(
                    CommonImages.otherIcon,
                    height: 20,
                    width: 20,
                    color: CommonColors.whiteColor,
                  ),
                  activeIcon: Image.asset(
                    CommonImages.otherIcon,
                    height: 20,
                    width: 20,
                    color: CommonColors.yellowColor,
                  ),
                  label: "Orders",
                ),
                BottomNavigationBarItem(
                  icon: Image.asset(
                    CommonImages.homeIcon,
                    height: 20,
                    width: 20,
                    color: CommonColors.whiteColor,
                  ),
                  activeIcon: Image.asset(
                    CommonImages.homeIcon,
                    height: 20,
                    width: 20,
                    color: CommonColors.yellowColor,
                  ),
                  label: "Home",
                ),
                BottomNavigationBarItem(
                  icon: Badge(
                    label: const Text('12'),
                    child: Image.asset(
                      CommonImages.bellIcon,
                      height: 20,
                      width: 20,
                      color: CommonColors.whiteColor,
                    ),
                  ),
                  activeIcon: Badge(
                    label: const Text('12'),
                    child: Image.asset(
                      CommonImages.bellIcon,
                      height: 20,
                      width: 20,
                      color: CommonColors.yellowColor,
                    ),
                  ),
                  label: "Notification",
                ),
                BottomNavigationBarItem(
                  icon: Image.asset(
                    CommonImages.accountIcon,
                    height: 20,
                    width: 20,
                    color: CommonColors.whiteColor,
                  ),
                  activeIcon: Image.asset(
                    CommonImages.accountIcon,
                    height: 20,
                    width: 20,
                    color: CommonColors.yellowColor,
                  ),
                  label: "Account",
                ),
              ],
              type: BottomNavigationBarType.fixed,
              currentIndex: _homeC.selectedTabIndex.value,
              selectedItemColor: CommonColors.yellowColor,
              unselectedItemColor: Colors.white,
              selectedLabelStyle: const TextStyle(height: 1.7, fontSize: 10),
              unselectedLabelStyle: const TextStyle(fontSize: 10, height: 1.7),
              backgroundColor: CommonColors.appColor,
              onTap: _homeC.onItemTapped,
              elevation: 5),
        ),
      );
    });
  }
}
