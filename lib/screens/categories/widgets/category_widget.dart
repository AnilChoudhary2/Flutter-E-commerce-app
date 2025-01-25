import 'package:flutter/material.dart';
import '../../../utils/common_colors.dart';
import '../../../widgets/network_image_widget.dart';

class CategoryWidget extends StatelessWidget {
  final String? categoryId;
  final String? catName;
  final String? catImage;
  const CategoryWidget(
      {Key? key,
      required this.categoryId,
      required this.catName,
      required this.catImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 35.0,
          backgroundColor: Colors.transparent,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: NetworkImageWidget(
              imageUrl: catImage!,
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        SizedBox(
          width: 80,
          child: Text(
            catName!.contains("&") ? catName!.replaceAll("&", "") : catName!,
            maxLines: 1,
            //overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: CommonColors.blackColor,
                fontSize: 13,
                fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }
}
