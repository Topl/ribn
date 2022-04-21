import 'package:flutter/material.dart';
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn_toolkit/constants/styles.dart';

/// A custom button being used on several onboarding pages.
class ContinueButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool disabled;
  final double buttonWidth = 234;
  final double buttonHeight = 46;
  final double buttonRadius = 4;
  const ContinueButton(
    this.label,
    this.onPressed, {
    this.disabled = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(buttonRadius),
        side: BorderSide(
          color: disabled ? RibnColors.inactive : RibnColors.primary,
        ),
      ),
      minWidth: buttonWidth,
      height: buttonHeight,
      color: RibnColors.primary,
      disabledColor: Colors.transparent,
      child: Text(
        label,
        style: RibnToolkitTextStyles.h3.copyWith(color: disabled ? RibnColors.inactive : Colors.white),
      ),
      onPressed: disabled ? null : onPressed,
    );
  }
}
