import "package:flutter/material.dart";

class AppTheme {
  ///convert app orange color in MaterialColor for app theme
  static const MaterialColor primaryBlue = MaterialColor(
    _bluePrimaryValue,
    <int, Color>{
      50: Color(0xff243646),
      100: Color(0xff243646),
      200: Color(0xff243646),
      300: Color(0xff243646),
      400: Color(0xff243646),
      500: Color(_bluePrimaryValue),
      600: Color(0xff243646),
      700: Color(0xff243646),
      800: Color(0xff243646),
      900: Color(0xff243646),
    },
  );

  ///orange primary color
  static const int _bluePrimaryValue = 0xff243646;

  ///define light theme
  static ThemeData lightTheme = ThemeData(
    fontFamily: "Inter",
    primarySwatch: primaryBlue,
    primaryColor: const Color(0xffFFFFFF),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );

  static ThemeData darkTheme = ThemeData(
    fontFamily: "Inter",
    primaryColor: Colors.black,
    primarySwatch: primaryBlue,
    brightness: Brightness.dark,
  );

  static const int _darkPrimary = 0xff474747;
  static const MaterialColor primaryDark = MaterialColor(
    _darkPrimary,
    <int, Color>{
      50: Color(0xff474747),
      100: Color(0xff474747),
      200: Color(0xff474747),
      300: Color(0xff474747),
      400: Color(0xff474747),
      500: Color(_darkPrimary),
      600: Color(0xff474747),
      700: Color(0xff474747),
      800: Color(0xff474747),
      900: Color(0xff474747),
    },
  );
}
