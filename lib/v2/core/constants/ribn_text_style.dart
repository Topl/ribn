// Flutter imports:
import 'package:flutter/material.dart';
// Project imports:
import 'package:ribn/v2/core/constants/colors.dart';

// Project imports:

///@dev The custom [TextStyle]s being used in the app.
///@notice These are the new styles to be agreed upon
class RibnTextStyle {
  RibnTextStyle._();

  static const TextStyle h1 = TextStyle(
    fontFamily: 'DM Sans',
    fontSize: 32,
    fontWeight: FontWeight.w700,
    color: RibnColors.defaultText,
    height: 1.57,
    // letterSpacing: 1.68,
  );

  static const TextStyle h2 = TextStyle(
    fontFamily: 'DM Sans',
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: RibnColors.defaultText,
    height: 1.34,
  );

  static const TextStyle h3 = TextStyle(
    fontFamily: 'DM Sans',
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: RibnColors.defaultText,
  );

  static final h3Grey = RibnTextStyle.h3.copyWith(color: RibnColors.greyText);

  //
  static const TextStyle h4 = TextStyle(
    fontFamily: 'DM Sans',
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: RibnColors.defaultText,
  );

  static final h4Grey = RibnTextStyle.h4.copyWith(color: RibnColors.greyText);

  //
  // static const TextStyle body1 = TextStyle(
  //   fontFamily: 'DM Sans',
  //   fontSize: 16,
  //   color: RibnColors.defaultText,
  //   height: 2.67,
  // );
  //
  // static const TextStyle body1Bold = TextStyle(
  //   fontFamily: 'DM Sans',
  //   fontSize: 16,
  //   color: RibnColors.defaultText,
  //   fontWeight: FontWeight.w500,
  //   height: 1.2,
  // );
  //
  // static const TextStyle smallBoldLabel = TextStyle(
  //   fontFamily: 'DM Sans',
  //   fontSize: 13,
  //   color: RibnColors.defaultText,
  //   fontWeight: FontWeight.w500,
  //   letterSpacing: 0.5,
  // );
  //
  // static const TextStyle extH2 = TextStyle(
  //   fontFamily: 'DM Sans',
  //   fontSize: 24,
  //   fontWeight: FontWeight.bold,
  //   letterSpacing: 1,
  // );
  //
  // static const TextStyle extH3 = TextStyle(
  //   fontFamily: 'DM Sans',
  //   fontSize: 16,
  //   fontWeight: FontWeight.w500,
  // );
  //
  // static const TextStyle hintStyle = TextStyle(
  //   fontFamily: 'DM Sans',
  //   fontSize: 12,
  //   color: RibnColors.defaultText,
  //   fontWeight: FontWeight.w300,
  // );
  //

  static const TextStyle buttonLarge = TextStyle(
    fontFamily: 'DM Sans',
    fontSize: 19.6,
    color: RibnColors.accent,
    fontWeight: FontWeight.w300,
  );

  static const TextStyle buttonMedium = TextStyle(
    fontFamily: 'DM Sans',
    fontSize: 16,
    color: RibnColors.defaultText,
    fontWeight: FontWeight.w300,
  );

  static const TextStyle buttonSmall = TextStyle(
    fontFamily: 'DM Sans',
    fontSize: 14,
    color: Colors.white,
    fontWeight: FontWeight.w300,
  );

  static const TextStyle dropdownButtonStyle = TextStyle(
    color: RibnColors.greyText,
    fontWeight: FontWeight.w300,
    fontFamily: 'DM Sans',
    fontSize: 12,
  );
//
// static const TextStyle smallBody = TextStyle(
//   color: RibnColors.defaultText,
//   fontWeight: FontWeight.w300,
//   fontFamily: 'DM Sans',
//   fontSize: 12.0,
//   decoration: TextDecoration.none,
// );
//
// static const TextStyle settingsSmallText = TextStyle(
//   fontSize: 9.3,
//   fontWeight: FontWeight.w300,
//   fontFamily: 'DM Sans',
//   color: Color(0xFF585858),
// );
//
// static const TextStyle toolTipTextStyle = TextStyle(
//   color: RibnColors.defaultText,
//   fontWeight: FontWeight.w300,
//   fontFamily: 'DM Sans',
//   fontSize: 12,
//   decoration: TextDecoration.none,
// );
//
// static const TextStyle assetShortNameStyle = TextStyle(
//   fontFamily: 'DM Sans',
//   fontWeight: FontWeight.w500,
//   fontSize: 15,
//   color: RibnColors.defaultText,
//   letterSpacing: 1,
// );
//
// static const TextStyle assetLongNameStyle = TextStyle(
//   fontFamily: 'DM Sans',
//   fontSize: 12,
//   color: Color(0xff585858),
//   letterSpacing: 1,
// );
//
// static const TextStyle onboardingH1 = TextStyle(
//   fontFamily: 'DM Sans',
//   fontSize: 28,
//   fontWeight: FontWeight.w500,
//   color: RibnColors.lightGreyTitle,
//   height: 1.67,
//   letterSpacing: 1.42,
// );
//
// static const TextStyle onboardingH3 = TextStyle(
//   fontFamily: 'DM Sans',
//   fontSize: 18,
//   fontWeight: FontWeight.w400,
//   color: RibnColors.lightGreyTitle,
//   height: 1.6,
// );
//
// // static const TextStyle h1 = TextStyle(
// //   fontFamily: 'DM Sans',
// //   fontSize: 36,
// //   fontWeight: FontWeight.w700,
// //   height: 1.57,
// //   letterSpacing: 1.68,
// // );
// //
// // static const TextStyle h2 = TextStyle(
// //   fontFamily: 'DM Sans',
// //   fontSize: 30,
// //   fontWeight: FontWeight.w700,
// //   height: 1.34,
// // );
// //
// // static const TextStyle h3 = TextStyle(
// //   fontFamily: 'DM Sans',
// //   fontSize: 24,
// //   fontWeight: FontWeight.w500,
// // );
// //
// // static const TextStyle h4 = TextStyle(
// //   fontFamily: 'DM Sans',
// //   fontSize: 21,
// //   fontWeight: FontWeight.w500,
// // );
//
// static const TextStyle h5 = TextStyle(
//   fontFamily: 'DM Sans',
//   fontSize: 18,
//   fontWeight: FontWeight.w500,
// );
//
// static const TextStyle bodyExtraSmall = TextStyle(
//   fontFamily: 'DM Sans',
//   fontSize: 10,
//   fontWeight: FontWeight.w400,
// );
//
// static const TextStyle bodyExtraSmallMedium = TextStyle(
//   fontFamily: 'DM Sans',
//   fontSize: 10,
//   fontWeight: FontWeight.w500,
// );
//
// static const TextStyle bodyExtraSmallBold = TextStyle(
//   fontFamily: 'DM Sans',
//   fontSize: 10,
//   fontWeight: FontWeight.w700,
// );
//
// static const TextStyle bodyExtraSmallSpacedOut = TextStyle(
//   fontFamily: 'DM Sans',
//   fontSize: 10,
//   fontWeight: FontWeight.w400,
//   wordSpacing: 1,
// );
//
// static const TextStyle bodySmall = TextStyle(
//   fontFamily: 'DM Sans',
//   fontSize: 12,
//   fontWeight: FontWeight.w400,
// );
//
// static const TextStyle bodySmallMedium = TextStyle(
//   fontFamily: 'DM Sans',
//   fontSize: 12,
//   fontWeight: FontWeight.w500,
// );
//
// static const TextStyle bodySmallBold = TextStyle(
//   fontFamily: 'DM Sans',
//   fontSize: 12,
//   fontWeight: FontWeight.w700,
// );
//
// static const TextStyle bodySmallSpacedOut = TextStyle(
//   fontFamily: 'DM Sans',
//   fontSize: 12,
//   fontWeight: FontWeight.w400,
//   wordSpacing: 1,
// );
//
// static const TextStyle bodyRegular = TextStyle(
//   fontFamily: 'DM Sans',
//   fontSize: 14,
//   fontWeight: FontWeight.w400,
// );
//
// static const TextStyle bodyRegularMedium = TextStyle(
//   fontFamily: 'DM Sans',
//   fontSize: 14,
//   fontWeight: FontWeight.w500,
// );
//
// static const TextStyle bodyRegularBold = TextStyle(
//   fontFamily: 'DM Sans',
//   fontSize: 14,
//   fontWeight: FontWeight.w700,
// );
//
// static const TextStyle bodyRegularSpacedOut = TextStyle(
//   fontFamily: 'DM Sans',
//   fontSize: 14,
//   fontWeight: FontWeight.w400,
//   wordSpacing: 1,
// );
//
// static const TextStyle bodyLarge = TextStyle(
//   fontFamily: 'DM Sans',
//   fontSize: 16,
//   fontWeight: FontWeight.w400,
// );
//
// static const TextStyle bodyLargeMedium = TextStyle(
//   fontFamily: 'DM Sans',
//   fontSize: 16,
//   fontWeight: FontWeight.w500,
// );
//
// static const TextStyle bodyLargeBold = TextStyle(
//   fontFamily: 'DM Sans',
//   fontSize: 16,
//   fontWeight: FontWeight.w700,
// );
//
// static const TextStyle bodyLargeSpacedOut = TextStyle(
//   fontFamily: 'DM Sans',
//   fontSize: 16,
//   fontWeight: FontWeight.w400,
//   wordSpacing: 1,
// );
//
// static const TextStyle bodyExtraLarge = TextStyle(
//   fontFamily: 'DM Sans',
//   fontSize: 18,
//   fontWeight: FontWeight.w400,
// );
//
// static const TextStyle bodyExtraLargeMedium = TextStyle(
//   fontFamily: 'DM Sans',
//   fontSize: 18,
//   fontWeight: FontWeight.w500,
// );
//
// static const TextStyle bodyExtraLargeBold = TextStyle(
//   fontFamily: 'DM Sans',
//   fontSize: 18,
//   fontWeight: FontWeight.w700,
// );
//
// static const TextStyle bodyExtraLargeSpacedOut = TextStyle(
//   fontFamily: 'DM Sans',
//   fontSize: 18,
//   fontWeight: FontWeight.w400,
//   wordSpacing: 1,
// );
// static const TextStyle largeh3 = TextStyle(
//   fontFamily: 'DM Sans',
//   fontSize: 18,
//   fontWeight: FontWeight.w500,
//   color: RibnColors.defaultText,
// );
// static const TextStyle statusChip = TextStyle(
//   color: RibnColors.defaultText,
//   fontWeight: FontWeight.w500,
//   fontFamily: 'DM Sans',
//   fontSize: 9,
//   decoration: TextDecoration.none,
//   height: 1,
// );
// static const TextStyle linkText = TextStyle(
//   color: RibnColors.secondaryDark,
//   fontWeight: FontWeight.w500,
//   fontFamily: 'DM Sans',
//   fontSize: 18,
//   height: 1.6,
//   decoration: TextDecoration.underline,
// );
}
