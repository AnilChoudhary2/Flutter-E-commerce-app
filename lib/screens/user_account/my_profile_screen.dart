import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/home_controller.dart';
import '../../utils/common_colors.dart';
import '../../utils/screen_constants.dart';
import '../../widgets/outline_border_button.dart';
import '../../widgets/user_Image.dart';
import 'edit_profile_screen.dart';

class MyProfileScreen extends StatelessWidget {
  MyProfileScreen({Key? key}) : super(key: key);

  /// find home controller.
  final HomeController _homeC = Get.find();
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
          "My Profile",
          style: TextStyle(
              color: CommonColors.appColor,
              fontWeight: FontWeight.bold,
              fontSize: FontSize.s16),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        color: CommonColors.appBgColor,
        height: 55,
        child: OutlineBorderButtonView(
          "Edit Profile",
          onPressed: () {
            Get.to(() => (const EditProfileScreen()));
          },
          backgroundColor: CommonColors.appColor,
          color: CommonColors.whiteColor,
        ),
      ),
      body: ScrollConfiguration(
        behavior: const ScrollBehavior().copyWith(overscroll: false),
        child: Obx(() {
          return ListView(
            children: [
              Container(
                color: Colors.white,
                padding: const EdgeInsets.all(16),
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: SizedBox(height: 50, width: 50, child: UserImage()),
                  title: Text(
                    _homeC.userName!.value,
                    style: TextStyle(
                        fontSize: 18,
                        color: CommonColors.blackColor,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                color: Colors.white,
                padding: const EdgeInsets.all(16),
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.email_outlined),
                  title: Text(
                    _homeC.userDetailData?.email ?? "user@gmail.com",
                    style: TextStyle(
                        fontSize: FontSize.s14,
                        color: CommonColors.blackColor,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                color: Colors.white,
                padding: const EdgeInsets.all(16),
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.phone_android),
                  title: Text(
                    _homeC.userDetailData?.phone ?? "0000000000",
                    style: TextStyle(
                        fontSize: FontSize.s14,
                        color: CommonColors.blackColor,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ],
          );
        }),
      ),
    );
  }
}
