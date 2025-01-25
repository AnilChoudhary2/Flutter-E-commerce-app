import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import '../../controller/cart_checkout_controller.dart';
import '../../utils/common_colors.dart';
import '../../utils/custom_alert_dialog.dart';
import '../../utils/screen_constants.dart';
import '../../widgets/outline_border_button.dart';
import '../auth/widget/rounded_text_field_widget.dart';

class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({Key? key}) : super(key: key);

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  /// find product controller.
  final CartCheckoutController _cartCheckoutC = Get.find();
  TextEditingController houseNumberTextField = TextEditingController(text: "");
  TextEditingController addressTextField = TextEditingController(text: "");
  TextEditingController streetNameTextField = TextEditingController(text: "");
  TextEditingController cityTextField = TextEditingController(text: "");
  TextEditingController stateTextField = TextEditingController(text: "");
  TextEditingController countryTextField = TextEditingController(text: "");
  TextEditingController pinCodeTextField = TextEditingController(text: "");
  TextEditingController mobileTextField = TextEditingController(text: "");
  List<String> addressTypeList = ["Home", "Work"];
  String addressType = "Home";
  Position? position;

  @override
  void initState() {
    _determinePosition();
    super.initState();
  }

  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    position = await GeolocatorPlatform.instance.getCurrentPosition();
    log(position?.latitude.toString() ?? "position?.latitude {null}");
    log(position?.longitude.toString() ?? "position?.longitude {null}");
  }

  addAddress() {
    if (houseNumberTextField.value.text == "") {
      showToastMessage(
          msg: "Please enter a valid house number & building, floor name.");
    } else if (addressTextField.value.text == "") {
      showToastMessage(msg: "Please enter a valid address.");
    } else if (streetNameTextField.value.text == "") {
      showToastMessage(msg: "Please enter a valid street name.");
    } else if (cityTextField.value.text == "") {
      showToastMessage(msg: "Please enter a valid city name.");
    } else if (stateTextField.value.text == "") {
      showToastMessage(msg: "Please enter a valid state name.");
    } else if (countryTextField.value.text == "") {
      showToastMessage(msg: "Please enter a valid country name.");
    } else if (pinCodeTextField.value.text == "" ||
        pinCodeTextField.value.text.length < 6) {
      showToastMessage(msg: "Please enter a valid pin code");
    } else if (mobileTextField.value.text == "" ||
        mobileTextField.value.text.length < 10) {
      showToastMessage(msg: "Please enter a valid mobile number");
    } else {
      var body = {
        "addressType": "SHIPPING",
        "city": cityTextField.value.text.toString(),
        "country": countryTextField.value.text.toString(),
        "latitude":
            position?.latitude.toString() ?? "26.91", //Jaipur, Rajasthan, India
        "longitude": position?.longitude.toString() ??
            "75.78", //Latitude and longitude coordinates are: 26.922070, 75.778885.
        "pincode": pinCodeTextField.value.text.toString(),
        "mobile": mobileTextField.value.text.toString(),
        "state": stateTextField.value.text.toString(),
        "addressText": addressTextField.value.text.toString(),
        "houseNumber": houseNumberTextField.value.text.toString(),
        "streetName": streetNameTextField.value.text.toString(),
        "addressKind": addressType.toString()
      };
      log(body.toString());
      _cartCheckoutC.addDeliveryAddress(body: body);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CommonColors.appBgColor,
      appBar: AppBar(
        centerTitle: false,
        elevation: 0,
        backgroundColor: CommonColors.appBgColor,
        titleSpacing: 0,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: CommonColors.appColor,
            ),
            onPressed: () => Get.back()),
        title: Text(
          "Add Address",
          style: TextStyle(
              color: CommonColors.appColor,
              fontWeight: FontWeight.bold,
              fontSize: FontSize.s16),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        color: CommonColors.appBgColor,
        height: 55,
        child: OutlineBorderButtonView(
          "Add Address",
          onPressed: () => addAddress(),
          backgroundColor: CommonColors.appColor,
          color: CommonColors.whiteColor,
        ),
      ),
      body: ScrollConfiguration(
        behavior: const ScrollBehavior().copyWith(overscroll: false),
        child: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: ScreenConstant.size10),
                    OutlineBorderInputField(
                      controller: houseNumberTextField,
                      keyboardType: TextInputType.text,
                      autofocus: false,
                      maxLine: 1,
                      textAlign: TextAlign.start,
                      textInputAction: TextInputAction.next,
                      textColor: CommonColors.blackColor.value,
                      hintText: "House number & building, floor name",
                      fontSize: ScreenConstant.size13,
                      hintColor: CommonColors.hintColor.value,
                      isAllowDecimal: false,
                    ),
                    SizedBox(height: ScreenConstant.size5),
                    OutlineBorderInputField(
                      controller: addressTextField,
                      keyboardType: TextInputType.text,
                      autofocus: false,
                      maxLine: 1,
                      textAlign: TextAlign.start,
                      textInputAction: TextInputAction.next,
                      textColor: CommonColors.blackColor.value,
                      hintText: "Address",
                      fontSize: ScreenConstant.size13,
                      hintColor: CommonColors.hintColor.value,
                      isAllowDecimal: false,
                    ),
                    SizedBox(height: ScreenConstant.size5),
                    OutlineBorderInputField(
                      controller: streetNameTextField,
                      keyboardType: TextInputType.text,
                      autofocus: false,
                      maxLine: 1,
                      textAlign: TextAlign.start,
                      textInputAction: TextInputAction.done,
                      textColor: CommonColors.blackColor.value,
                      hintText: "Street name",
                      fontSize: ScreenConstant.size13,
                      hintColor: CommonColors.hintColor.value,
                      isAllowDecimal: false,
                    ),
                    SizedBox(height: ScreenConstant.size5),
                    OutlineBorderInputField(
                      controller: cityTextField,
                      keyboardType: TextInputType.text,
                      autofocus: false,
                      maxLine: 1,
                      textAlign: TextAlign.start,
                      textInputAction: TextInputAction.done,
                      textColor: CommonColors.blackColor.value,
                      hintText: "City name",
                      fontSize: ScreenConstant.size13,
                      hintColor: CommonColors.hintColor.value,
                      isAllowDecimal: false,
                    ),
                    SizedBox(height: ScreenConstant.size5),
                    OutlineBorderInputField(
                      controller: stateTextField,
                      keyboardType: TextInputType.text,
                      autofocus: false,
                      maxLine: 1,
                      textAlign: TextAlign.start,
                      textInputAction: TextInputAction.done,
                      textColor: CommonColors.blackColor.value,
                      hintText: "State name",
                      fontSize: ScreenConstant.size13,
                      hintColor: CommonColors.hintColor.value,
                      isAllowDecimal: false,
                    ),
                    SizedBox(height: ScreenConstant.size5),
                    OutlineBorderInputField(
                      controller: countryTextField,
                      keyboardType: TextInputType.text,
                      autofocus: false,
                      maxLine: 1,
                      textAlign: TextAlign.start,
                      textInputAction: TextInputAction.done,
                      textColor: CommonColors.blackColor.value,
                      hintText: "Country name",
                      fontSize: ScreenConstant.size13,
                      hintColor: CommonColors.hintColor.value,
                      isAllowDecimal: false,
                    ),
                    SizedBox(height: ScreenConstant.size5),
                    OutlineBorderInputField(
                      controller: pinCodeTextField,
                      keyboardType: TextInputType.number,
                      autofocus: false,
                      maxLine: 1,
                      maxLength: 6,
                      textAlign: TextAlign.start,
                      textInputAction: TextInputAction.done,
                      textColor: CommonColors.blackColor.value,
                      hintText: "Pin code",
                      fontSize: ScreenConstant.size13,
                      hintColor: CommonColors.hintColor.value,
                      isAllowDecimal: false,
                    ),
                    SizedBox(height: ScreenConstant.size5),
                    OutlineBorderInputField(
                      controller: mobileTextField,
                      keyboardType: TextInputType.number,
                      autofocus: false,
                      maxLine: 1,
                      maxLength: 10,
                      textAlign: TextAlign.start,
                      textInputAction: TextInputAction.done,
                      textColor: CommonColors.blackColor.value,
                      hintText: "Phone number",
                      fontSize: ScreenConstant.size13,
                      hintColor: CommonColors.hintColor.value,
                      isAllowDecimal: false,
                    ),
                    const SizedBox(height: 20),
                    const Padding(
                      padding: EdgeInsets.only(left: 6),
                      child: Text("Select Address Type",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          )),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      margin: EdgeInsets.only(left: ScreenConstant.size6),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: List.generate(
                            addressTypeList.length,
                            (index) => GestureDetector(
                                  onTap: () {
                                    addressType = addressTypeList[index];
                                    setState(() {});
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 10),
                                    margin: const EdgeInsets.only(
                                        top: 12, right: 8),
                                    height: 30,
                                    decoration: BoxDecoration(
                                      color:
                                          addressType == addressTypeList[index]
                                              ? CommonColors.yellowColor
                                              : Colors.white,
                                      border: Border.all(
                                          color: CommonColors.borderColor,
                                          width: 1),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(13)),
                                      boxShadow: const [
                                        BoxShadow(
                                            color: Colors.transparent,
                                            spreadRadius: 0,
                                            blurRadius: 0,
                                            offset: Offset(0, 0))
                                      ],
                                    ),
                                    child: Text(
                                      addressTypeList[index],
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: false,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 13,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                )),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
