import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:yahmart/utils/common_colors.dart';
import 'package:yahmart/utils/screen_constants.dart';

class ReadMoreTextWidget extends StatelessWidget {
  final String? readMoreText;
  final TextStyle? textStyle;
  final int? trimLines;
  const ReadMoreTextWidget({Key? key, required this.readMoreText, required this.textStyle, this.trimLines}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ReadMoreText(
      readMoreText!,
      trimLines: trimLines ?? 1,
      colorClickableText: Colors.pink,
      trimMode: TrimMode.Line,
      trimCollapsedText: "ShowMore",
      trimExpandedText: " Show less",
      style: textStyle!,
      moreStyle:  TextStyle(
          fontSize: FontSize.s13,
          fontWeight: FontWeight.bold,
          color: CommonColors.yellowColor),
      lessStyle:  TextStyle(
          fontSize: FontSize.s13,
          fontWeight: FontWeight.bold,
          color: CommonColors.yellowColor),
    );
  }
}
