import 'package:brambldart/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:intl/intl.dart';
import 'package:ribn/constants/assets.dart';
import 'package:ribn/models/app_state.dart';
import 'package:ribn/models/asset_details.dart';
import 'package:ribn/models/transaction_history_entry.dart';
import 'package:ribn/utils.dart';
import 'package:ribn_toolkit/constants/styles.dart';
import 'package:ribn_toolkit/widgets/atoms/status_chip.dart';

class TransactionDataRow extends StatelessWidget {
  final List<AssetAmount> assets;

  final TransactionHistoryEntry transactionReceipt;

  const TransactionDataRow({
    required this.transactionReceipt,
    required this.assets,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isAssetTransaction = transactionReceipt.txType == 'PolyTransfer';

    // Render poly specific section if poly transfer
    if (isAssetTransaction) {
      return Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 15,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 25,
                  height: 25,
                  child: renderPolyIcon(),
                ),
                Text(transactionReceipt.timestamp),
                Text('Try htis ish s'),
              ],
            ),
          ],
        ),
      );
    }

    return StoreConnector<AppState, AssetDetails?>(
      // Get access to AssetDetails for this asset from the store only if not poly transaction
      converter: (store) => store.state.userDetailsState.assetDetails[transactionReceipt.to[1][1]['assetCode']],
      builder: (context, assetDetails) {
        final timestampInt = int.parse(transactionReceipt.timestamp);
        final date = DateTime.fromMillisecondsSinceEpoch(timestampInt);
        final dateFormat = DateFormat('MMM d');
        final String formattedDate = dateFormat.format(date);
        final mockStatusList = ['confirmed', 'pending', 'unconfirmed'];
        final randomItem = (mockStatusList..shuffle()).first;

        final List filteredAsset = assets
            .where(
              (item) => item.assetCode.toString() == transactionReceipt.to[1][1]['assetCode'].toString(),
            )
            .toList();

        return Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 15,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 55,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          width: 25,
                          height: 25,
                          child: renderAssetIcon(assetDetails?.icon),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                '${transactionReceipt.to[1][1]['quantity']} ${formatAssetUnit(assetDetails?.unit ?? 'Unit')}',
                                style: RibnToolkitTextStyles.extH3.copyWith(fontSize: 14),
                              ),
                              Text(
                                filteredAsset[0].assetCode.shortName.show,
                                style: RibnToolkitTextStyles.assetLongNameStyle,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 55,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        // Will need to pass in actual status from API when Genus plugged in
                        StatusChip(status: randomItem),
                        Text(
                          'Sent on $formattedDate',
                          style: RibnToolkitTextStyles.assetLongNameStyle,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Image renderAssetIcon(assetDetailsIcon) {
    return assetDetailsIcon == null
        ? Image.asset(RibnAssets.undefinedIcon)
        : Image.asset(
            assetDetailsIcon!,
          );
  }

  Image renderPolyIcon() {
    return Image.asset(RibnAssets.polyIconCircle);
  }
}
