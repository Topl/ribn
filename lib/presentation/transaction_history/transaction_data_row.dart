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

class TransactionDataRow extends StatefulWidget {
  final List<AssetAmount> assets;
  final TransactionHistoryEntry transactionReceipt;
  final String myRibnWalletAddress;
  final Future<String>? blockHeight;

  const TransactionDataRow({
    required this.transactionReceipt,
    required this.assets,
    required this.myRibnWalletAddress,
    required this.blockHeight,
    Key? key,
  }) : super(key: key);

  @override
  State<TransactionDataRow> createState() => _TransactionDataRowState();
}

class _TransactionDataRowState extends State<TransactionDataRow> {
  String transactionStatus = 'unconfirmed';

  @override
  initState() {
    getBlockHeight();

    super.initState();
  }

  getBlockHeight() async {
    final blockHeightString = await widget.blockHeight;
    final blockHeightNum = int.parse(blockHeightString!);
    final transactionBlockHeightNum = widget.transactionReceipt.block['height'];
    final heightDifference = blockHeightNum - transactionBlockHeightNum;

    if (heightDifference > 30) {
      setState(() {
        transactionStatus = 'confirmed';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isPolyTransaction = widget.transactionReceipt.txType == 'PolyTransfer';
    final timestampInt = int.parse(widget.transactionReceipt.timestamp);
    final date = DateTime.fromMillisecondsSinceEpoch(timestampInt);
    final dateFormat = DateFormat('MMM d');
    final String formattedDate = dateFormat.format(date);
    final transactionReceiverAddress = widget.transactionReceipt.to.length == 2
        ? widget.transactionReceipt.to[1][0]
        : widget.transactionReceipt.to[0][0];
    final transactionSenderAddress = widget.transactionReceipt.from[0][0];
    // final toAddresses = widget.transactionReceipt.to.where((transaction) => transaction.minting == true).toList();
    final bool sentByMe = transactionSenderAddress == widget.myRibnWalletAddress ? true : false;
    final bool sentToMe = transactionReceiverAddress == widget.myRibnWalletAddress ? true : false;
    // final AssetCode assetCode = widget.transactionReceipt.to[1][1]['assetCode'];
    // final receiverAddress =
    //     widget.transactionReceipt.to.where((transaction) => transaction[0] == widget.myRibnWalletAddress).toList();

    String? renderSentReceivedMintedText() {
      if (widget.transactionReceipt.minting == true) {
        return 'Minted';
      } else if (sentByMe && sentToMe) {
        return 'Received';
      } else if (sentByMe && !sentToMe) {
        return 'Sent';
      } else if (!sentByMe && sentToMe) {
        return 'Received';
      } else if (!sentByMe && !sentToMe) {
        return 'How?!';
      }

      return '';
    }

    String? renderPlusOrMinus() {
      if (widget.transactionReceipt.minting == true) {
        return '+';
      } else if (sentByMe && sentToMe) {
        return '+';
      } else if (sentByMe && !sentToMe) {
        return '-';
      } else if (!sentByMe && sentToMe) {
        return '+';
      } else if (!sentByMe && !sentToMe) {
        return 'How?!';
      }
      return '';
    }

    // Render poly specific section if poly transfer
    if (isPolyTransaction) {
      final transactionAmountValue = widget.transactionReceipt.to.length == 2
          ? widget.transactionReceipt.to[1][1]['quantity']
          : widget.transactionReceipt.to[0][1]['quantity'];

      // ^ Will need to check this logic to ensure I'm access the correct value as there are sometimes
      // x1 and x2 transaction entries in the to: array (which is the correct value?)
      // https://annulus-api.topl.services/staging/valhalla/v1/address/history/3NQQK6Mgir21QbySoHztQ9hRQoTTnZeBBSw4vUXcVGjKxN5soSQe

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
                  height: 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: 25,
                        height: 25,
                        child: renderPolyIcon(),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${renderPlusOrMinus()}$transactionAmountValue POLYs',
                              style: RibnToolkitTextStyles.extH3.copyWith(fontSize: 14),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 40,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      // Will need to pass in actual status from API when Genus plugged in
                      StatusChip(status: transactionStatus),
                      Text(
                        '${renderSentReceivedMintedText()} on $formattedDate',
                        style: RibnToolkitTextStyles.assetLongNameStyle.copyWith(fontSize: 11),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }

    return StoreConnector<AppState, AssetDetails?>(
      // Get access to AssetDetails for this asset from the store only if not poly transaction
      converter: (store) => store.state.userDetailsState.assetDetails[widget.transactionReceipt.to[1][1]['assetCode']],
      builder: (context, assetDetails) {
        final List filteredAsset = widget.assets
            .where(
              (item) => item.assetCode.toString() == widget.transactionReceipt.to[1][1]['assetCode'].toString(),
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
                    height: 40,
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
                                '${renderPlusOrMinus()}${widget.transactionReceipt.to[1][1]['quantity']} ${formatAssetUnit(assetDetails?.unit ?? 'Unit')}',
                                style: RibnToolkitTextStyles.extH3.copyWith(fontSize: 14),
                              ),
                              Text(
                                filteredAsset[0].assetCode.shortName.show,
                                style: RibnToolkitTextStyles.assetLongNameStyle.copyWith(fontSize: 11),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 40,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        // Will need to pass in actual status from API when Genus plugged in
                        StatusChip(status: transactionStatus),
                        Text(
                          '${renderSentReceivedMintedText()} on $formattedDate',
                          style: RibnToolkitTextStyles.assetLongNameStyle.copyWith(fontSize: 11),
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
