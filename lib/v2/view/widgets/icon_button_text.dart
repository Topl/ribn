import 'package:flutter/material.dart';

/// A widget that displays an icon button with text next to it.
///
/// This widget is built using a [Row] that contains an [Icon] followed by a
/// [Text] widget. The [InkWell] widget is used to make the entire row clickable
/// and responsive to user input.
///
/// Example usage:
///
/// ```dart
/// IconButtonText(
///   icon: Icons.add,
///   text: 'Add Item',
///   onPressed: () {
///     // Add item functionality
///   },
///   textStyle: TextStyle(fontSize: 18),
///   semanticLabel: 'Add Item button',
/// )
/// ```
class IconButtonText extends StatelessWidget {
  /// The icon to display in the widget.
  final IconData icon;

  /// The text to display next to the icon.
  final String text;

  /// The function to call when the widget is pressed.
  final Function()? onPressed;

  /// The style to apply to the text.
  final TextStyle? textStyle;

  /// A textual description of the icon for accessibility purposes.
  final String? semanticLabel;

  /// Creates an [IconButtonText] widget.
  ///
  /// The [icon] and [text] parameters are required. The [onPressed] parameter is
  /// optional and is called when the user presses the widget. The [textStyle] and
  /// [semanticLabel] parameters are also optional and provide additional styling
  /// and accessibility options.
  const IconButtonText({
    required this.icon,
    required this.text,
    this.onPressed,
    this.textStyle,
    this.semanticLabel,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, semanticLabel: semanticLabel),
          SizedBox(width: 8),
          Text(text, style: textStyle),
        ],
      ),
    );
  }
}
