import 'package:flutter/material.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn_toolkit/constants/styles.dart';
import 'package:ribn_toolkit/widgets/atoms/large_button.dart';
import 'package:ribn_toolkit/widgets/molecules/custom_modal.dart';

/// The confimation dialog that is displayed before disconnecting the wallet.
class DisconnectWalletConfirmationDialog extends StatefulWidget {
  const DisconnectWalletConfirmationDialog({Key? key}) : super(key: key);

  @override
  _DisconnectWalletConfirmationDialogState createState() => _DisconnectWalletConfirmationDialogState();
}

class _DisconnectWalletConfirmationDialogState extends State<DisconnectWalletConfirmationDialog> {
  final List<String> mockConnectedDApps = [
    'https://greenswap.com',
    'https://happymint.com',
    'https://carbonnegativeNFTs.com',
    'https://REFIkingdoms.com',
    'https://REFIkingdoms.com',
    'https://REFIkingdoms.com',
    'https://REFIkingdoms.com',
  ];

  @override
  Widget build(BuildContext context) {
    return CustomModal.renderCustomModal(
      title: const Text(
        Strings.disconnectRibnWalletDApps,
        style: RibnToolkitTextStyles.extH2,
        textAlign: TextAlign.center,
      ),
      context: context,
      body: Column(
        children: [
          Text(
            Strings.disconnectRibnWalletDAppsDesc,
            style: RibnToolkitTextStyles.smallBody.copyWith(fontSize: 15),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            width: 360,
            height: 105,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(11.6)),
              color: RibnColors.mediumGrey,
            ),
            child: RawScrollbar(
              shape: const StadiumBorder(),
              mainAxisMargin: 0,
              crossAxisMargin: 0,
              thumbVisibility: true,
              thumbColor: RibnColors.primary,
              thickness: 10,
              child: ScrollConfiguration(
                behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
                child: ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  itemCount: mockConnectedDApps.length,
                  itemBuilder: (buildContext, index) {
                    return Text(
                      mockConnectedDApps[index],
                      style: const TextStyle(
                        fontFamily: 'DM Sans',
                        fontSize: 11,
                        height: 2.5,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
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
                style: RibnToolkitTextStyles.btnMedium.copyWith(
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                // Disconnect action to go here
              },
              buttonWidth: 285,
            ),
            const SizedBox(height: 20),
            // cancel disconnect
            LargeButton(
              buttonChild: Text(
                Strings.noIChangedMyMind,
                style: RibnToolkitTextStyles.btnMedium.copyWith(
                  color: RibnColors.ghostButtonText,
                ),
              ),
              backgroundColor: Colors.transparent,
              hoverColor: Colors.transparent,
              dropShadowColor: Colors.transparent,
              borderColor: RibnColors.ghostButtonText,
              onPressed: () {
                // Cancel action to go here
              },
              buttonWidth: 285,
            ),
          ],
        )
      ],
    );
  }
}
