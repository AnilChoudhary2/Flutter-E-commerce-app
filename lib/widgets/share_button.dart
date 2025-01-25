import 'package:flutter/material.dart';
import 'package:yahmart/utils/common_colors.dart';

import '../utils/common_logics.dart';

class ShareButton extends StatelessWidget {
  final Function() onPressed;
  const ShareButton({Key? key, required this.onPressed}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return IconButton(
        padding: EdgeInsets.zero,
        constraints: const BoxConstraints(),
        icon: Icon(
          Icons.share,
          color: CommonColors.appColor,
          size: 22,
        ),
        onPressed: onPressed);
  }
}
