// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn_toolkit/constants/styles.dart';
import 'package:ribn_toolkit/widgets/atoms/large_button.dart';
import 'package:ribn_toolkit/widgets/molecules/ribn_custom_modal.dart';
import 'package:ribn_toolkit/widgets/organisms/ribn_disconnect_app_container.dart';

// Project imports:
import 'package:ribn/constants/strings.dart';
import 'package:ribn/platform/platform.dart';

// Project imports:
import 'package:ribn/constants/strings.dart';
import 'package:ribn/platform/platform.dart';

/// The confirmation dialog that is displayed before disconnecting the wallet.
class DisconnectWalletConfirmationDialog extends StatefulWidget {
  const DisconnectWalletConfirmationDialog({Key? key, required this.dApps})
      : super(key: key);

  final List<String> dApps;

  @override
  _DisconnectWalletConfirmationDialogState createState() =>
      _DisconnectWalletConfirmationDialogState();
}

class _DisconnectWalletConfirmationDialogState
    extends State<DisconnectWalletConfirmationDialog> {
  @override
  Widget build(BuildContext context) {
    return RibnCustomModal.renderRibnCustomModal(
      width: 227,
      height: 250,
      title: Text(
        Strings.disconnectRibnWalletDApps,
        style: RibnToolkitTextStyles.extH2.copyWith(fontSize: 18),
        textAlign: TextAlign.center,
      ),
      context: context,
      body: Column(
        children: [
          Text(
            Strings.disconnectRibnWalletDAppsDesc,
            style: RibnToolkitTextStyles.smallBody.copyWith(fontSize: 12),
          ),
          const SizedBox(
            height: 10,
          ),
          RibnDisconnectDAppContainer(
            width: 227,
            dapps: widget.dApps,
          ),
          const SizedBox(height: 10),
        ],
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        Column(
          children: [
            // confirm disconnect
            LargeButton(
              buttonChild: Text(
                Strings.yesIWantToDisconnect,
                style: RibnToolkitTextStyles.btnMedium
                    .copyWith(color: Colors.white, fontSize: 10),
              ),
              onPressed: () async {
                // Disconnect action to go here
                await PlatformUtils.instance
                    .convertToFuture(PlatformUtils.instance.clearDAppList());
                Navigator.of(context, rootNavigator: true).pop(true);
              },
              buttonWidth: 227,
            ),
            const SizedBox(height: 15),
            // cancel disconnect
            LargeButton(
              buttonChild: Text(
                Strings.noIChangedMyMind,
                style: RibnToolkitTextStyles.btnMedium
                    .copyWith(color: RibnColors.ghostButtonText, fontSize: 10),
              ),
              backgroundColor: Colors.transparent,
              hoverColor: Colors.transparent,
              dropShadowColor: Colors.transparent,
              borderColor: RibnColors.ghostButtonText,
              onPressed: () {
                // Cancel action to go here
                Navigator.of(context, rootNavigator: true).pop(false);
              },
              buttonWidth: 227,
            ),
          ],
        )
      ],
    );
  }
}
