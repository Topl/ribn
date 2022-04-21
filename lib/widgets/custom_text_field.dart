import 'package:flutter/material.dart';
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn_toolkit/constants/styles.dart';

class CustomTextField extends StatelessWidget {
  /// Controller for the textfield.
  final TextEditingController controller;

  /// Hint text to display when text is empty
  final String hintText;

  /// Width of the textfield box
  final double width;

  /// Height of the textfield box
  final double height;

  /// Max length of text allowed in the textfield
  final int? maxLength;

  /// True if cursor should be displayed
  final bool? showCursor;

  /// Vertical alignment of the text inside the textfield
  final TextAlignVertical? textAlignVertical;

  /// CallBack function for whenever the text changes
  final Function(String)? onChanged;

  /// True if the textfield has an error
  final bool hasError;

  const CustomTextField({
    required this.controller,
    required this.hintText,
    this.width = 310,
    this.height = 30,
    this.maxLength,
    this.textAlignVertical,
    this.onChanged,
    this.showCursor = true,
    this.hasError = false,
    Key? key,
  }) : super(key: key);

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
        textAlignVertical: textAlignVertical,
        onChanged: onChanged,
        expands: true,
        maxLines: null,
        maxLength: maxLength,
        showCursor: showCursor,
        decoration: InputDecoration(
          isDense: true,
          counterText: '',
          hintText: hintText,
          hintStyle: RibnToolkitTextStyles.hintStyle,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.7),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: hasError ? Colors.red : Colors.transparent),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: hasError ? Colors.red : RibnColors.primary),
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
