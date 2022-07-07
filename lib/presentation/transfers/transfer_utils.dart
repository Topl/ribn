import 'package:flutter/material.dart';
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn/presentation/error_section.dart';

class TransferUtils {
  TransferUtils._();

  /// Opens an error dialog, e.g. when creating raw tx fails.
  static Future<void> showErrorDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 48),
        backgroundColor: RibnColors.accent,
        title: ErrorSection(onTryAgain: () => Navigator.of(context).pop()),
      ),
    );
  }

  /// Returns true if [amount] is valid.
  static bool validateAmount(String amount, maxAmount) {
    return (int.tryParse(amount) ?? 0) <= maxAmount;
  }
}
