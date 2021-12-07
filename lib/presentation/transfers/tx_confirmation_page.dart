import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ribn/constants/assets.dart';
import 'package:ribn/constants/colors.dart';
import 'package:ribn/constants/keys.dart';
import 'package:ribn/constants/routes.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/constants/styles.dart';
import 'package:ribn/models/transfer_details.dart';
import 'package:ribn/widgets/large_button.dart';
import 'package:url_launcher/url_launcher.dart';

/// The transaction confirmation page that displays relevant tx details once the tx has been
/// successfully broadcasted.
class TxConfirmationPage extends StatelessWidget {
  TxConfirmationPage({required this.transferDetails, Key? key})
      : mintedAsset = transferDetails.transferType == Strings.minting,
        super(key: key);
  final TransferDetails transferDetails;
  final bool mintedAsset;

  @override
  Widget build(BuildContext context) {
    final String iconToDisplay = mintedAsset ? RibnAssets.mintLarge : RibnAssets.sentIcon;
    const TextStyle greyedOutStyle = TextStyle(
      fontFamily: 'Nunito',
      fontSize: 15,
      color: RibnColors.greyedOut,
    );

    return Scaffold(
      backgroundColor: RibnColors.accent,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Center(),
          Padding(
            padding: const EdgeInsets.only(top: 90, bottom: 35),
            child: SizedBox(
              width: 55,
              height: 67,
              child: SvgPicture.asset(
                iconToDisplay,
              ),
            ),
          ),
          const SizedBox(
            width: 200,
            height: 65,
            child: Text(
              Strings.txWasBroadcasted,
              style: RibnTextStyles.extH2,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 60),
          SizedBox(
            width: 270,
            height: 81,
            child: Column(
              children: [
                Text(
                  'Your ${transferDetails.amount} of ${transferDetails.assetCode!.shortName.show} has been sent and is currently pending.',
                  style: greyedOutStyle,
                ),
                const SizedBox(height: 10),
                Text(
                  'Transaction ID: ${transferDetails.transactionId}',
                  style: greyedOutStyle,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          SizedBox(
            width: 270,
            child: RichText(
              textAlign: TextAlign.start,
              text: TextSpan(
                children: [
                  TextSpan(
                    style: const TextStyle(
                      fontSize: 15,
                      color: RibnColors.primary,
                    ),
                    text: Strings.viewInToplExplorer,
                    recognizer: TapGestureRecognizer()
                      ..onTap = () async {
                        await launch('');
                      },
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 90),
            child: LargeButton(
              label: Strings.done,
              onPressed: () {
                Keys.navigatorKey.currentState!.popUntil((route) => route.settings.name == Routes.home);
              },
            ),
          )
        ],
      ),
    );
  }
}
