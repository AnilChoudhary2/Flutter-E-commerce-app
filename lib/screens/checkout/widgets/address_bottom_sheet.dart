import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yahmart/controller/cart_checkout_controller.dart';
import '../../../utils/common_colors.dart';
import '../../../utils/common_logics.dart';

class AddressBottomSheet extends StatelessWidget {
  AddressBottomSheet({Key? key}) : super(key: key);

  /// find CartCheckout controller.
  final CartCheckoutController _cartCheckoutC = Get.find();
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12), topRight: Radius.circular(12))),
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 16),
          children: List.generate(_cartCheckoutC.addressesList.length, (index) {
            return Column(
              children: [
                ListTile(
                  onTap: () {
                    for (var element in _cartCheckoutC.addressesList) {
                      element.isSelected!(false);
                    }
                    _cartCheckoutC.addressesList[index].isSelected!(true);
                    _cartCheckoutC.changeDeliveryAddress(
                        newAddress: _cartCheckoutC.addressesList[index]);
                  },
                  trailing: Checkbox(
                    value:
                        _cartCheckoutC.addressesList[index].isSelected!.value,
                    onChanged: (bool? value) {
                      for (var element in _cartCheckoutC.addressesList) {
                        element.isSelected!(false);
                      }
                      _cartCheckoutC.addressesList[index].isSelected!(value);
                      _cartCheckoutC.changeDeliveryAddress(
                          newAddress: _cartCheckoutC.addressesList[index]);
                    },
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 5),
                  selectedTileColor: CommonColors.whiteColor,
                  selected: true,
                  selectedColor: CommonColors.blackColor,
                  leading: CircleAvatar(
                    backgroundColor: Color(
                      CommonLogics.getRandomColor(index),
                    ),
                    child: Text(
                      CommonLogics.runeSubstring(
                          _cartCheckoutC.addressesList[index].addressKind ??
                              "Home".toUpperCase(),
                          0,
                          1),
                      style: TextStyle(
                          fontSize: 14.0,
                          color: CommonColors.lightGreyColor,
                          fontWeight: FontWeight.bold),
                    ), //Text
                  ),
                  title: Padding(
                    padding: const EdgeInsets.only(bottom: 5.0),
                    child: Text(
                      _cartCheckoutC.addressesList[index].addressKind ?? "",
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                  subtitle: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          "${_cartCheckoutC.addressesList[index].houseNumber!}, ${_cartCheckoutC.addressesList[index].addressText!}, ${_cartCheckoutC.addressesList[index].streetName!}"),
                      Text(
                          "${_cartCheckoutC.addressesList[index].city!}, ${_cartCheckoutC.addressesList[index].state!}"),
                      Text(
                          "${_cartCheckoutC.addressesList[index].pincode!}, ${_cartCheckoutC.addressesList[index].country!}"),
                      Text(_cartCheckoutC.addressesList[index].mobile ?? ""),
                    ],
                  ),
                ),
                const Divider(
                  thickness: 1.0,
                ), //
              ],
            );
          }),
        ),
      );
    });
  }
}
