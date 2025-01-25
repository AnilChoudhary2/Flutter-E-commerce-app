import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yahmart/controller/product_details_controller.dart';
import '../../utils/common_colors.dart';
import '../../utils/custom_alert_dialog.dart';
import '../../utils/screen_constants.dart';
import '../../widgets/outline_border_button.dart';

class PostQuestionsScreen extends StatefulWidget {
  const PostQuestionsScreen({Key? key}) : super(key: key);

  @override
  State<PostQuestionsScreen> createState() => _PostQuestionsScreenState();
}

class _PostQuestionsScreenState extends State<PostQuestionsScreen> {
  /// find product controller.
  final ProductDetailsController _productDetailsC = Get.find();
  TextEditingController postQuestionTextField = TextEditingController(text: "");
  @override
  void initState() {
    super.initState();
  }

  postQuestion() {
    if (postQuestionTextField.value.text == "") {
      showToastMessage(msg: "Please enter a valid question.");
    } else {
      var body = {
        "productFaqType": "QUESTION",
        "productId": _productDetailsC.productDetailsData!.productId!,
        "content": postQuestionTextField.value.text.toString(),
      };
      log(body.toString());
      _productDetailsC.addProductFaq(body: body);
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
          "Post Questions",
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
          "Post Questions",
          onPressed: () => postQuestion(),
          backgroundColor: CommonColors.appColor,
          color: CommonColors.whiteColor,
        ),
      ),
      body: ScrollConfiguration(
        behavior: const ScrollBehavior().copyWith(overscroll: false),
        child: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: ScreenConstant.size10),
                    TextFormField(
                      minLines: 2,
                      maxLines: 5,
                      controller: postQuestionTextField,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        hintText: 'Type questions',
                        hintStyle: TextStyle(color: CommonColors.hintColor),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        ),
                      ),
                    ),
                    SizedBox(height: ScreenConstant.size5),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
