import 'package:doc_o_doctor/constants/app_string.dart';
import 'package:flutter/material.dart';

class TextStyleDecoration {
  static const String fontFamily = AppConst.outfit;

  static TextStyle get labelSmall => const TextStyle(
    fontSize: 14.0,
    // fontWeight: FontWeight.w700,
    fontFamily: fontFamily,
    letterSpacing: 0,
  );
  static TextStyle get labelMedium => const TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w700,
    fontFamily: fontFamily,
    letterSpacing: 0,
  );
  static TextStyle get labelLarge => const TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.w600,
    fontFamily: fontFamily,
    letterSpacing: 0,
  );
}
