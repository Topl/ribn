import 'package:flutter/material.dart';
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn_toolkit/constants/styles.dart';

/// A custom styled large button used on several screens, e.g. login, asset transfer, and mint screens.
class LargeButton extends StatelessWidget {
  const LargeButton({
    required this.label,
    required this.onPressed,
    this.backgroundColor = RibnColors.primary,
    this.textColor = Colors.white,
    this.buttonWidth = 310,
    this.buttonHeight = 43,
    Key? key,
  }) : super(key: key);
  final String label;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color textColor;
  final double buttonWidth;
  final double buttonHeight;
  final double borderRadius = 2.2;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: buttonWidth,
      height: buttonHeight,
      child: MaterialButton(
        elevation: 0,
        color: backgroundColor,
        child: Text(
          label,
          style: RibnToolkitTextStyles.btnMedium.copyWith(
            color: textColor,
          ),
        ),
        onPressed: onPressed,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            borderRadius,
          ),
        ),
      ),
    );
  }
}
