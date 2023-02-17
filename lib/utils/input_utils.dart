import 'package:flutter/widgets.dart';

/// Dismisses the keyboard
void dismissKeyboard(BuildContext context) {
  FocusScopeNode currentFocus = FocusScope.of(context);
  if (!currentFocus.hasPrimaryFocus) currentFocus.unfocus();
}
