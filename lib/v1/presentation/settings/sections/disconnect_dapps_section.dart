// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn_toolkit/constants/styles.dart';
import 'package:ribn_toolkit/widgets/atoms/large_button.dart';

// Project imports:
import 'package:ribn/v1/constants/strings.dart';

/// The section on the settings page that allows user to delete their wallet.
class DisconnectDAppsSection extends StatelessWidget {
  /// Handler for when user confirms wallet deletion.

  final Function(BuildContext context) onDisconnectPressed;

  final bool canDisconnect;

  const DisconnectDAppsSection({
    required this.onDisconnectPressed,
    required this.canDisconnect,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: RibnColors.paleGrey,
      ),
      height: 67,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              Strings.disconnectDApps,
              style: RibnToolkitTextStyles.settingsSmallText,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Container(
                constraints: BoxConstraints(maxWidth: 30, maxHeight: 22),
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
                  onPressed: () => canDisconnect ? onDisconnectPressed(context) : null,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
