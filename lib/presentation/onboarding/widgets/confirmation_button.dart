import 'package:flutter/material.dart';
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn_toolkit/constants/styles.dart';
import 'package:ribn_toolkit/widgets/atoms/large_button.dart';

class ConfirmationButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool disabled;
  final double height;
  final double width;
  const ConfirmationButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.disabled = false,
    this.height = 50,
    this.width = 350,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: LargeButton(
        buttonWidth: width,
        buttonHeight: height,
        backgroundColor: RibnColors.primary,
        dropShadowColor: RibnColors.whiteButtonShadow,
        buttonChild: Text(
          text,
          style: RibnToolkitTextStyles.btnLarge.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w400,
          ),
        ),
        onPressed: onPressed,
        disabled: disabled,
      ),
    );
  }
}
