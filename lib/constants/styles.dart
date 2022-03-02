import 'package:flutter/material.dart';
import 'package:ribn/constants/colors.dart';

/// The custom [TextStyle]s being used in the app.
class RibnTextStyles {
  RibnTextStyles._();
  static const TextStyle h1 = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 40,
    fontWeight: FontWeight.w500,
    color: RibnColors.defaultText,
    height: 1.26,
  );
  static const TextStyle h2 = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 28,
    fontWeight: FontWeight.w500,
    color: RibnColors.defaultText,
  );
  static const TextStyle h3 = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 20,
    fontWeight: FontWeight.w500,
    color: RibnColors.defaultText,
  );
  static const TextStyle body1 = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 20,
    color: RibnColors.defaultText,
    height: 2.13,
  );
  static const TextStyle body1Bold = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 20,
    color: RibnColors.defaultText,
    fontWeight: FontWeight.w500,
  );
  static const TextStyle smallBoldLabel = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 13,
    color: RibnColors.defaultText,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
  );

  static const TextStyle extH2 = TextStyle(
    fontFamily: 'Spectral',
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle extH3 = TextStyle(
    fontFamily: 'Spectral',
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle extH4 = TextStyle(
    fontFamily: 'Spectral',
    fontSize: 13,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle hintStyle = TextStyle(
    fontFamily: 'Nunito',
    fontSize: 12,
    color: RibnColors.hintTextColor,
  );
  static const TextStyle btnMedium = TextStyle(
    fontFamily: 'Nunito',
    fontSize: 18,
    color: Colors.white,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle dropdownButtonStyle = TextStyle(
    color: RibnColors.whiteBackground,
    fontWeight: FontWeight.w600,
    fontFamily: 'Nunito',
    fontSize: 12,
  );

  static const TextStyle smallBody = TextStyle(
    color: RibnColors.defaultText,
    fontWeight: FontWeight.w400,
    fontFamily: 'Nunito',
    fontSize: 12.0,
    decoration: TextDecoration.none,
  );
}
