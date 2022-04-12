import 'package:flutter/material.dart';

/// A custom divider used to separate items in a list.
class CustomDivider extends StatelessWidget {
  const CustomDivider({this.width = 270, Key? key}) : super(key: key);
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      width: width,
      color: const Color(0xffe9e9e9),
    );
  }
}
