import 'package:flutter/material.dart';
import 'package:ribn/v2/core/constants/ribn_text_style.dart';

class SelectableTextButton extends StatelessWidget {
  final Function()? onPressed;
  final String text;
  final bool isSelected;
  const SelectableTextButton({
    required this.onPressed,
    required this.text,
    this.isSelected = true,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: RibnTextStyle.h3.copyWith(
          color: isSelected ? Colors.black : Colors.grey,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
}
