import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/common_colors.dart';
import '../../utils/screen_constants.dart';
import '../../utils/url_launcher.dart';

class HelpAndSupportScreen extends StatefulWidget {
  const HelpAndSupportScreen({Key? key}) : super(key: key);

  @override
  State<HelpAndSupportScreen> createState() => _HelpAndSupportScreenState();
}

class _HelpAndSupportScreenState extends State<HelpAndSupportScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CommonColors.whiteColor,
      floatingActionButton: FloatingActionButton(
        backgroundColor: CommonColors.appColor,
        onPressed: () {
          UrlLauncher.launchCaller(callerNumber: "1234567890");
        },
        child: const Icon(Icons.phone_outlined),
      ),
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
          "Get Help",
          style: TextStyle(
              color: CommonColors.appColor,
              fontWeight: FontWeight.bold,
              fontSize: FontSize.s16),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          const SizedBox(height: 20),
          ListTile(
            onTap: () {
              UrlLauncher.launchCaller(callerNumber: "1234567890");
            },
            contentPadding: EdgeInsets.zero,
            leading: Container(
              padding: const EdgeInsets.all(7),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey.withOpacity(.2),
              ),
              child: const Icon(
                Icons.phone_outlined,
                color: Colors.black87,
              ),
            ),
            title: Text(
              "Phone Number",
              style: TextStyle(
                  color: CommonColors.appColor,
                  fontWeight: FontWeight.bold,
                  fontSize: FontSize.s16),
            ),
            subtitle: Text(
              "1234567890",
              style: TextStyle(
                  color: CommonColors.greyColor535353,
                  fontWeight: FontWeight.w500,
                  fontSize: FontSize.s14),
            ),
          ),
          const Divider(
            thickness: 1.5,
          ),
          ListTile(
            onTap: () {
              UrlLauncher.launchEmail(email: 'yahmartindia@gmail.com');
            },
            contentPadding: EdgeInsets.zero,
            leading: Container(
              padding: const EdgeInsets.all(7),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey.withOpacity(.2),
              ),
              child: const Icon(
                Icons.email_outlined,
                color: Colors.black87,
              ),
            ),
            title: Text(
              "E-mail address",
              style: TextStyle(
                  color: CommonColors.appColor,
                  fontWeight: FontWeight.bold,
                  fontSize: FontSize.s16),
            ),
            subtitle: Text(
              "yahmartindia@gmail.com",
              style: TextStyle(
                  color: CommonColors.greyColor535353,
                  fontWeight: FontWeight.w500,
                  fontSize: FontSize.s14),
            ),
          ),
          const Divider(
            thickness: 1.5,
          ),
          ListTile(
            onTap: () {
              UrlLauncher.launchWhatsapp(phone: '1234567890');
            },
            contentPadding: EdgeInsets.zero,
            leading: Container(
              padding: const EdgeInsets.all(7),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey.withOpacity(.2),
              ),
              child: const Icon(
                Icons.phone_iphone_outlined,
                color: Colors.black87,
              ),
            ),
            title: Text(
              "WhatsApp",
              style: TextStyle(
                  color: CommonColors.appColor,
                  fontWeight: FontWeight.bold,
                  fontSize: FontSize.s16),
            ),
            subtitle: Text(
              "1234567890",
              style: TextStyle(
                  color: CommonColors.greyColor535353,
                  fontWeight: FontWeight.w500,
                  fontSize: FontSize.s14),
            ),
          ),
          const Divider(
            thickness: 1.5,
          ),
        ],
      ),
    );
  }
}
