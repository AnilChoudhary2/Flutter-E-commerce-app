import 'package:flutter/material.dart';
import 'package:yahmart/utils/screen_constants.dart';
import '../utils/common_colors.dart';

class OutlineBorderButtonView extends StatelessWidget {
  OutlineBorderButtonView(
    this.text, {
    super.key,
    required this.onPressed,
    this.isDisable = false,
    this.color,
    this.disabledColor,
    this.backgroundColor,
    this.fontSize,
    this.padding,
    this.borderColor,
  });

  final String text;
  bool isDisable;
  Function() onPressed;
  Color? color;
  Color? borderColor;
  Color? disabledColor;
  Color? backgroundColor;
  double? fontSize;
  EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    final ButtonStyle textButtonStyle = TextButton.styleFrom(
      backgroundColor: backgroundColor ?? Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 14.0),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(ScreenConstant.size4),
      ),
      side: BorderSide(
        color: borderColor ?? CommonColors.appColor,
        width: 1,
      ),
    );
    return TextButton(
      onPressed: isDisable ? () {} : onPressed,
      style: textButtonStyle,
      child: Padding(
        padding: padding ?? const EdgeInsets.symmetric(vertical: 12),
        child: Text(
          text,
          textScaleFactor: 1.0,
          maxLines: 1,
          style: TextStyle(
            fontSize: fontSize ?? FontSize.s13,
            color: isDisable
                ? disabledColor ?? CommonColors.borderColor
                : color ?? CommonColors.appColor,
          ),
        ),
      ),
    );
  }
}
