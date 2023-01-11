// Flutter imports:
import 'package:flutter/material.dart';
// Project imports:
import 'package:ribn/constants/assets.dart';
import 'package:ribn/constants/keys.dart';
import 'package:ribn/constants/routes.dart';
import 'package:ribn/constants/rules.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/models/transfer_details.dart';
import 'package:ribn/utils.dart';
// Package imports:
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn_toolkit/constants/styles.dart';
import 'package:ribn_toolkit/widgets/atoms/custom_copy_button.dart';
import 'package:ribn_toolkit/widgets/atoms/large_button.dart';
import 'package:ribn_toolkit/widgets/molecules/wave_container.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RibnColors.background,
      body: WaveContainer(
        containerHeight: double.infinity,
        containerWidth: double.infinity,
        waveAmplitude: 30,
        containerChild: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: double.infinity,
                height: MediaQuery.of(context).size.height - 84,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildPageIcon(),
                    _buildsPageTitle(),
                    _buildTxInfo(),
                    Column(
                      children: [
                        _buildTxId(),
                        const SizedBox(height: 10),
                        _buildToplExplorerLink(),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: LargeButton(
                      backgroundColor: RibnColors.primary,
                      dropShadowColor: RibnColors.whiteButtonShadow,
                      buttonChild: Text(
                        Strings.done,
                        style: RibnToolkitTextStyles.btnLarge.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      onPressed: () {
                        Keys.navigatorKey.currentState!.popUntil(
                          (route) => route.settings.name == Routes.home,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds the icon to display on the page.
  Widget _buildPageIcon() {
    return Padding(
      padding: const EdgeInsets.only(top: 0, bottom: 0),
      child: Image.asset(
        RibnAssets.fingerPrintAssets,
        width: 179,
      ),
    );
  }

  /// Builds the page's title.
  ///
  /// Different for minting asset and asset/poly transfer.
  Widget _buildsPageTitle() {
    final String text =
        mintedAsset ? Strings.assetIsBeingMinted : Strings.txWasBroadcasted;

    return SizedBox(
      width: 220,
      child: Text(
        text,
        style:
            RibnToolkitTextStyles.h2.copyWith(color: RibnColors.lightGreyTitle),
        textAlign: TextAlign.center,
      ),
    );
  }

  /// Displays information about the tx that was broadcasted.
  Widget _buildTxInfo() {
    final String txInfo = transferDetails.transferType ==
            TransferType.polyTransfer
        ? '${transferDetails.amount} ${'POLY'}'
        : '${transferDetails.amount} of ${transferDetails.assetCode!.shortName.show}';

    return SizedBox(
      width: 220,
      child: Column(
        children: [
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: RibnToolkitTextStyles.h3.copyWith(
                fontWeight: FontWeight.bold,
                color: RibnColors.lightGreyTitle,
              ),
              children: [
                TextSpan(
                  text: 'Your ',
                  style: RibnToolkitTextStyles.h3.copyWith(
                    fontWeight: FontWeight.bold,
                    color: RibnColors.lightGreyTitle,
                  ),
                ),
                TextSpan(
                  text: txInfo,
                  style: RibnToolkitTextStyles.h3.copyWith(
                    fontWeight: FontWeight.bold,
                    color: RibnColors.lightGreyTitle,
                  ),
                ),
                TextSpan(
                  text: ' was sent to the Topl blockchain.',
                  style: RibnToolkitTextStyles.h3.copyWith(
                    fontWeight: FontWeight.bold,
                    color: RibnColors.lightGreyTitle,
                  ),
                ),
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
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Transaction ID: ${formatAddrString(transferDetails.transactionId!, charsToDisplay: 4)}',
          style: RibnToolkitTextStyles.h4.copyWith(
            fontWeight: FontWeight.w400,
            color: RibnColors.lightGreyTitle,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(width: 5),
        CustomCopyButton(
          textToBeCopied: transferDetails.transactionId!,
          bubbleText: 'Copied!',
          icon: Image.asset(
            RibnAssets.copyIconAlternate,
            width: 18,
          ),
        ),
      ],
    );
  }

  /// Redirects user to the Topl Explorer
  RichText _buildToplExplorerLink() {
    final url = Uri.parse(
      '${Rules.txDetailsRedirectUrls[transferDetails.networkId] ?? ''}${transferDetails.transactionId}',
    );

    return RichText(
      text: TextSpan(
        children: [
          WidgetSpan(
            child: GestureDetector(
              onTap: () async => await launchUrl(url),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    Strings.viewInToplExplorer,
                    style: RibnToolkitTextStyles.h4.copyWith(
                      fontWeight: FontWeight.w400,
                      color: RibnColors.secondaryDark,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Image.asset(
                    RibnAssets.openInNewWindow,
                    width: 18,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
