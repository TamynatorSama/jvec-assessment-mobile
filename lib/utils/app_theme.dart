import 'package:flutter/material.dart';

class AppTheme{
  static Color backgroundColor = const Color(0xff0F101B);
  static Color btnColor = const Color(0xff262B44);
  static TextStyle headerTextStyle = const TextStyle(
    fontFamily: "Coinbase-Sans",
    fontWeight: FontWeight.w500,
    fontSize: 20,
    color: Colors.white
  );
  static TextStyle mainTextStyle = const TextStyle(
    fontFamily: "Coinbase-Sans",
    fontWeight: FontWeight.w400,
    fontSize: 14,
    color: Colors.white
  );
}

extension TextHelper on TextStyle{
  TextStyle override({String? fontFamily,
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    double? letterSpacing,
    FontStyle? fontStyle,
    // bool useGoogleFonts = true,
    TextDecoration? decoration,
    double? lineHeight,})=>copyWith(
        fontFamily: fontFamily,
        color: color,
        fontSize: fontSize,
        letterSpacing: letterSpacing,
        fontWeight: fontWeight,
        fontStyle: fontStyle,
        decoration: decoration,
        height: lineHeight,
    );
    }