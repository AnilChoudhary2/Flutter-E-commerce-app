import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yahmart/screens/search_product/search_product_screen.dart';
import 'package:yahmart/utils/common_colors.dart';
import 'package:yahmart/utils/common_images.dart';
import 'package:yahmart/utils/screen_constants.dart';

class HomeSearchTextField extends StatelessWidget {
  HomeSearchTextField({Key? key}) : super(key: key);
  final TextEditingController searchTextField = TextEditingController(text: "");
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Get.to(()=>const SearchProductScreen());
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.symmetric(horizontal: 8),
        color: CommonColors.appColor,
        elevation: 3,
        child: SizedBox(
          height: 42,
          child: TextField(
            style: TextStyle(
              color: CommonColors.blackColor,
              fontSize: ScreenConstant.size13,
            ),
            maxLines: 1,
            controller: searchTextField,
            decoration: InputDecoration(
              counterText: "",
              contentPadding: const EdgeInsets.all(10),
              border: InputBorder.none,
              hintText: "Search Product",
              enabled: false,
              hintStyle: TextStyle(
                color: CommonColors.whiteColor,
                fontSize: ScreenConstant.size14,
              ),
              prefixIcon: IconButton(
                color: CommonColors.searchHintColor,
                icon: const Icon(
                  Icons.search,
                  size: 25,
                ),
                onPressed: () {},
              ),
              suffixIcon: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min, // added line
                children: <Widget>[
                  Image.asset(
                    CommonImages.microIcon,
                    color: CommonColors.searchHintColor,
                    height: 20,
                  ),
                  IconButton(
                      padding: EdgeInsets.zero,
                      icon: Icon(
                        Icons.camera_alt_outlined,
                        color: CommonColors.searchHintColor,
                      ),
                      onPressed: () {}),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
