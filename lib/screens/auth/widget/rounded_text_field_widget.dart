import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:yahmart/utils/common_colors.dart';
import 'package:yahmart/utils/screen_constants.dart';

class OutlineBorderInputField extends StatelessWidget {
  TextEditingController controller;
  TextInputType keyboardType;
  bool autofocus = false;
  int maxLine = 1;
  int minLines;
  TextAlign textAlign = TextAlign.start;
  TextInputAction textInputAction;
  int textColor;
  String hintText;
  double fontSize = FontSize.s14;
  int hintColor;
  int? maxLength;
  Function(String)? onTextChanged;
  bool isAllowDecimal;
  Function(String)? onFieldSubmitted;
  List<TextInputFormatter>? inputFormatters;
  FocusNode? customRequestFocus, customFocusNode;
  bool isEnable;

  OutlineBorderInputField({
    required this.controller,
    required this.keyboardType,
    required this.autofocus,
    required this.maxLine,
    required this.textAlign,
    required this.textInputAction,
    required this.textColor,
    required this.hintText,
    required this.fontSize,
    required this.hintColor,
    this.customRequestFocus,
    this.customFocusNode,
    this.onTextChanged,
    this.isAllowDecimal = false,
    this.maxLength,
    this.onFieldSubmitted,
    this.inputFormatters,
    this.minLines = 1,
    this.isEnable = true,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      elevation: 3,
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        autofocus: autofocus,
        textAlign: textAlign,
        minLines: minLines,
        maxLines: maxLine,
        maxLength: maxLength,
        cursorColor: Color(textColor),
        focusNode: customFocusNode,
        enabled: isEnable,
        onEditingComplete: () {
          if (customRequestFocus != null) {
            FocusScope.of(context).requestFocus(customRequestFocus);
          } else {
            FocusScope.of(context).nextFocus();
          }
        },
        inputFormatters: (inputFormatters != null)
            ? inputFormatters
            : isAllowDecimal
                ? [DecimalFormatter(decimalDigits: 2)]
                : keyboardType == TextInputType.phone ||
                        keyboardType == TextInputType.number
                    ? <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly,
                      ]
                    : null,
        textInputAction: textInputAction,
        decoration: InputDecoration(
          counterText: "",
          isDense: true,
          // Added this
          contentPadding: const EdgeInsets.all(16),
          border: InputBorder.none,
          hintText: hintText,
          hintStyle: TextStyle(
            color: CommonColors.hintColor,
            fontSize: fontSize,
          ),
        ),
        style: TextStyle(
          color: Color(textColor),
          fontSize: fontSize,
        ),
        onChanged: (value) {
          onTextChanged?.call(value);
        },
        onFieldSubmitted: onFieldSubmitted,
      ),
    );
  }
}

class DecimalFormatter extends TextInputFormatter {
  final int decimalDigits;

  DecimalFormatter({this.decimalDigits = 2}) : assert(decimalDigits >= 0);

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String newText;

    if (decimalDigits == 0) {
      newText = newValue.text.replaceAll(RegExp('[^0-9]'), '');
    } else {
      newText = newValue.text.replaceAll(RegExp('[^0-9\.]'), '');
    }

    if (newText.contains('.')) {
      //in case if user's first input is "."
      if (newText.trim() == '.') {
        return newValue.copyWith(
          text: '0.',
          selection: const TextSelection.collapsed(offset: 2),
        );
      }
      //in case if user tries to input multiple "."s or tries to input
      //more than the decimal place
      else if ((newText.split(".").length > 2) ||
          (newText.split(".")[1].length > this.decimalDigits)) {
        return oldValue;
      } else
        return newValue;
    }

    //in case if input is empty or zero
    if (newText.trim() == '' || newText.trim() == '0') {
      return newValue.copyWith(text: '');
    } else if (int.parse(newText) < 1) {
      return newValue.copyWith(text: '');
    }

    double newDouble = double.parse(newText);
    var selectionIndexFromTheRight =
        newValue.text.length - newValue.selection.end;

    String newString = NumberFormat("#,##0.##").format(newDouble);

    return TextEditingValue(
      text: newString,
      selection: TextSelection.collapsed(
        offset: newString.length - selectionIndexFromTheRight,
      ),
    );
  }
}
