import 'package:flutter/material.dart';
import 'package:ribn/widgets/custom_icon_button.dart';

/// A custom styled exit button.
class CustomCloseButton extends StatelessWidget {
  const CustomCloseButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomIconButton(
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onPressed: () => Navigator.of(context).pop(),
      icon: const Icon(
        Icons.close,
        color: Color(0xffb9b9b9),
      ),
    );
  }
}
