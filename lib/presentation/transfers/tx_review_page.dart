import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ribn/actions/transaction_actions.dart';
import 'package:ribn/constants/assets.dart';
import 'package:ribn/constants/colors.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/constants/styles.dart';
import 'package:ribn/models/app_state.dart';
import 'package:ribn/models/transfer_details.dart';
import 'package:ribn/utils.dart';
import 'package:ribn/widgets/asset_info.dart';
import 'package:ribn/widgets/custom_divider.dart';
import 'package:ribn/widgets/custom_page_title.dart';
import 'package:ribn/widgets/fee_info.dart';
import 'package:ribn/widgets/large_button.dart';

/// The transaction review page that allows the user to review the transaction information before confirming it.
class TxReviewPage extends StatelessWidget {
  const TxReviewPage({
    required this.transferDetails,
    Key? key,
  }) : super(key: key);
  final TransferDetails transferDetails;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RibnColors.accent,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 45),
              child: CustomPageTitle(title: Strings.review),
            ),
            const SizedBox(height: 20),
            Container(
              width: 310,
              height: 335,
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
                  _buildReviewItem(
                    Strings.sending,
                    _buildSendingDetails(),
                  ),
                  _buildReviewItem(
                    Strings.from,
                    _buildFromDetails(),
                  ),
                  _buildReviewItem(
                    Strings.to,
                    _buildToDetails(),
                  ),
                  _buildReviewItem(
                    Strings.note,
                    _buildNoteDetails(),
                    divider: false,
                  ),
                  FeeInfo(fee: transferDetails.transactionReceipt!.fee!.getInNanopoly),
                ],
              ),
            ),
            const SizedBox(height: 19),
            LargeButton(
              label: Strings.cancel,
              onPressed: () {
                Navigator.of(context).pop();
              },
              backgroundColor: RibnColors.primary.withOpacity(0.19),
              textColor: RibnColors.primary,
            ),
            const SizedBox(height: 13),
            LargeButton(
              label: Strings.confirm,
              onPressed: () {
                StoreProvider.of<AppState>(context).dispatch(SignAndBroadcastTxAction(transferDetails));
              },
              backgroundColor: RibnColors.primary,
              textColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReviewItem(String itemLabel, Widget itemDetails, {bool divider = true}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          itemLabel,
          style: RibnTextStyles.extH4,
        ),
        const SizedBox(height: 6),
        itemDetails,
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

  Widget _buildSendingDetails() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          constraints: const BoxConstraints(maxWidth: 60),
          child: Text(
            '${transferDetails.amount} of ',
            style: const TextStyle(
              fontSize: 12,
              fontFamily: 'Nunito',
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        AssetInfo(
          assetCode: transferDetails.assetCode!,
        ),
      ],
    );
  }

  Widget _buildFromDetails() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: 19,
          height: 19,
          child: SvgPicture.asset(RibnAssets.myFingerprint),
        ),
        const SizedBox(width: 6),
        const Text(
          Strings.yourRibnWalletAddress,
          style: TextStyle(
            fontFamily: 'Nunito',
            fontSize: 12,
            color: RibnColors.defaultText,
          ),
        ),
      ],
    );
  }

  Widget _buildToDetails() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: 19,
          height: 19,
          child: SvgPicture.asset(RibnAssets.recipientFingerprint),
        ),
        const SizedBox(width: 6),
        Text(
          formatAddrString(transferDetails.recipient),
          style: const TextStyle(
            fontFamily: 'Nunito',
            fontSize: 12,
            color: RibnColors.defaultText,
          ),
        ),
      ],
    );
  }

  Widget _buildNoteDetails() {
    return SizedBox(
      width: 200,
      height: 50,
      child: Text(
        transferDetails.data,
        overflow: TextOverflow.ellipsis,
        maxLines: 3,
        style: const TextStyle(
          fontFamily: 'Nunito',
          fontSize: 12,
          color: Color(0xFF585858),
        ),
      ),
    );
  }
}
