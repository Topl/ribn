import 'package:flutter/material.dart';
import 'package:ribn/presentation/error_section.dart';
import 'package:ribn_toolkit/constants/colors.dart';

class TransferUtils {
  TransferUtils._();

  /// Opens an error dialog, e.g. when creating raw tx fails.
  static Future<void> showErrorDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
        backgroundColor: const Color(0xffD0DFE1),
        title: ErrorSection(onTryAgain: () => Navigator.of(context).pop()),
      ),
    );
  }

  /// Returns true if [amount] is valid.
  static bool validateAmount(String amount, maxAmount) {
    return (int.tryParse(amount) ?? 0) <= maxAmount;
  }
}
