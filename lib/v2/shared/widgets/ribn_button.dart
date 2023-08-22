// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:ribn/v2/shared/constants/colors.dart';
import 'package:ribn/v2/shared/constants/ribn_text_style.dart';

/// The primary styled button used for [Ribn]
///
/// The button displays [text] and triggers the [onPressed] callback
/// when tapped. The button can be disabled by setting the [disabled]
/// flag to `true`.
///
/// @throws [AssertionError] if [height] or [width] is not a positive integer.
class RibnButton extends StatelessWidget {
  const RibnButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.disabled = false,
    this.height = 50,
    this.width = 350,
  })  : assert(height > 0, 'Height must be greater than 0'),
        assert(width > 0, 'Width must be greater than 0'),
        super(key: key);

  /// The text displayed on the button.
  final String text;

  /// The callback function that is called when the button is pressed.
  final VoidCallback onPressed;

  /// Flag indicating whether the button is disabled.
  final bool disabled;

  /// The height of the button.
  final double height;

  /// The width of the button.
  final double width;

  @override
  Widget build(BuildContext context) {
    return LargeButton(
      customDisabledColor: RibnColors.transparentPrimary,
      buttonWidth: width,
      buttonHeight: height,
      backgroundColor: RibnColors.secondary,
      dropShadowColor: RibnColors.whiteButtonShadow,
      buttonChild: Text(
        text,
        style: RibnTextStyle.buttonMedium.copyWith(
          color: disabled ? RibnColors.transparentGreyText : Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
      onPressed: onPressed,
      disabled: disabled,
    );
  }
}

/// A custom styled large button used on several screens, e.g. login, asset transfer, and mint screens.
class LargeButton extends StatelessWidget {
  const LargeButton({
    required this.buttonChild,
    required this.onPressed,
    this.backgroundColor = RibnColors.primary,
    this.hoverColor = RibnColors.primaryButtonHover,
    this.dropShadowColor = RibnColors.primaryButtonShadow,
    this.borderColor = Colors.transparent,
    this.buttonWidth = 310,
    this.buttonHeight = 43,
    this.disabled = false,
    this.customDisabledColor = RibnColors.inactive,
    Key? key,
  }) : super(key: key);
  final dynamic buttonChild;
  final VoidCallback? onPressed;
  final Color backgroundColor;
  final Color hoverColor;
  final Color dropShadowColor;
  final Color borderColor;
  final double buttonWidth;
  final double buttonHeight;
  final double borderRadius = 16;
  final bool disabled;
  final Color customDisabledColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: buttonWidth,
      height: buttonHeight,
      decoration: disabled
          ? null
          : BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: dropShadowColor,
                  spreadRadius: 0,
                  blurRadius: 22,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
      child: MaterialButton(
        elevation: 0,
        hoverElevation: 0,
        color: disabled ? RibnColors.inactive : backgroundColor,
        child: buttonChild,
        onPressed: disabled ? null : onPressed,
        disabledColor: customDisabledColor,
        hoverColor: disabled ? null : hoverColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            borderRadius,
          ),
          side: BorderSide(
            color: disabled ? Colors.transparent : borderColor,
          ),
        ),
      ),
    );
  }
}
