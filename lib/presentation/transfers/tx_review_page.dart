import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:ribn/actions/transaction_actions.dart';
import 'package:ribn/constants/keys.dart';
import 'package:ribn/constants/routes.dart';
import 'package:ribn/constants/rules.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/models/app_state.dart';
import 'package:ribn/models/transfer_details.dart';
import 'package:ribn/presentation/transfers/bottom_review_action.dart';
import 'package:ribn/presentation/transfers/transfer_utils.dart';
import 'package:ribn/utils.dart';
import 'package:ribn/widgets/asset_info.dart';
import 'package:ribn/widgets/custom_divider.dart';
import 'package:ribn/widgets/fee_info.dart';
import 'package:ribn_toolkit/constants/assets.dart';
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn_toolkit/constants/styles.dart';
import 'package:ribn_toolkit/widgets/atoms/custom_copy_button.dart';
import 'package:ribn_toolkit/widgets/atoms/large_button.dart';
import 'package:ribn_toolkit/widgets/organisms/custom_page_text_title.dart';

/// The transaction review page.
///
/// Allows the user to review the transaction information before confirming/broadcasting it.
class TxReviewPage extends StatelessWidget {
  const TxReviewPage({
    required this.transferDetails,
    Key? key,
  }) : super(key: key);

  /// Holds details about the transaction.
  final TransferDetails transferDetails;

  /// Default text style being used on this page.
  final TextStyle defaultTextStyle = const TextStyle(
    fontFamily: 'DM Sans',
    fontSize: 12,
    color: RibnColors.defaultText,
  );

  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      child: Scaffold(
        backgroundColor: RibnColors.background,
        body: SingleChildScrollView(
          child: SizedBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    // page title
                    const CustomPageTextTitle(title: Strings.review),
                    const SizedBox(height: 40),
                    // review box
                    Container(
                      width: 310,
                      height: 300,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 19.5,
                        vertical: 15,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(11.6),
                        color: RibnColors.whiteBackground,
                        border: Border.all(color: RibnColors.lightGrey, width: 1),
                        boxShadow: const [
                          BoxShadow(
                            color: RibnColors.greyShadow,
                            spreadRadius: 0,
                            blurRadius: 37.5,
                            offset: Offset(0, -6),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildSendingDetails(),
                          _buildFromDetails(),
                          _buildToDetails(),
                          _buildNoteDetails(),
                        ],
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    // fee info
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 38),
                      child: SizedBox(
                        width: 310,
                        child: FeeInfo(fee: transferDetails.transactionReceipt!.fee!.getInNanopoly),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomReviewAction(
          children: Column(
            children: [
              // confirm button
              LargeButton(
                buttonChild: Text(
                  Strings.confirm,
                  style: RibnToolkitTextStyles.btnLarge.copyWith(
                    color: Colors.white,
                  ),
                ),
                onPressed: () async {
                  context.loaderOverlay.show();
                  final Completer<TransferDetails?> txCompleter = Completer();
                  StoreProvider.of<AppState>(context).dispatch(SignAndBroadcastTxAction(transferDetails, txCompleter));
                  await txCompleter.future.then((TransferDetails? transferDetails) {
                    if (transferDetails != null) {
                      Keys.navigatorKey.currentState?.pushNamed(
                        Routes.txConfirmation,
                        arguments: transferDetails,
                      );
                    } else {
                      TransferUtils.showErrorDialog(context);
                    }
                  });
                },
                backgroundColor: RibnColors.primary,
              ),
              const SizedBox(
                height: 15,
              ),
              // cancel button
              LargeButton(
                buttonChild: Text(
                  Strings.cancel,
                  style: RibnToolkitTextStyles.btnLarge.copyWith(
                    color: RibnColors.ghostButtonText,
                  ),
                ),
                backgroundColor: Colors.transparent,
                hoverColor: Colors.transparent,
                dropShadowColor: Colors.transparent,
                borderColor: RibnColors.ghostButtonText,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              const SizedBox(height: 13),
            ],
          ),
        ),
      ),
    );
  }

  /// A helper function used to build review items on this page.
  Widget _buildReviewItem({required String itemLabel, required Widget item, bool divider = true}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          itemLabel,
          style: RibnToolkitTextStyles.h4,
        ),
        const SizedBox(height: 6),
        item,
        divider
            ? const Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: CustomDivider(),
                ),
              )
            : const SizedBox(),
      ],
    );
  }

  /// UI for displaying the amount and asset for the tx.
  Widget _buildSendingDetails() {
    return _buildReviewItem(
      itemLabel: Strings.sending,
      item: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            constraints: const BoxConstraints(maxWidth: 60),
            child: Text(
              '${transferDetails.amount} of ',
              style: const TextStyle(
                fontSize: 12,
                fontFamily: 'DM Sans',
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          // conditional display based on transfer type
          transferDetails.transferType == TransferType.polyTransfer
              ? Row(
                  children: [
                    Image.asset(RibnAssets.polysIcon),
                    const SizedBox(width: 5),
                    Text('POLY', style: defaultTextStyle),
                  ],
                )
              : AssetInfo(assetCode: transferDetails.assetCode!, assetDetails: transferDetails.assetDetails),
        ],
      ),
    );
  }

  /// UI for displaying the sender.
  ///
  /// Allows copying the sender address.
  Widget _buildFromDetails() {
    return _buildReviewItem(
      itemLabel: Strings.from,
      item: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: 26,
            height: 26,
            child: SvgPicture.asset(RibnAssets.myFingerprint),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              Strings.yourRibnWalletAddress,
              style: defaultTextStyle,
            ),
          ),
          CustomCopyButton(
            textToBeCopied: transferDetails.senders.first.toplAddress.toBase58(),
            icon: Image.asset(
              RibnAssets.copyIcon,
              width: 26,
            ),
          ),
        ],
      ),
    );
  }

  /// UI for displaying the receipient details.
  ///
  /// Allows copying the receipient address.
  Widget _buildToDetails() {
    return _buildReviewItem(
      itemLabel: Strings.to,
      item: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: 26,
            height: 26,
            child: SvgPicture.asset(RibnAssets.recipientFingerprint),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              formatAddrString(transferDetails.recipient),
              style: defaultTextStyle,
            ),
          ),
          CustomCopyButton(
            textToBeCopied: transferDetails.senders.first.toplAddress.toBase58(),
            icon: Image.asset(
              RibnAssets.copyIcon,
              width: 26,
            ),
          ),
        ],
      ),
    );
  }

  /// UI for displaying the note included in the transaction.
  Widget _buildNoteDetails() {
    return _buildReviewItem(
      itemLabel: Strings.note,
      item: SizedBox(
        width: 200,
        height: 50,
        child: Text(
          transferDetails.data,
          overflow: TextOverflow.ellipsis,
          maxLines: 3,
          style: const TextStyle(
            fontFamily: 'DM Sans',
            fontSize: 12,
            color: Color(0xFF585858),
          ),
        ),
      ),
      divider: false,
    );
  }
}
