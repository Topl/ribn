import 'package:flutter/material.dart';
import 'package:ribn/constants/colors.dart';

/// A custom button being used on several onboarding pages.
class ContinueButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool disabled;
  final double buttonWidth = 234;
  final double buttonHeight = 46;
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
        borderRadius: BorderRadius.circular(4),
        side: BorderSide(
          color: disabled ? RibnColors.inactive : RibnColors.primary,
        ),
      ),
      minWidth: buttonWidth,
      height: buttonHeight,
      color: RibnColors.primary,
      disabledColor: Colors.transparent,
      disabledTextColor: RibnColors.inactive,
      textColor: Colors.white,
      child: Text(label),
      onPressed: disabled ? null : onPressed,
    );
  }
}
