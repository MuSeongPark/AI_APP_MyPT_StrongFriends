import 'package:flutter/material.dart';

ThemeData theme() {
  return ThemeData(
    scaffoldBackgroundColor: Colors.white,
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        backgroundColor: Colors.black,
        primary: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      ),
    ),
  );
}

Color kPrimaryColor = const Color(0xffDDF2FF);
Color kmintColor = const Color(0xff1EEE8A);
Color kLightPurpleColor = const Color(0xffF1F3FA);
Color kLightIvoryColor = const Color(0xffFFE6D6);

TextStyle header = TextStyle(
  fontFamily: 'Nunito',
  fontSize: 32,
  fontWeight: FontWeight.w700,
);

TextStyle subHeader = TextStyle(
  fontFamily: 'Nunito',
  fontSize: 20,
  fontWeight: FontWeight.w700,
);