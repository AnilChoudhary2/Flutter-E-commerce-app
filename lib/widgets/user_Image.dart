import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yahmart/utils/common_colors.dart';
import '../controller/home_controller.dart';
import 'full_screen_network_image_widget.dart';
import 'network_image_widget.dart';

class UserImage extends StatelessWidget {
  UserImage({Key? key}) : super(key: key);

  /// find home controller.
  final HomeController _homeC = Get.find();
  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            color: CommonColors.profileColor,
            borderRadius: const BorderRadius.all(Radius.circular(50.0)),
            border: Border.all(
              color: CommonColors.whiteColor,
              width: 1.5,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50.0),
            child: FullScreenNetworkImageWidget(
              imageUrl: _homeC.userAvatarUrl!.value,
            ),
          ),
        ));
  }
}
