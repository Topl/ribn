import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

ThemeData lightTheme({
  required BuildContext context,
}) {
  final isMobile = ResponsiveBreakpoints.of(context).equals(MOBILE);

  const Color textColor = Color(0xFF282A2C);
  const Color textColor2 = Color(0xFF000000);
  const Color altTextColor = Color(0xFF858E8E);
  const Color altTextColor2 = Color(0xFF535757);
  const Color backgroundColor = Color(0xFFFEFEFE);

  return ThemeData().copyWith(
    scaffoldBackgroundColor: backgroundColor,

    /// Add new colors to extensions to access them in the app
    extensions: [
      const MyColors(
        textColor: textColor,
        textColor2: textColor2,
        altTextColor: altTextColor,
        altTextColor2: altTextColor2,
        backgroundColor: backgroundColor,
      ),
    ],
    textTheme: _textTheme(
      isMobile: isMobile,
      textColor: textColor,
      textColor2: textColor2,
      altTextColor: altTextColor,
      altTextColor2: altTextColor2,
    ),
  );
}

ThemeData darkTheme({
  required BuildContext context,
}) {
  final isMobile = ResponsiveBreakpoints.of(context).equals(MOBILE);

  const Color textColor = Color(0xFFFEFEFE);
  const Color textColor2 = Color(0xFFF5F5F5);
  const Color altTextColor = Color(0xFFC0C4C4);
  const Color altTextColor2 = Color(0xFFC0C4C4);
  const Color backgroundColor = Color(0xFF282A2C);

  return ThemeData.dark().copyWith(
    scaffoldBackgroundColor: backgroundColor,
    extensions: [
      const MyColors(
        textColor: textColor,
        textColor2: textColor2,
        altTextColor: altTextColor,
        altTextColor2: altTextColor2,
        backgroundColor: backgroundColor,
      ),
    ],
    textTheme: _textTheme(
      isMobile: isMobile,
      textColor: textColor,
      textColor2: textColor2,
      altTextColor: altTextColor,
      altTextColor2: altTextColor2,
    ),
  );
}

/// Abstracting text theme for reusability between light and dark themes
TextTheme _textTheme({
  required bool isMobile,
  required Color textColor,
  required Color textColor2,
  required Color altTextColor,
  required Color altTextColor2,
}) {
  return ThemeData().textTheme.copyWith(
        /// Headline
        headlineLarge: TextStyle(
          fontSize: isMobile ? 18 : 30,
          fontWeight: FontWeight.w600,
          color: textColor,
          fontFamily: "Rational Display",
        ),

        /// Title
        titleLarge: TextStyle(
          color: textColor2,
          fontWeight: FontWeight.w600,
          fontSize: 24,
          fontFamily: "Rational Display",
        ),
        titleMedium: TextStyle(
          color: altTextColor,
          fontSize: 16,
          fontFamily: "Rational Display",
        ),
        titleSmall: TextStyle(
          color: textColor,
          fontWeight: FontWeight.w500,
          fontSize: 16,
          fontFamily: 'Rational Display Medium',
          fontStyle: FontStyle.normal,
        ),

        /// Label
        labelLarge: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.w600,
          color: altTextColor,
          fontFamily: "Rational Display",
        ),

        /// Body
        bodyMedium: TextStyle(
          fontSize: 16,
          color: altTextColor2,
          fontWeight: FontWeight.w300,
          fontFamily: "Rational Display",
        ),
        bodySmall: TextStyle(
          color: altTextColor,
          fontWeight: FontWeight.w400,
          fontSize: 10,
          fontFamily: 'Rational Display Light',
          fontStyle: FontStyle.normal,
        ),
      );
}

/// Returns [Theme.of(context).textTheme.headlineLarge]
TextStyle? headlineLarge(BuildContext context) {
  return Theme.of(context).textTheme.headlineLarge;
}

/// Returns [Theme.of(context).textTheme.titleLarge]
TextStyle? titleLarge(BuildContext context) {
  return Theme.of(context).textTheme.titleLarge;
}

/// Returns [Theme.of(context).textTheme.titleMedium]
TextStyle? titleMedium(BuildContext context) {
  return Theme.of(context).textTheme.titleMedium;
}

/// Returns [Theme.of(context).textTheme.titleSmall]
TextStyle? titleSmall(BuildContext context) {
  return Theme.of(context).textTheme.titleSmall;
}

/// Returns [Theme.of(context).textTheme.labelLarge]
TextStyle? labelLarge(BuildContext context) {
  return Theme.of(context).textTheme.labelLarge;
}

/// Returns [Theme.of(context).textTheme.bodyMedium]
TextStyle? bodyMedium(BuildContext context) {
  return Theme.of(context).textTheme.bodyMedium;
}

/// Returns [Theme.of(context).textTheme.bodySmall]
TextStyle? bodySmall(BuildContext context) {
  return Theme.of(context).textTheme.bodySmall;
}

/// Returns [Theme.of(context).extension<MyColors>()!]
MyColors myColors(BuildContext context) {
  return Theme.of(context).extension<MyColors>()!;
}

@immutable
class MyColors extends ThemeExtension<MyColors> {
  const MyColors({
    required this.textColor,
    required this.textColor2,
    required this.altTextColor,
    required this.altTextColor2,
    required this.backgroundColor,
  });

  final Color textColor;
  final Color textColor2;
  final Color altTextColor;
  final Color altTextColor2;
  final Color backgroundColor;

  @override
  MyColors copyWith({Color? brandColor, Color? danger}) {
    return MyColors(
      textColor: textColor,
      textColor2: textColor2,
      altTextColor: altTextColor,
      altTextColor2: altTextColor2,
      backgroundColor: backgroundColor,
    );
  }

  @override
  MyColors lerp(MyColors? other, double t) {
    if (other is! MyColors) {
      return this;
    }
    return MyColors(
      textColor: Color.lerp(textColor, other.textColor, t)!,
      textColor2: Color.lerp(textColor2, other.textColor2, t)!,
      altTextColor: Color.lerp(altTextColor, other.altTextColor, t)!,
      altTextColor2: Color.lerp(altTextColor2, other.altTextColor2, t)!,
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t)!,
    );
  }

  // Optional
  @override
  String toString() =>
      'MyColors(textColor: $textColor, textColor2: $textColor2, altTextColor: $altTextColor, altTextColor2: $altTextColor2, backgroundColor: $backgroundColor)';
}
