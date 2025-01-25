import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import '../../controller/orders_notification_controller.dart';
import '../../utils/common_colors.dart';
import '../../utils/custom_alert_dialog.dart';
import '../../utils/screen_constants.dart';
import '../../widgets/network_image_widget.dart';
import '../../widgets/outline_border_button.dart';

class AddReviewScreen extends StatefulWidget {
  const AddReviewScreen({Key? key}) : super(key: key);

  @override
  State<AddReviewScreen> createState() => _AddReviewScreenState();
}

class _AddReviewScreenState extends State<AddReviewScreen> {
  /// find orders notification controller.
  final OrdersNotificationController _ordersNC = Get.find();

  /// used to store the rating from the user
  RxDouble starRating = (0.0).obs;
  TextEditingController addReviewTextField = TextEditingController(text: "");
  @override
  void initState() {
    super.initState();
  }

  postQuestion() {
    if (addReviewTextField.value.text == "") {
      showToastMessage(msg: "Please enter a valid review.");
    } else if (starRating.value == 0.0) {
      showToastMessage(msg: "Please give rating to product");
    } else {
      var body = {
        "rating": starRating.value.floor(),
        "description": addReviewTextField.value.text.toString(),
        "productId":
            _ordersNC.orderDetailsData!.productVariant!.product!.productId,
        "images": [
          _ordersNC
              .orderDetailsData!.productVariant!.product!.productBannerImage
        ]
      };
      log(body.toString());
      _ordersNC.addProductAddReview(body: body);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        elevation: 0,
        backgroundColor: CommonColors.greyColor,
        titleSpacing: 0,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: CommonColors.appColor,
            ),
            onPressed: () => Get.back()),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        height: 55,
        child: OutlineBorderButtonView(
          "Submit",
          onPressed: () => postQuestion(),
          backgroundColor: CommonColors.appColor,
          color: CommonColors.whiteColor,
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: ListView(
          children: [
            Stack(
              children: [
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        color: CommonColors.greyColor,
                        width: 140,
                        height: ScreenConstant.size90,
                      ),
                      Container(
                        color: CommonColors.greyColor,
                        width: 140,
                        height: ScreenConstant.size90,
                      )
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                          color: CommonColors.whiteColor,
                          shape: BoxShape.rectangle,
                          border: Border.all(color: CommonColors.borderColor),
                          borderRadius:
                              BorderRadius.circular(ScreenConstant.size8)),
                      height: 170,
                      width: 170,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: NetworkImageWidget(
                          imageUrl: _ordersNC.orderDetailsData!.productVariant!
                              .product!.productBannerImage
                              .toString(),
                        ),
                      )),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(
                  left: ScreenConstant.size16, right: ScreenConstant.size16),
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  RatingBar.builder(
                    initialRating: 0,
                    minRating: 0,
                    direction: Axis.horizontal,
                    allowHalfRating: false,
                    itemCount: 5,
                    itemSize: 50,
                    ignoreGestures: false,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.orange,
                    ),
                    onRatingUpdate: (rating) {
                      print(rating);
                      starRating.value = rating;
                    },
                  ),
                  SizedBox(
                    height: ScreenConstant.size30,
                  ),
                  Text(
                    "Submit Your Review",
                    style: TextStyle(
                        color: CommonColors.lightGreyColor,
                        fontWeight: FontWeight.bold,
                        fontSize: FontSize.s18),
                  ),
                  SizedBox(
                    height: ScreenConstant.size40,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Write Your Experience",
                        style: TextStyle(
                            color: CommonColors.greyColor535353,
                            fontWeight: FontWeight.w500,
                            fontSize: FontSize.s14),
                      ),
                      SizedBox(
                        height: ScreenConstant.size8,
                      ),
                      TextFormField(
                        minLines: 4,
                        maxLines: 5,
                        controller: addReviewTextField,
                        keyboardType: TextInputType.multiline,
                        style: TextStyle(
                            color: CommonColors.blackColor,
                            fontWeight: FontWeight.w500,
                            fontSize: FontSize.s14),
                        decoration: InputDecoration(
                          hintText: 'Enter review',
                          hintStyle: TextStyle(
                              color: CommonColors.hintColor,
                              fontWeight: FontWeight.w500,
                              fontSize: FontSize.s14),
                          border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
