import 'package:flutter/material.dart';
import 'package:ribn/constants/colors.dart';
import 'package:ribn/constants/styles.dart';

/// A custom styled [TextField] that is used on several pages inside Ribn.
class CustomTextField extends StatelessWidget {
  const CustomTextField({
    required this.controller,
    required this.hintText,
    this.width = 309,
    this.height = 30,
    Key? key,
  }) : super(key: key);
  final TextEditingController controller;
  final String hintText;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: TextField(
        controller: controller,
        style: const TextStyle(
          fontFamily: 'Nunito',
          fontSize: 12,
          color: RibnColors.defaultText,
        ),
        expands: true,
        maxLines: null,
        decoration: InputDecoration(
          isDense: true,
          counterText: '',
          hintText: hintText,
          hintStyle: RibnTextStyles.hintStyle,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.7),
          ),
          filled: true,
          contentPadding: const EdgeInsets.all(5),
          fillColor: RibnColors.whiteBackground,
          floatingLabelBehavior: FloatingLabelBehavior.never,
        ),
      ),
    );
  }
}
