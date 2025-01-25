import 'package:flutter/material.dart';
import '../../../widgets/network_image_widget.dart';

class HomeCardWidget extends StatelessWidget {
  final String? categoryId;
  final String? catName;
  final String? catImage;
  const HomeCardWidget(
      {Key? key,
      required this.categoryId,
      required this.catName,
      required this.catImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          elevation: 7,
          shape: RoundedRectangleBorder(
            side: const BorderSide(
              color: Colors.black,
            ),
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: SizedBox(
            height: 130,
            width: 120,
            child: Column(
              children: [
                Expanded(
                    child: ClipRRect(
                  borderRadius: BorderRadius.circular(5.0),
                  child: NetworkImageWidget(
                    imageUrl: catImage!,
                  ),
                )),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Text(
                    catName!,
                    maxLines: 1,
                    //overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
        // const SizedBox(height: 5),
        // const Text(
        //   "Under  ₹149",
        //   style: TextStyle(
        //       color: Colors.black87, fontSize: 13, fontWeight: FontWeight.w500),
        // ),
        const SizedBox(
          height: 10,
        )
      ],
    );
  }
}
