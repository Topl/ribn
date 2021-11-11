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
}
