import 'package:flutter/material.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn_toolkit/constants/styles.dart';

/// The section on the settings page that allows user to delete their wallet.
class DeleteWalletSection extends StatelessWidget {
  /// Handler for when user confirms wallet deletion.
  final Function(BuildContext context) onDeletePressed;

  const DeleteWalletSection({
    required this.onDeletePressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          Strings.dangerZone,
          style: TextStyle(
            fontFamily: 'Spectral',
            fontWeight: FontWeight.w700,
            fontSize: 16,
            color: Color(0xFFE80E00),
          ),
        ),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: const Color(0xffE80E00).withOpacity(0.09),
          ),
          width: 291,
          height: 67,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  Strings.actionNotReversible,
                  style: RibnToolkitTextStyles.settingsSmallText,
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: 107,
                  height: 22,
                  child: OutlinedButton(
                    onPressed: () => onDeletePressed(context),
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.zero,
                      side: const BorderSide(
                        color: Color(0xFF585858),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                    ),
                    child: const Text(
                      Strings.deleteWallet,
                      style: TextStyle(
                        fontSize: 10.45,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Nunito',
                        color: Color(0xFf585858),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
