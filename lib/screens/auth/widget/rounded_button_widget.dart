import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:yahmart/utils/screen_constants.dart';

import '../../../controller/auth_controller.dart';

class RoundedButton extends StatelessWidget {
  final AuthController _authC = Get.put(AuthController());
  RoundedButton(
      {super.key,
      required this.colour,
      required this.title,
      required this.onPressed});
  final Color colour;
  final String title;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Material(
        color: _authC.showSpinner.value ? colour.withOpacity(.7) : colour,
        elevation: 7,
        borderRadius: BorderRadius.circular(8),
        child: MaterialButton(
          onPressed: _authC.showSpinner.value ? null : onPressed,
          //Go to login screen.
          minWidth: MediaQuery.of(context).size.width,
          height: ScreenConstant.size50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: FontSize.s16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 10),
              if (_authC.showSpinner.value)
                 SpinKitWave(
                  color: Colors.white,
                  type: SpinKitWaveType.start,
                  size: ScreenConstant.size20,
                ),
            ],
          ),
        ),
      );
    });
  }
}
