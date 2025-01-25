import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yahmart/screens/auth/widget/rounded_text_field_widget.dart';
import '../../controller/home_controller.dart';
import '../../utils/common_colors.dart';
import '../../utils/custom_alert_dialog.dart';
import '../../utils/screen_constants.dart';
import '../../widgets/outline_border_button.dart';
import '../../widgets/user_Image.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  /// find home controller.
  final HomeController _homeC = Get.find();
  final ImagePicker picker = ImagePicker();
  TextEditingController nameTextField = TextEditingController(text: "");
  TextEditingController mobileTextField = TextEditingController(text: "");
  TextEditingController emailTextField = TextEditingController(text: "");

  @override
  void initState() {
    nameTextField = TextEditingController(
        text: _homeC.userDetailData?.displayName ?? "user");
    mobileTextField = TextEditingController(
        text: _homeC.userDetailData?.phone ?? "0000000000");
    emailTextField = TextEditingController(
        text: _homeC.userDetailData?.email ?? "user@gmail.com");
    super.initState();
  }

  updateProfile() {
    if (nameTextField.value.text == "") {
      showToastMessage(msg: "Please enter a valid user name.");
    } else if (emailTextField.value.text == "") {
      showToastMessage(msg: "Please enter a valid user email.");
    } else {
      _homeC.updateUserProfileApi(
          userName: nameTextField.value.text,
          userEmail: emailTextField.value.text);
    }
  }

  /// Get from gallery
  _getFromGallery() async {
    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      // File imageFile = File(pickedFile.path);
      _homeC.uploadUserProfilePicture(file: pickedFile);
    }
  }

  /// Get from camera
  _getFromCamera() async {
    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.camera,
    );
    if (pickedFile != null) {
      _homeC.uploadUserProfilePicture(file: pickedFile);
    }
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
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: CommonColors.appColor,
            ),
            onPressed: () => Get.back()),
        title: Text(
          "Edit Profile",
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
          "Save Profile",
          onPressed: () => updateProfile(),
          backgroundColor: CommonColors.appColor,
          color: CommonColors.whiteColor,
        ),
      ),
      body: ScrollConfiguration(
        behavior: const ScrollBehavior().copyWith(overscroll: false),
        child: ListView(
          children: [
            GestureDetector(
              onTap: () => imagePickerAlertDialog(),
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.all(16),
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: SizedBox(height: 50, width: 50, child: UserImage()),
                  title: const Text(
                    "Tab to change profile picture",
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.black38,
                        fontWeight: FontWeight.normal),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                children: [
                  SizedBox(height: ScreenConstant.size20),
                  OutlineBorderInputField(
                    controller: nameTextField,
                    keyboardType: TextInputType.text,
                    autofocus: false,
                    maxLine: 1,
                    textAlign: TextAlign.start,
                    textInputAction: TextInputAction.next,
                    textColor: CommonColors.blackColor.value,
                    hintText: "User name",
                    fontSize: ScreenConstant.size13,
                    hintColor: CommonColors.hintColor.value,
                    isAllowDecimal: false,
                  ),
                  SizedBox(height: ScreenConstant.size5),
                  OutlineBorderInputField(
                    isEnable: false,
                    controller: mobileTextField,
                    keyboardType: TextInputType.phone,
                    autofocus: false,
                    maxLine: 1,
                    textAlign: TextAlign.start,
                    textInputAction: TextInputAction.next,
                    textColor: CommonColors.blackColor.value,
                    hintText: "Mobile number",
                    maxLength: 10,
                    fontSize: ScreenConstant.size13,
                    hintColor: CommonColors.hintColor.value,
                    isAllowDecimal: false,
                  ),
                  SizedBox(height: ScreenConstant.size5),
                  OutlineBorderInputField(
                    controller: emailTextField,
                    keyboardType: TextInputType.emailAddress,
                    autofocus: false,
                    maxLine: 1,
                    textAlign: TextAlign.start,
                    textInputAction: TextInputAction.done,
                    textColor: CommonColors.blackColor.value,
                    hintText: "Email address",
                    fontSize: ScreenConstant.size13,
                    hintColor: CommonColors.hintColor.value,
                    isAllowDecimal: false,
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  imagePickerAlertDialog() {
    AlertDialog alert = AlertDialog(
      contentPadding: EdgeInsets.zero,
      titlePadding: const EdgeInsets.only(top: 10),
      title: Text(
        "Yahmart",
        textAlign: TextAlign.center,
        style: TextStyle(
            color: CommonColors.blackColor,
            fontWeight: FontWeight.bold,
            fontSize: 16),
      ),
      content: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Text(
          "Pick user profile picture.",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: CommonColors.blackColor,
              fontWeight: FontWeight.normal,
              fontSize: 13),
        ),
      ),
      //insetPadding: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      actionsAlignment: MainAxisAlignment.center,
      actionsPadding: const EdgeInsets.only(bottom: 12),
      actions: [
        GestureDetector(
          onTap: () {
            Get.back();
            _getFromGallery();
          },
          child: Container(
            alignment: Alignment.center,
            height: ScreenConstant.size30,
            width: ScreenConstant.size80,
            decoration: BoxDecoration(
                color: CommonColors.appColor,
                borderRadius: BorderRadius.circular(10)),
            child: Text(
              "Gallery",
              textAlign: TextAlign.center,
              style: TextStyle(color: CommonColors.whiteColor),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Get.back();
            _getFromCamera();
          },
          child: Container(
            alignment: Alignment.center,
            height: ScreenConstant.size30,
            width: ScreenConstant.size80,
            decoration: BoxDecoration(
                color: CommonColors.appColor,
                borderRadius: BorderRadius.circular(10)),
            child: Text(
              "Camera",
              textAlign: TextAlign.center,
              style: TextStyle(color: CommonColors.whiteColor),
            ),
          ),
        ),
      ],
    );
    showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
