import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ribn/constants/keys.dart';
import 'package:ribn/constants/routes.dart';
import 'package:ribn/constants/rules.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/models/transfer_details.dart';
import 'package:ribn/utils.dart';
import 'package:ribn_toolkit/constants/assets.dart';
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn_toolkit/constants/styles.dart';
import 'package:ribn_toolkit/widgets/atoms/custom_copy_button.dart';
import 'package:ribn_toolkit/widgets/atoms/large_button.dart';
import 'package:url_launcher/url_launcher.dart';

/// The transaction confirmation page.
///
/// Displays the relevant tx details once the tx has been successfully broadcasted.
class TxConfirmationPage extends StatelessWidget {
  TxConfirmationPage({required this.transferDetails, Key? key})
      : mintedAsset = transferDetails.transferType == TransferType.mintingAsset,
        super(key: key);

  /// Holds details about the transaction.
  final TransferDetails transferDetails;

  /// True if tx was for minting an asset.
  final bool mintedAsset;

  /// Default text style used on this page.
  final TextStyle defaultTextStyle = const TextStyle(
    fontFamily: 'DM Sans',
    fontSize: 15,
    color: RibnColors.greyedOut,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RibnColors.accent,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Center(),
          _buildPageIcon(),
          _buildsPageTitle(),
          const SizedBox(height: 60),
          SizedBox(
            width: 270,
            height: 81,
            child: Column(
              children: [
                _buildTxInfo(),
                const SizedBox(height: 15),
                _buildTxId(),
              ],
            ),
          ),
          _buildToplExplorerLink(),
          Padding(
            padding: const EdgeInsets.only(top: 90),
            child: LargeButton(
              buttonChild: Text(
                Strings.done,
                style: RibnToolkitTextStyles.btnMedium.copyWith(
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                Keys.navigatorKey.currentState!.popUntil((route) => route.settings.name == Routes.home);
              },
            ),
          )
        ],
      ),
    );
  }

  /// Builds the icon to display on the page.
  ///
  /// Different for minting asset and asset/poly transfer.
  Widget _buildPageIcon() {
    final String iconToDisplay = mintedAsset ? RibnAssets.mintLarge : RibnAssets.sentIcon;
    return Padding(
      padding: const EdgeInsets.only(top: 90, bottom: 35),
      child: SizedBox(
        width: 55,
        height: 67,
        child: SvgPicture.asset(
          iconToDisplay,
        ),
      ),
    );
  }

  /// Builds the page's title.
  ///
  /// Different for minting asset and asset/poly transfer.
  Widget _buildsPageTitle() {
    final String text = mintedAsset ? Strings.assetIsBeingMinted : Strings.txWasBroadcasted;
    return SizedBox(
      width: 200,
      height: 70,
      child: Text(
        text,
        style: RibnToolkitTextStyles.extH2,
        textAlign: TextAlign.center,
      ),
    );
  }

  /// Displays information about the tx that was broadcasted.
  Widget _buildTxInfo() {
    final String txInfo = transferDetails.transferType == TransferType.polyTransfer
        ? '${transferDetails.amount} ${'POLY'}'
        : '${transferDetails.amount} of ${transferDetails.assetCode!.shortName.show}';
    return SizedBox(
      width: 270,
      height: 40,
      child: Column(
        children: [
          RichText(
            text: TextSpan(
              style: defaultTextStyle,
              children: [
                const TextSpan(text: 'Your '),
                TextSpan(
                  text: txInfo,
                  style: defaultTextStyle.copyWith(fontWeight: FontWeight.w600),
                ),
                const TextSpan(text: ' has been sent and is currently pending'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Displays the tx id that the user can copy.
  Widget _buildTxId() {
    return Row(
      children: [
        Text(
          'Transaction ID: ${formatAddrString(transferDetails.transactionId!, charsToDisplay: 4)}',
          style: defaultTextStyle,
        ),
        const SizedBox(width: 5),
        CustomCopyButton(
          textToBeCopied: transferDetails.transactionId!,
          bubbleText: 'Copied!',
          icon: Image.asset(
            RibnAssets.copyIcon,
            width: 26,
          ),
        ),
      ],
    );
  }

  /// Redirects user to the Topl Explorer
  Widget _buildToplExplorerLink() {
    return SizedBox(
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
                  final Uri url = Uri.parse(
                    '${Rules.txDetailsRedirectUrls[transferDetails.networkId] ?? ''}${transferDetails.transactionId}',
                  );

                  await launchUrl(url);
                },
            ),
          ],
        ),
      ),
    );
  }
}
