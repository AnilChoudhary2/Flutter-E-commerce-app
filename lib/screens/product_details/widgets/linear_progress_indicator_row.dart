import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../../utils/common_colors.dart';
import '../../../utils/screen_constants.dart';

class LinearProgressIndicatorRow extends StatelessWidget {
   final Color? progressColor;
   final String? text;
   final String? trailingText;
   final double? percent;
   const LinearProgressIndicatorRow({Key? key,required this.progressColor,required this.text,required this.trailingText,required this.percent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: 60,
          child: Text(
            text!,
            textAlign: TextAlign.start,
            style: TextStyle(
                fontSize: FontSize.s10,
                fontWeight: FontWeight.w500,
                color: Colors.black87),
          ),
        ),
        Expanded(
          child: LinearPercentIndicator(
            lineHeight: ScreenConstant.size3,
            animation: true,
            animationDuration: 1500,
            percent: percent!,
            barRadius: const Radius.circular(10),
            backgroundColor: CommonColors.borderColor,
            progressColor: progressColor,
          ),
        ),
        SizedBox(
          width: 30,
          child: Text(
            trailingText!,
            textAlign: TextAlign.start,
            style: TextStyle(
                fontSize: FontSize.s10,
                fontWeight: FontWeight.w500,
                color: Colors.grey),
          ),
        ),
      ],
    );
  }
}
