import 'package:flutter/material.dart';
import 'package:ribn/constants/colors.dart';
import 'package:ribn/constants/styles.dart';

/// A custom styled large button used on several screens, e.g. login, asset transfer, and mint screens.
class LargeButton extends StatelessWidget {
  const LargeButton({
    required this.label,
    required this.onPressed,
    this.backgroundColor = RibnColors.primary,
    this.textColor = Colors.white,
    Key? key,
  }) : super(key: key);
  final String label;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color textColor;
  final double buttonWidth = 310;
  final double buttonHeight = 43;
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
          style: RibnTextStyles.btnMedium.copyWith(
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
