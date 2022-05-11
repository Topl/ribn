import 'package:flutter/material.dart';
import 'package:ribn_toolkit/widgets/atoms/custom_icon_button.dart';

/// A custom styled close button.
///
/// Used for closing pages, modals, tooltips, etc.
class CustomCloseButton extends StatelessWidget {
  /// Callback for when the button is pressed.
  final Function? onPressed;

  /// Optional icon size for the [Icons.close] icon.
  final double? iconSize;
  const CustomCloseButton({
    Key? key,
    this.onPressed,
    this.iconSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomIconButton(
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onPressed: () => onPressed != null ? onPressed!() : Navigator.of(context).pop(),
      icon: Icon(
        Icons.close,
        size: iconSize,
        color: const Color(0xffb9b9b9),
      ),
    );
  }
}
