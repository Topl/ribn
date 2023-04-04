// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn_toolkit/constants/styles.dart';
import 'package:ribn_toolkit/widgets/atoms/large_button.dart';

// Project imports:
import 'package:ribn/v1/constants/strings.dart';

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
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: const Color(0xffE80E00).withOpacity(0.09),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  Strings.removeWallet,
                  style: RibnToolkitTextStyles.settingsSmallText,
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: 107,
                  height: 22,
                  child: LargeButton(
                    buttonChild: Text(
                      Strings.remove,
                      style: RibnToolkitTextStyles.btnLarge.copyWith(
                        color: RibnColors.primary,
                        fontSize: 10,
                      ),
                    ),
                    backgroundColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    dropShadowColor: Colors.transparent,
                    borderColor: RibnColors.primary,
                    onPressed: () {
                      onDeletePressed(context);
                    },
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
