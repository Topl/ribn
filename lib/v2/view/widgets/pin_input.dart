// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:pinput/pinput.dart';
// Project imports:
import 'package:ribn/v2/core/constants/colors.dart';
import 'package:ribn/v2/core/constants/ribn_text_style.dart';

/// Renders a pin input field with a fixed length according to [Ribn] style.
///
/// @required [length] - The length of the PIN.
///
/// @required [isPinValid] - The [ValueNotifier] used to determine the state of the PIN.
///
/// @optional [controller] - The [TextEditingController] used to control the input.
///
/// @optional [validator] - The validator function used to validate the PIN.
///
/// @optional [onCompleted] - The callback function called when the PIN is completed.
///
/// @optional [focusNode] - The [FocusNode] used to control the focus of the PIN input.
///
/// The default style of the PIN input is defined by [defaultPinTheme], and the focused style is defined by
/// [focusedPinTheme]. When the PIN is submitted, the submitted style is determined by [submittedPinTheme], which
/// defaults to [defaultPinTheme] unless [isPinValid] is true, in which case [validStateTheme] is used. The error
/// style is defined by [errorPinTheme]. The error text style is defined by [errorTextStyle].
///
/// It should be noted that the [Pinput] widget doesn't support a standard successStateTheme out of the box,
/// so the [ValueNotifier] for success state needs to be implemented and managed outside of this widget.
///
/// /// @throws [AssertionError] if [length] is not a positive integer.
///
/// Example Usage:
/// ```dart
/// PinInput(
///   length: 6,
///   controller: TextEditingController(),
///   isPinValid: pinIsValid,
///   validator: (pin) {
///     if (pin!.length != 6) {
///       return 'Please enter a 6-digit PIN.';
///     }
///     return null;
///   },
/// );
/// ```
///
class PinInput extends StatelessWidget {
  const PinInput(
      {Key? key,
      required this.isPinValid,
      required this.length,
      this.validator,
      this.controller,
      this.onCompleted,
      this.focusNode})
      : assert(length > 0, 'Length must be a positive integer.'),
        super(key: key);

  /// The [TextEditingController] for managing the text input of the PIN.
  final TextEditingController? controller;

  /// The [FocusNode] for granular handling of the focus of the PIN input.
  final FocusNode? focusNode;

  /// A [ValueNotifier] that indicates whether the entered PIN is valid and is used for managing the success state.
  final ValueNotifier<bool> isPinValid;

  /// The length of the PIN.
  final int length;

  /// An optional [String? Function(String?)] validator function to validate the PIN input.
  final String? Function(String?)? validator;

  /// The optional [String? Function(String?)] function that is called when the input is complete.
  final void Function(String)? onCompleted;

  @override
  Widget build(BuildContext context) {
    /// The default style of the PIN input.
    final defaultPinTheme = PinTheme(
      width: 48,
      height: 48,
      // textStyle: TextStyle(fontSize: 20, color: Color.fromRGBO(30, 60, 87, 1), fontWeight: FontWeight.w600),
      textStyle: RibnTextStyle.h3,
      decoration: BoxDecoration(
        border: Border.all(color: RibnColors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
    );

    /// The focused style of the PIN input.
    final focusedPinTheme = defaultPinTheme.copyDecorationWith(border: Border.all(color: RibnColors.primary));

    /// The style of the PIN input when submitted. Defaults to [defaultPinTheme], unless [isPinValid] is true,
    /// in which case [validStateTheme] is used.
    final validStateTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(border: Border.all(color: RibnColors.success)),
    );

    /// The error style of the PIN input.
    final errorPinTheme = defaultPinTheme.copyWith(
        decoration: defaultPinTheme.decoration?.copyWith(border: Border.all(color: RibnColors.error)));

    /// The error text style of the PIN input.
    final errorTextStyle = RibnTextStyle.h3.copyWith(color: RibnColors.error);

    return Pinput(
      length: length,
      controller: controller,
      pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
      closeKeyboardWhenCompleted: false,
      validator: validator,
      onCompleted: onCompleted,
      onSubmitted: onCompleted,
      autofocus: true,
      focusNode: focusNode,
      // Theming
      defaultPinTheme: defaultPinTheme,
      focusedPinTheme: focusedPinTheme,
      submittedPinTheme: isPinValid.value ? validStateTheme : defaultPinTheme,
      errorPinTheme: errorPinTheme,
      errorTextStyle: errorTextStyle,
    );
  }
}
