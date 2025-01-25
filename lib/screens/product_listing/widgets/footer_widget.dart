import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:yahmart/screens/product_listing/widgets/sorting_bottom_sheet.dart';
import 'package:yahmart/utils/common_colors.dart';
import '../../../utils/common_images.dart';
import '../../../utils/screen_constants.dart';
import '../product_filter_screen.dart';

class FooterWidget extends StatelessWidget {
  const FooterWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              top: BorderSide(width: 1, color: CommonColors.borderColor),
            )),
        height: 45,
        child: Row(
          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: InkWell(
                onTap: () {
                  Get.bottomSheet(
                    SortingBottomSheet(),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      CommonImages.sortByIcon,
                      color: Colors.black87,
                      height: ScreenConstant.size22,
                      width: ScreenConstant.size22,
                    ),
                    SizedBox(
                      width: ScreenConstant.size7,
                    ),
                    const Text(
                      "Sort",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 30,
              width: 1.0,
              color: CommonColors.borderColor,
            ),
            Expanded(
              child: InkWell(
                onTap: () {
                  Get.to(() => const ProductFilterScreen());
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      CommonImages.filterIcon,
                      color: Colors.black87,
                      height: ScreenConstant.size22,
                      width: ScreenConstant.size22,
                    ),
                    SizedBox(
                      width: ScreenConstant.size7,
                    ),
                    const Text(
                      "Filter",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
