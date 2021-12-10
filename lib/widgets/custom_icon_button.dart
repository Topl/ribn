import 'package:flutter/material.dart';

/// A custom syled icon button.
class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    required this.icon,
    required this.onPressed,
    this.color = Colors.transparent,
    this.height = 26,
    this.width = 26,
    this.radius = 20,
    this.hoverColor,
    this.highlightColor,
    this.focusColor,
    this.splashColor,
    Key? key,
  }) : super(key: key);
  final VoidCallback onPressed;
  final Widget icon;
  final Color color;
  final Color? hoverColor;
  final Color? focusColor;
  final Color? highlightColor;
  final Color? splashColor;
  final double height;
  final double width;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: MaterialButton(
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
        elevation: 0,
        hoverElevation: 0,
        highlightElevation: 0,
        color: color,
        child: icon,
        onPressed: onPressed,
        hoverColor: hoverColor ?? Theme.of(context).hoverColor,
        highlightColor: highlightColor ?? Theme.of(context).highlightColor,
        splashColor: splashColor ?? Theme.of(context).splashColor,
      ),
    );
  }
}
