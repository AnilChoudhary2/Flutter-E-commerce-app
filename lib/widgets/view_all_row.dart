import 'package:flutter/material.dart';

import '../utils/common_colors.dart';

class ViewAllRow extends StatelessWidget {
  const ViewAllRow({super.key, required this.title, required this.onPressed});
  final String title;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
                color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),
          ),
          // GestureDetector(
          //   onTap: onPressed,
          //   child: Row(
          //     children: [
          //       Text(
          //         "View all",
          //         style: TextStyle(
          //             color: CommonColors.appColor,
          //             fontSize: 13,
          //             fontWeight: FontWeight.w500),
          //       ),
          //       const SizedBox(width: 3),
          //       Icon(Icons.arrow_forward_ios_rounded,
          //           size: 16, color: CommonColors.appColor)
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}
