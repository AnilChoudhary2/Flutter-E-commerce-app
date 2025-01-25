import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yahmart/screens/product_details/widgets/linear_progress_indicator_row.dart';
import '../../../controller/product_details_controller.dart';
import '../../../utils/common_colors.dart';
import '../../../utils/screen_constants.dart';

class AverageRatingWidget extends StatelessWidget {
  AverageRatingWidget({Key? key}) : super(key: key);

  /// find product detail controller.
  final ProductDetailsController _productDetailsC = Get.find();
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.center,
                  height: 35,
                  width: 70,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(0, 3),
                        color: Colors.grey.withOpacity(.3),
                        blurRadius: 2.0,
                      ),
                    ],
                    color: Colors.green,
                    // border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    "3.9 *",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: CommonColors.whiteColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                Text(
                  "2,704 ratings",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: FontSize.s10,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87),
                ),
                const SizedBox(height: 4),
                Text(
                  "433 reviews",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: FontSize.s10,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87),
                ),
              ],
            )),
        Expanded(
          flex: 8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              LinearProgressIndicatorRow(
                progressColor: Colors.green.shade600,
                text: 'Excellent',
                trailingText: '1,392',
                percent: 0.7,
              ),
              const SizedBox(height: 5),
              LinearProgressIndicatorRow(
                progressColor: Colors.green.shade400,
                text: 'Very Good',
                trailingText: '432',
                percent: 0.4,
              ),
              const SizedBox(height: 5),
              LinearProgressIndicatorRow(
                progressColor: Colors.green.shade300,
                text: 'Good',
                trailingText: '319',
                percent: 0.3,
              ),
              const SizedBox(height: 5),
              LinearProgressIndicatorRow(
                progressColor: Colors.yellow.shade800,
                text: 'Average',
                trailingText: '219',
                percent: 0.4,
              ),
              const SizedBox(height: 5),
              LinearProgressIndicatorRow(
                progressColor: Colors.red.shade600,
                text: 'Poor',
                trailingText: '342',
                percent: 0.3,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
