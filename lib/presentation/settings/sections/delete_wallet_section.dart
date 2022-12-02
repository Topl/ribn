import 'package:flutter/material.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn_toolkit/constants/styles.dart';
import 'package:ribn_toolkit/widgets/atoms/large_button.dart';

/// The section on the settings page that allows user to delete their wallet.
class DeleteWalletSection extends StatelessWidget {
  /// Handler for when user confirms wallet deletion.
  final Function(BuildContext context) onDeletePressed;

  final Function(BuildContext context) onDisconnectPressed;

  final bool canDisconnect;

  const DeleteWalletSection({
    required this.onDeletePressed,
    required this.onDisconnectPressed,
    required this.canDisconnect,
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
            fontFamily: 'DM Sans',
            fontWeight: FontWeight.w700,
            fontSize: 16,
            color: Color(0xFFE80E00),
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          Strings.actionNotReversible,
          style: RibnToolkitTextStyles.settingsSmallText,
        ),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: RibnColors.paleGrey,
          ),
          width: 291,
          height: 67,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  Strings.disconnectDApps,
                  style: RibnToolkitTextStyles.settingsSmallText,
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: 107,
                  height: 22,
                  child: LargeButton(
                    buttonChild: Text(
                      Strings.disconnect,
                      style: RibnToolkitTextStyles.btnLarge.copyWith(
                        color: RibnColors.primary.withOpacity(canDisconnect == true ? 1.0 : 0.3),
                        fontSize: 10,
                      ),
                    ),
                    backgroundColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    dropShadowColor: Colors.transparent,
                    borderColor: RibnColors.primary.withOpacity(canDisconnect == true ? 1.0 : 0.3),
                    onPressed: () => canDisconnect ?
                      onDisconnectPressed(context) : null,),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
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
                  Strings.removeWallet,
                  style: RibnToolkitTextStyles.settingsSmallText,
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: 107,
                  height: 22,
                  child: LargeButton(
                    buttonChild: Text(
                      Strings.delete,
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
