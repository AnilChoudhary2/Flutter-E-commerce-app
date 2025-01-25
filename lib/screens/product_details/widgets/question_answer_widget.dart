import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yahmart/controller/product_details_controller.dart';
import 'package:yahmart/screens/product_details/post_questions_screen.dart';
import '../../../utils/common_colors.dart';
import '../../../utils/screen_constants.dart';

class QuestionAnswerWidget extends StatelessWidget {
  QuestionAnswerWidget({Key? key}) : super(key: key);

  /// find product detail controller.
  final ProductDetailsController _productDetailsC = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return _productDetailsC.isFaqListLoading.value
          ? Container()
          : Container(
              color: CommonColors.whiteColor,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Question And Answer",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: FontSize.s15,
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                      ),
                      GestureDetector(
                          onTap: () {
                            Get.to(() => const PostQuestionsScreen());
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 5),
                            decoration: BoxDecoration(
                                color: CommonColors.appBgColor,
                                borderRadius: BorderRadius.circular(5),
                                border:
                                    Border.all(color: CommonColors.appColor)),
                            child: Text(
                              "Post Question",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: CommonColors.yellowColor),
                            ),
                          ))
                    ],
                  ),
                  if (_productDetailsC.faqList.isNotEmpty)
                    ListView.builder(
                      itemCount: _productDetailsC.faqList.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return _productDetailsC
                                .faqList[index].answers!.isNotEmpty
                            ? Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Q: ${_productDetailsC.faqList[index].content}",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          fontSize: FontSize.s15,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black),
                                    ),
                                    ..._productDetailsC.faqList[index].answers!
                                        .map(
                                      (e) => Padding(
                                        padding: const EdgeInsets.only(top: 8),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "A: ${e.content}",
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  fontSize: FontSize.s14,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.black87),
                                            ),
                                            Row(
                                              children: [
                                                const Icon(
                                                  Icons.thumb_up,
                                                  color: Colors.grey,
                                                  size: 20,
                                                ),
                                                const SizedBox(width: 8),
                                                Text(
                                                  e.upvote! > 0
                                                      ? e.upvote!.toString()
                                                      : "",
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                      fontSize: FontSize.s12,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Colors.grey),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    const Divider(color: Colors.grey),
                                  ],
                                ),
                              )
                            : Container();
                      },
                    ),
                  const SizedBox(height: 14),
                ],
              ),
            );
    });
  }
}
