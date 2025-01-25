import 'package:flutter/material.dart';
import 'device_manager.dart';

Size? screenSize;
double defaultScreenWidth = 380.0;
double defaultScreenHeight = 800.0;
double screenWidth = defaultScreenWidth;
double screenHeight = defaultScreenHeight;

class ScreenConstant {
  /*Nimmio Default height */
  static double size0 = 0.0;
  static double size1 = 1.0;
  static double size2 = 2.0;
  static double size3 = 3.0;
  static double size4 = 4.0;
  static double size5 = 5.0;
  static double size6 = 6.0;
  static double size7 = 7.0;
  static double size8 = 8.0;
  static double size9 = 9.0;
  static double size10 = 10;
  static double size11 = 11;
  static double size12 = 12;
  static double size13 = 13;
  static double size14 = 14;
  static double size15 = 15;
  static double size16 = 16;
  static double size17 = 17;
  static double size18 = 18;
  static double size19 = 19;
  static double size20 = 20;
  static double size21 = 21;
  static double size22 = 22;
  static double size23 = 23;
  static double size24 = 24;
  static double size25 = 25;
  static double size26 = 26;
  static double size27 = 27;
  static double size28 = 28;
  static double size30 = 30;
  static double size32 = 32;
  static double size34 = 34;
  static double size36 = 36;
  static double size38 = 38;
  static double size40 = 40;
  static double size43 = 43;
  static double size44 = 44;
  static double size45 = 45;
  static double size48 = 48;
  static double size50 = 50;
  static double size55 = 55;
  static double size56 = 56;
  static double size58 = 58;
  static double size60 = 60;
  static double size65 = 65;
  static double size63 = 63;
  static double size66 = 66;
  static double size68 = 68;
  static double size70 = 70;
  static double size72 = 72;
  static double size74 = 74;
  static double size73 = 73;
  static double size75 = 75;
  static double size78 = 78;
  static double size80 = 80;
  static double size83 = 83;
  static double size85 = 85;
  static double size76 = 76;
  static double size82 = 82;
  static double size86 = 86;
  static double size88 = 88;
  static double size90 = 90;
  static double size95 = 95;
  static double size98 = 98;

  static double size100 = 100;
  static double size103 = 103;
  static double size108 = 108;
  static double size110 = 110;
  static double size113 = 113;
  static double size117 = 117;
  static double size120 = 120;
  static double size107 = 107;
  static double size130 = 130;
  static double size131 = 131;
  static double size132 = 132;
  static double size135 = 135;
  static double size140 = 140;
  static double size142 = 142;
  static double size144 = 144;
  static double size146 = 146;
  static double size148 = 148;
  static double size150 = 150;
  static double size160 = 160;
  static double size170 = 170;
  static double size179 = 179;
  static double size180 = 180;
  static double size182 = 182;
  static double size188 = 188;
  static double size190 = 190;
  static double size198 = 198;

  static double size200 = 200;
  static double size202 = 202;
  static double size210 = 210;
  static double size220 = 220;
  static double size225 = 225;
  static double size230 = 230;
  static double size232 = 232;
  static double size240 = 240;
  static double size245 = 245;
  static double size250 = 250;
  static double size255 = 255;
  static double size260 = 260;
  static double size265 = 265;
  static double size290 = 290;

  static double size300 = 300;
  static double size320 = 320;
  static double size330 = 330;
  static double size336 = 336;
  static double size340 = 340;
  static double size350 = 350;
  static double size360 = 360;
  static double size375 = 375;
  static double size380 = 380;

  static double size400 = 400;
  static double size455 = 455;
  static double size450 = 450;
  static double size460 = 460;

  /*Screen Size dependent Constants*/
  static double screenWidthHalf = screenWidth / 2;
  static double screenWidthThird = screenWidth / 3;
  static double screenWidthFourth = screenWidth / 4;
  static double screenWidthFifth = screenWidth / 5;
  static double screenWidthSixth = screenWidth / 6;
  static double screenWidthTenth = screenWidth / 10;
  static double screenWidthEleven = screenWidth / 11;
  static double screenWidthTwelve = screenWidth / 12;
  static double screenWidthThirteen = screenWidth / 13;
  static double screenWidthFourteen = screenWidth / 14;
  static double screenWidthFifteen = screenWidth / 15;
  static double screenWidthMinimum = screenWidth / 25;

  /*Screen Size dependent Constants*/
  static double screenHeightHalf = screenHeight / 2;
  static double screenHeightThird = screenHeight / 3;
  static double screenHeightTwoAndhalf = screenHeight / 2.9;
  static double screenHeightFourth = screenHeight / 4;
  static double screenHeightFifth = screenHeight / 5;
  static double screenHeightSixth = screenHeight / 6;
  static double screenHeightEight = screenHeight / 8;
  static double screenHeightTenth = screenHeight / 10;
  static double screenHeightEleven = screenHeight / 11;
  static double screenHeightTwelve = screenHeight / 12;
  static double screenHeightThirteen = screenHeight / 13;
  static double screenHeightFourteen = screenHeight / 14;
  static double screenHeightFifteen = screenHeight / 15;
  static double screenHeightMinimum = screenHeight / 25;

  /*Image Dimensions*/

  static double defaultIconSize = 80.0;
  static double miniIconSize = 66.0;
  static double defaultImageHeight = 120.0;
  static double defaultDialogHeight = 450.0;
  static double defaultMidHeight = 350.0;
  static double defaultImageWidth = screenWidth;
  static double defaultImageWidthThird = screenWidth / 3;
  static double snackBarHeight = 50.0;
  static double texIconSize = 30.0;
  static double drawerIconSize = 25.0;

  /*Default Height&Width*/
  static double defaultIndicatorWidth = screenWidthFourth;

  /*EdgeInsets*/
  static EdgeInsets spacingAllZero = EdgeInsets.all(0);
  static EdgeInsets spacingAllDefault = EdgeInsets.all(size8);
  static EdgeInsets spacingAllExtraSmall = EdgeInsets.all(size4);
  static EdgeInsets spacingAllSmall = EdgeInsets.all(size10);
  static EdgeInsets spacingAllMedium = EdgeInsets.all(size16);
  static EdgeInsets spacingAllLarge = EdgeInsets.all(size20);
  static EdgeInsets spacingXL = EdgeInsets.all(size30);

  static EdgeInsets spacingOnlySmall =
      EdgeInsets.only(top: size10, bottom: size10);
  static EdgeInsets spacingLeftOnly = EdgeInsets.only(left: size8);

  static void setDefaultSize(context) {
    screenSize = MediaQuery.of(context).size;
    screenWidth = screenSize?.width ?? 0;
    screenHeight = screenSize?.height ?? 0;

    size30 = 30.0;
    size40 = 40.0;
    size50 = 50.0;
    size60 = 60.0;
    size70 = 70.0;

    screenWidthHalf = screenWidth / 2;
    screenWidthThird = screenWidth / 3;
    screenWidthFourth = screenWidth / 4;
    screenWidthFifth = screenWidth / 5;
    screenWidthSixth = screenWidth / 6;
    screenWidthTenth = screenWidth / 10;
    screenWidthEleven = screenWidth / 11;
    screenWidthTwelve = screenWidth / 12;
    screenWidthThirteen = screenWidth / 13;
    screenWidthFourteen = screenWidth / 14;
    screenWidthFifteen = screenWidth / 15;
    screenWidthMinimum = screenWidth / 25;

    screenHeightHalf = screenHeight / 2;
    screenHeightTwoAndhalf = screenHeight / 2.9;

    screenHeightThird = screenHeight / 3;
    screenHeightFourth = screenHeight / 4;
    screenHeightFifth = screenHeight / 5;
    screenHeightSixth = screenHeight / 6;
    screenHeightEight = screenHeight / 8;
    screenHeightTenth = screenHeight / 10;
    screenHeightEleven = screenHeight / 11;
    screenHeightTwelve = screenHeight / 12;
    screenHeightThirteen = screenHeight / 13;
    screenHeightFourteen = screenHeight / 14;
    screenHeightFifteen = screenHeight / 15;
    screenHeightMinimum = screenHeight / 25;

    defaultIconSize = 80.0;
    defaultImageHeight = 120.0;
    snackBarHeight = 50.0;
    texIconSize = 30.0;

    defaultIndicatorWidth = screenWidthFourth;

    spacingAllDefault = EdgeInsets.all(size8);
    spacingAllSmall = EdgeInsets.all(size10);

    FontSize.setDefaultFontSize();
  }

  static void setScreenAwareConstant(context) {
    setDefaultSize(context);
    DeviceManager.instance = DeviceManager(
      width: defaultScreenWidth,
      height: defaultScreenHeight,
      allowFontScaling: true,
    )..init(context);

    FontSize.setScreenAwareFontSize();

    /*EdgeInsets*/
    spacingAllZero = const EdgeInsets.all(0);
    spacingAllDefault = EdgeInsets.all(size8);
    spacingAllSmall = EdgeInsets.all(size10);
    spacingAllMedium = EdgeInsets.all(size16);
    spacingAllLarge = EdgeInsets.all(size20);
    spacingOnlySmall = EdgeInsets.only(
      top: size10,
      bottom: size10,
    );
    spacingLeftOnly = EdgeInsets.only(
      left: size8,
    );

    /*Screen Size dependent Constants*/
    screenWidthHalf = DeviceManager.instance.width / 2;
    screenWidthThird = DeviceManager.instance.width / 3;
    screenWidthFourth = DeviceManager.instance.width / 4;
    screenWidthFifth = DeviceManager.instance.width / 5;
    screenWidthSixth = DeviceManager.instance.width / 6;
    screenWidthTenth = DeviceManager.instance.width / 10;

    /*Image Dimensions*/

    defaultIconSize = DeviceManager.instance.setWidth(80.0);
    miniIconSize = DeviceManager.instance.setWidth(66.0);
    defaultImageHeight = DeviceManager.instance.setHeight(120.0);
    snackBarHeight = DeviceManager.instance.setHeight(50.0);
    texIconSize = DeviceManager.instance.setWidth(30.0);
    drawerIconSize = DeviceManager.instance.setWidth(25.0);

    size4 = DeviceManager.instance.setWidth(4.0);
    size8 = DeviceManager.instance.setWidth(8.0);
    size10 = DeviceManager.instance.setWidth(10.0);
    size10 = DeviceManager.instance.setHeight(10.0);
    size12 = DeviceManager.instance.setWidth(12.0);
    size13 = DeviceManager.instance.setWidth(13.0);
    size14 = DeviceManager.instance.setWidth(14.0);
    size16 = DeviceManager.instance.setHeight(16.0);
    size18 = DeviceManager.instance.setHeight(18.0);
    size20 = DeviceManager.instance.setHeight(20.0);
    size22 = DeviceManager.instance.setHeight(22.0);
    size24 = DeviceManager.instance.setHeight(24.0);
    size26 = DeviceManager.instance.setWidth(26.0);
    size30 = DeviceManager.instance.setWidth(30.0);
    size34 = DeviceManager.instance.setWidth(34.0);
    size40 = DeviceManager.instance.setHeight(40.0);
    size44 = DeviceManager.instance.setHeight(44.0);
    size48 = DeviceManager.instance.setHeight(48.0);
    size50 = DeviceManager.instance.setWidth(50.0);
    size55 = DeviceManager.instance.setHeight(55.0);
    size56 = DeviceManager.instance.setHeight(56.0);
    size60 = DeviceManager.instance.setHeight(60.0);
    size70 = DeviceManager.instance.setHeight(70.0);
    size76 = DeviceManager.instance.setHeight(76.0);
    size80 = DeviceManager.instance.setWidth(80.0);
    size82 = DeviceManager.instance.setHeight(82.0);
    size90 = DeviceManager.instance.setHeight(90.0);
    size98 = DeviceManager.instance.setHeight(98.0);
    size100 = DeviceManager.instance.setWidth(100.0);

    size107 = DeviceManager.instance.setWidth(107.0);
    size110 = DeviceManager.instance.setHeight(110);
    size120 = DeviceManager.instance.setWidth(120);
    size130 = DeviceManager.instance.setWidth(130);
    size140 = DeviceManager.instance.setWidth(140.0);
    size150 = DeviceManager.instance.setWidth(150);
    size160 = DeviceManager.instance.setWidth(160);
    size170 = DeviceManager.instance.setWidth(170.0);
    size180 = DeviceManager.instance.setWidth(180.0);

    size200 = DeviceManager.instance.setHeight(200.0);
    size210 = DeviceManager.instance.setWidth(210.0);
    size220 = DeviceManager.instance.setWidth(220);
    size225 = DeviceManager.instance.setWidth(225.0);
    size230 = DeviceManager.instance.setWidth(230);
    size250 = DeviceManager.instance.setWidth(250);
    size260 = DeviceManager.instance.setWidth(260);
    size290 = DeviceManager.instance.setWidth(290);

    size300 = DeviceManager.instance.setHeight(300);
    size320 = DeviceManager.instance.setHeight(320);
    size330 = DeviceManager.instance.setWidth(330);
    size336 = DeviceManager.instance.setWidth(336.0);
    size340 = DeviceManager.instance.setWidth(340);
    size350 = DeviceManager.instance.setWidth(350);
    size360 = DeviceManager.instance.setWidth(360);
    size380 = DeviceManager.instance.setWidth(380);

    size400 = DeviceManager.instance.setWidth(450);
    size450 = DeviceManager.instance.setHeight(450);
    size455 = DeviceManager.instance.setWidth(455);
    size460 = DeviceManager.instance.setWidth(460);

    defaultIndicatorWidth = screenWidthFourth;
  }
}

class FontSize {
  static double s7 = 7.0;
  static double s8 = 8.0;
  static double s9 = 9.0;
  static double s10 = 10.0;
  static double s11 = 11.0;
  static double s12 = 12.0;
  static double s13 = 13.0;
  static double s14 = 14.0;
  static double s15 = 15.0;
  static double s16 = 16.0;
  static double s17 = 17.0;
  static double s18 = 18.0;
  static double s19 = 19.0;
  static double s20 = 20.0;
  static double s21 = 21.0;
  static double s22 = 22.0;
  static double s23 = 23.0;
  static double s24 = 24.0;
  static double s25 = 25.0;
  static double s26 = 26.0;
  static double s27 = 27.0;
  static double s28 = 28.0;
  static double s29 = 29.0;
  static double s30 = 30.0;
  static double s34 = 34.0;
  static double s36 = 36.0;
  static double s40 = 40.0;

  static setDefaultFontSize() {
    s7 = 7.0;
    s8 = 8.0;
    s9 = 9.0;
    s10 = 10.0;
    s11 = 11.0;
    s12 = 12.0;
    s13 = 13.0;
    s14 = 14.0;
    s15 = 15.0;
    s16 = 16.0;
    s17 = 17.0;
    s18 = 18.0;
    s19 = 19.0;
    s20 = 20.0;
    s21 = 21.0;
    s22 = 22.0;
    s23 = 23.0;
    s24 = 24.0;
    s25 = 25.0;
    s26 = 26.0;
    s27 = 27.0;
    s28 = 28.0;
    s29 = 29.0;
    s30 = 30.0;
    s34 = 34.0;
    s36 = 36.0;
    s40 = 40.0;
  }

  static setScreenAwareFontSize() {
    s7 = DeviceManager.instance.setSp(7.0);
    s8 = DeviceManager.instance.setSp(8.0);
    s9 = DeviceManager.instance.setSp(9.0);
    s10 = DeviceManager.instance.setSp(10.0);
    s11 = DeviceManager.instance.setSp(11.0);
    s12 = DeviceManager.instance.setSp(12.0);
    s13 = DeviceManager.instance.setSp(13.0);
    s14 = DeviceManager.instance.setSp(14.0);
    s15 = DeviceManager.instance.setSp(15.0);
    s16 = DeviceManager.instance.setSp(16.0);
    s17 = DeviceManager.instance.setSp(17.0);
    s18 = DeviceManager.instance.setSp(18.0);
    s19 = DeviceManager.instance.setSp(19.0);
    s20 = DeviceManager.instance.setSp(20.0);
    s21 = DeviceManager.instance.setSp(21.0);
    s22 = DeviceManager.instance.setSp(22.0);
    s23 = DeviceManager.instance.setSp(23.0);
    s24 = DeviceManager.instance.setSp(24.0);
    s25 = DeviceManager.instance.setSp(25.0);
    s26 = DeviceManager.instance.setSp(26.0);
    s27 = DeviceManager.instance.setSp(27.0);
    s28 = DeviceManager.instance.setSp(28.0);
    s29 = DeviceManager.instance.setSp(29.0);
    s30 = DeviceManager.instance.setSp(30.0);
    s34 = DeviceManager.instance.setSp(34.0);
    s36 = DeviceManager.instance.setSp(36.0);
    s40 = DeviceManager.instance.setSp(40.0);
  }
}
