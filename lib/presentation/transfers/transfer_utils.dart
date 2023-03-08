// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:ribn/presentation/error_section.dart';

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
        title: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                child: const Icon(Icons.close),
                onTap: () => Navigator.of(context).pop(),
              ),
            ),
            ErrorSection(onTryAgain: () => Navigator.of(context).pop()),
          ],
        ),
      ),
    );
  }

  /// Returns true if [amount] is valid.
  static bool validateAmount(int amount, maxAmount) {
    try {
      return amount <= maxAmount;
    } catch (e) {
      return false;
    }
  }

  /// Gets a valid address from
}
