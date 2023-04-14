import 'package:flutter/material.dart';

void showToast({
  required BuildContext context,
  required String message,
}) {
  final scaffold = ScaffoldMessenger.of(context);
  scaffold.showSnackBar(
    SnackBar(
      content: Text(message),
    ),
  );
}
