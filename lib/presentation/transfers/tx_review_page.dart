import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ribn/actions/transaction_actions.dart';
import 'package:ribn/constants/rules.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/models/app_state.dart';
import 'package:ribn/models/transfer_details.dart';
import 'package:ribn/utils.dart';
import 'package:ribn/widgets/asset_info.dart';
import 'package:ribn/widgets/custom_divider.dart';
import 'package:ribn/widgets/custom_page_title.dart';
import 'package:ribn/widgets/fee_info.dart';
import 'package:ribn_toolkit/constants/assets.dart';
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn_toolkit/constants/styles.dart';
import 'package:ribn_toolkit/widgets/atoms/custom_copy_button.dart';
import 'package:ribn_toolkit/widgets/atoms/large_button.dart';

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
    return Scaffold(
      backgroundColor: RibnColors.accent,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // page title
            const Padding(
              padding: EdgeInsets.only(top: 45),
              child: CustomPageTitle(title: Strings.review),
            ),
            const SizedBox(height: 20),
            // review box
            Container(
              width: 310,
              height: 300,
              padding: const EdgeInsets.symmetric(
                horizontal: 19.5,
                vertical: 15,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.7),
                color: RibnColors.whiteBackground,
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
            // fee info
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: SizedBox(
                width: 310,
                child: FeeInfo(fee: transferDetails.transactionReceipt!.fee!.getInNanopoly),
              ),
            ),
            // cancel button
            LargeButton(
              buttonChild: Text(
                Strings.cancel,
                style: RibnToolkitTextStyles.btnMedium.copyWith(
                  color: RibnColors.primary,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              backgroundColor: RibnColors.primary.withOpacity(0.19),
            ),
            const SizedBox(height: 13),
            // confirm button
            LargeButton(
              buttonChild: Text(
                Strings.confirm,
                style: RibnToolkitTextStyles.btnMedium.copyWith(
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                StoreProvider.of<AppState>(context).dispatch(SignAndBroadcastTxAction(transferDetails));
              },
              backgroundColor: RibnColors.primary,
            ),
          ],
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
            width: 19,
            height: 19,
            child: SvgPicture.asset(RibnAssets.myFingerprint),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
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
            width: 19,
            height: 19,
            child: SvgPicture.asset(RibnAssets.recipientFingerprint),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
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
