import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ribn/constants/assets.dart';
import 'package:ribn/constants/colors.dart';
import 'package:ribn/constants/styles.dart';
import 'package:ribn/widgets/custom_icon_button.dart';

/// Builds a custom [TextField] for inputting password.
///
/// Allows the user to toggle between showing & hiding text.
class PasswordTextField extends StatefulWidget {
  /// Controller for the [TextField].
  final TextEditingController controller;

  /// Hint text to be displayed in the [TextField].
  final String hintText;

  /// True if there is an error in the [TextField].
  final bool hasError;

  /// The width of the [TextField].
  final double width;

  /// The height of the [TextField].
  final double height;

  const PasswordTextField({
    required this.controller,
    required this.hintText,
    this.hasError = false,
    this.width = 310,
    this.height = 35,
    Key? key,
  }) : super(key: key);

  @override
  _PasswordTextFieldState createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: TextField(
        obscureText: _obscurePassword,
        controller: widget.controller,
        decoration: InputDecoration(
          suffixIcon: CustomIconButton(
            icon: SvgPicture.asset(
              _obscurePassword ? RibnAssets.passwordVisibleIon : RibnAssets.passwordHiddenIcon,
              width: 20,
            ),
            onPressed: () {
              setState(() {
                _obscurePassword = !_obscurePassword;
              });
            },
          ),
          labelText: widget.hintText,
          labelStyle: RibnTextStyles.hintStyle,
          isDense: true,
          fillColor: Colors.white,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          filled: true,
          contentPadding: const EdgeInsets.all(20),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: widget.hasError ? Colors.red : Colors.black),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: widget.hasError ? Colors.red : RibnColors.primary),
          ),
        ),
      ),
    );
  }
}
