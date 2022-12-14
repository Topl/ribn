import 'package:flutter/material.dart';
import 'package:ribn/constants/assets.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn_toolkit/constants/styles.dart';

class TransactionRowDetails extends StatelessWidget {
  const TransactionRowDetails({
    required this.quantity,
    required this.wasReceivedToMyWallet,
    required this.isPolyTransfer,
    Key? key,
  }) : super(key: key);

  final String quantity;
  final bool wasReceivedToMyWallet;
  final bool isPolyTransfer;

  @override
  Widget build(BuildContext context) {
    const TextStyle defaultTextStyle = TextStyle(
      fontFamily: 'DM Sans',
      fontSize: 11,
      color: RibnColors.defaultText,
    );

    Widget _buildReviewItem({required String itemLabel, required Widget item}) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            itemLabel,
            style: RibnToolkitTextStyles.h4,
          ),
          const SizedBox(height: 6),
          item,
          const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
            ),
          )
        ],
      );
    }

    Widget buildSendDetails() {
      return _buildReviewItem(
        itemLabel: wasReceivedToMyWallet ? Strings.receive : Strings.send,
        item: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              constraints: const BoxConstraints(maxWidth: 60),
              child: Text(
                quantity,
                style: defaultTextStyle,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 5),
            Row(
              children: [
                Image.asset(
                  isPolyTransfer ? RibnAssets.polyIconCircle : RibnAssets.undefinedIcon,
                  width: 23,
                ),
                const SizedBox(width: 5),
                Text(isPolyTransfer ? 'POLY' : 'OTHER ASSET', style: defaultTextStyle),
              ],
            )
          ],
        ),
      );
    }

    return buildSendDetails();
  }
}
