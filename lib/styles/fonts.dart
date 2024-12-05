import 'package:flutter/material.dart';

import 'colors.dart';

class AppFonts {
  // Define font families
  static const String primaryFont = 'Inter';


  // Define common font sizes
  static const double smallFontSize = 12.0;
  static const double regularFontSize = 14.0;
  static const double mediumFontSize = 16.0;
  static const double largeFontSize = 18.0;
  static const double extraLargeFontSize = 20.0;

  // Define common font weights
  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
  static const FontWeight extraBold = FontWeight.w900;

  // Example of reusable TextStyle
  static TextStyle heading1 = const TextStyle(
    fontFamily: primaryFont,
    fontSize: largeFontSize,
    fontWeight: extraBold,
    color: AppColors.darkgreen,
  );

  static TextStyle heading2 = const TextStyle(
    fontFamily: primaryFont,
    fontSize: mediumFontSize,
    fontWeight: medium,
    color: Colors.white,
  );

  static TextStyle bodyText = const TextStyle(
    fontFamily: primaryFont,
    fontSize: regularFontSize,
    fontWeight: regular,
    color: Colors.black87,
  );

  static TextStyle subHeading = const TextStyle(
    fontFamily: primaryFont,
    fontSize: mediumFontSize,
    fontWeight: medium,
    color: Colors.black54,
  );
}
