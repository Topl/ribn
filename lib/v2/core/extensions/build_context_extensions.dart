// Flutter imports:
import 'package:flutter/material.dart';

extension BuildContextExtensions on BuildContext {
  /// Closes the current screen or dialog.
  ///
  /// Example:
  /// ```
  /// context.close();
  /// ```
  void close() {
    Navigator.pop(this);
  }

  /// Shows a snack-bar at the bottom of the screen with the given message.
  ///
  /// Example:
  /// ```
  /// context.showSnackBar('Hello, world!');
  /// ```
  void showSnackBar(String message) {
    assert(message != null, 'A non-null message must be provided.');
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }

  /// Shows an alert dialog with the given title, message, and actions.
  ///
  /// Example:
  /// ```
  /// context.showAlertDialog(
  ///   'Confirmation',
  ///   'Are you sure you want to delete this item?',
  ///   [
  ///     TextButton(
  ///       child: Text('Cancel'),
  ///       onPressed: () => context.close(),
  ///     ),
  ///     TextButton(
  ///       child: Text('Delete'),
  ///       onPressed: () => _deleteItem(),
  ///     ),
  ///   ],
  /// );
  /// ```
  Future<void> showAlertDialog(String title, String message, List<Widget> actions) async {
    assert(actions.isNotEmpty, 'At least one action must be provided.');
    await showDialog<void>(
      context: this,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: actions,
        );
      },
    );
  }

  /// Navigates to a new screen and removes the current screen from the stack.
  ///
  /// Example:
  /// ```
  /// context.pushReplacementNamed('/login');
  /// ```
  void pushReplacementNamed(String routeName) {
    Navigator.of(this).pushReplacementNamed(routeName);
  }

  /// Shows a loading dialog with a centered circular progress indicator.
  ///
  /// Example:
  /// ```
  /// context.showLoadingDialog();
  /// ```
  void showLoadingDialog() {
    showDialog<void>(
      context: this,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
