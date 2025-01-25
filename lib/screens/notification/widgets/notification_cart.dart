import 'package:flutter/material.dart';

import '../../../utils/common_colors.dart';
import '../../../utils/common_logics.dart';

class NotificationCart extends StatelessWidget {
  final int? index;
  const NotificationCart({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
        leading: CircleAvatar(
          backgroundColor: Color(
            CommonLogics.getRandomColor(index!),
          ),
          child: Text(
            CommonLogics.runeSubstring(
                "Order #673634KMBLK".toUpperCase(), 0, 1),
            style: TextStyle(
                fontSize: 14.0,
                color: CommonColors.lightGreyColor,
                fontWeight: FontWeight.bold),
          ), //Text
        ),
        title: Text(
          "Order #673634KMBLK has been place successfully. We'll send you more updates as your order gets processed.",
          style: TextStyle(fontSize: 13, color: CommonColors.lightGreyColor),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Text(
            "06 Apr. 2023 12:45 PM",
            style: TextStyle(fontSize: 13, color: CommonColors.hintColor),
          ),
        ),
      ),
    );
  }
}
