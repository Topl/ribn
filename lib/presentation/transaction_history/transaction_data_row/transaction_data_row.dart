// ignore_for_file: unused_import, unused_local_variable

import 'package:brambldart/model.dart';
import 'package:brambldart/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:intl/intl.dart';
import 'package:ribn/constants/assets.dart';
import 'package:ribn/constants/keys.dart';
import 'package:ribn/constants/routes.dart';
import 'package:ribn/models/app_state.dart';
import 'package:ribn/models/asset_details.dart';
import 'package:ribn/utils.dart';
import 'package:ribn_toolkit/constants/styles.dart';
import 'package:ribn_toolkit/widgets/atoms/status_chip.dart';

class TransactionDataRow extends StatefulWidget {
  final List<AssetAmount> assets;
  final TransactionReceipt transactionReceipt;
  final String myRibnWalletAddress;
  final Future<String>? blockHeight;
  final int networkId;

  const TransactionDataRow({
    required this.transactionReceipt,
    required this.assets,
    required this.myRibnWalletAddress,
    required this.blockHeight,
    required this.networkId,
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
    final transactionBlockHeightNum = int.parse('${widget.transactionReceipt.blockNumber}');
    final blockHeightString = await widget.blockHeight;
    final blockHeightNum = int.parse(blockHeightString!);

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
    final int timestampInt = widget.transactionReceipt.timestamp;
    final DateTime date = DateTime.fromMillisecondsSinceEpoch(timestampInt);
    final DateFormat dateFormat = DateFormat('MMM d');
    final DateFormat dateFormatAlternate = DateFormat('MM-dd-yyyy');
    final String formattedDate = dateFormat.format(date);
    final String formattedDateAlternate = dateFormatAlternate.format(date);
    final String transactionReceiverAddress = widget.transactionReceipt.to.first.toJson()[0].toString();
    final String transactionQuantity = widget.transactionReceipt.to.first.toJson()[1];
    final Sender transactionSenderAddress = widget.transactionReceipt.from![0];
    final PolyAmount? fee = widget.transactionReceipt.fee;
    final Latin1Data? note = widget.transactionReceipt.data;
    final securityRoot = widget.transactionReceipt.to;
    // final ModifierId? blockId = widget.transactionReceipt.blockId;
    // final BlockNum? blockNumber = widget.transactionReceipt.blockNumber;
    // final ModifierId transactionId = widget.transactionReceipt.id;
    final String renderPlusOrMinus = transactionReceiverAddress == widget.myRibnWalletAddress ? '+' : '-';
    final String transactionPolyAmount = '$renderPlusOrMinus$transactionQuantity POLYs';

    // print(widget.transactionReceipt.to.first.key);
    // print(widget.transactionReceipt.to.first.value);
    // print(widget.transactionReceipt.to.first.toJson()[0]);
    // print(securityRoot);

    String? renderSentReceivedMintedText() {
      if (widget.transactionReceipt.minting == true) {
        return 'Minted';
      } else if (transactionReceiverAddress == widget.myRibnWalletAddress) {
        return 'Received';
      }
      return 'Sent';
    }

    // Render poly specific section if poly transfer
    if (isPolyTransaction) {
      return GestureDetector(
        onTap: () {
          Keys.navigatorKey.currentState?.pushNamed(
            Routes.txHistoryDetails,
            // arguments: {
            //   'isPolyTransaction': true,
            //   'transactionType': renderSentReceivedMintedText(),
            //   'timestamp': formattedDateAlternate,
            //   'assetDetails': {},
            //   'icon': renderPolyIcon(),
            //   'shortName': 'POLY',
            //   'transactionStatus': transactionStatus,
            //   'transactionAmount': transactionPolyAmount,
            //   'fee': fee,
            //   'myRibnWalletAddress': widget.myRibnWalletAddress,
            //   'transactionSenderAddress': transactionSenderAddress,
            //   'note': note,
            //   'securityRoot': securityRoot,
            //   'blockId': blockId,
            //   'blockHeight': blockNumber,
            //   'transactionId': transactionId,
            //   'networkId': widget.networkId,
            // },
          );
        },
        child: Container(
          color: Colors.transparent,
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
                                transactionPolyAmount,
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
        ),
      );
    }

    return Text('Asset transfer');

    // return StoreConnector<AppState, AssetDetails?>(
    //   // Get access to AssetDetails for this asset from the store only if not poly transaction
    //   converter: (store) => store.state.userDetailsState.assetDetails[widget.transactionReceipt.to[0][1]['assetCode']],
    //   builder: (context, assetDetails) {
    //     final List filteredAsset = widget.assets
    //         .where(
    //           (item) => item.assetCode.toString() == widget.transactionReceipt.to[0][1]['assetCode'].toString(),
    //         )
    //         .toList();

    //     return GestureDetector(
    //       onTap: () {
    //         Keys.navigatorKey.currentState?.pushNamed(
    //           Routes.txHistoryDetails,
    //           arguments: {
    //             'isPolyTransaction': false,
    //             'transactionType': renderSentReceivedMintedText(),
    //             'timestamp': formattedDateAlternate,
    //             'assetDetails': assetDetails,
    //             'icon': renderAssetIcon(assetDetails?.icon),
    //             'shortName': filteredAsset[0].assetCode.shortName.show,
    //             'transactionStatus': transactionStatus,
    //             'transactionAmount':
    //                 '$renderPlusOrMinus${widget.transactionReceipt.to[0][1]['quantity']} ${formatAssetUnit(assetDetails?.unit ?? 'Unit')}',
    //             'fee': fee,
    //             'myRibnWalletAddress': widget.myRibnWalletAddress,
    //             'transactionSenderAddress': transactionSenderAddress,
    //             'note': note,
    //             'securityRoot': securityRoot,
    //             'blockId': blockId,
    //             'blockHeight': blockNumber,
    //             'transactionId': transactionId,
    //             'networkId': widget.networkId,
    //           },
    //         );
    //       },
    //       child: Container(
    //         color: Colors.white,
    //         padding: const EdgeInsets.symmetric(
    //           horizontal: 8,
    //           vertical: 15,
    //         ),
    //         child: Column(
    //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //           children: [
    //             Row(
    //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //               children: [
    //                 SizedBox(
    //                   height: 40,
    //                   child: Row(
    //                     mainAxisAlignment: MainAxisAlignment.spaceAround,
    //                     children: [
    //                       SizedBox(
    //                         width: 25,
    //                         height: 25,
    //                         child: renderAssetIcon(assetDetails?.icon),
    //                       ),
    //                       Padding(
    //                         padding: const EdgeInsets.only(left: 12),
    //                         child: Column(
    //                           crossAxisAlignment: CrossAxisAlignment.start,
    //                           mainAxisAlignment: MainAxisAlignment.spaceAround,
    //                           children: [
    //                             Text(
    //                               '$renderPlusOrMinus${widget.transactionReceipt.to[0][1]['quantity']} ${formatAssetUnit(assetDetails?.unit ?? 'Unit')}',
    //                               style: RibnToolkitTextStyles.extH3.copyWith(fontSize: 14),
    //                             ),
    //                             Text(
    //                               filteredAsset[0].assetCode.shortName.show,
    //                               style: RibnToolkitTextStyles.assetLongNameStyle.copyWith(fontSize: 11),
    //                             ),
    //                           ],
    //                         ),
    //                       )
    //                     ],
    //                   ),
    //                 ),
    //                 SizedBox(
    //                   height: 40,
    //                   child: Column(
    //                     crossAxisAlignment: CrossAxisAlignment.end,
    //                     mainAxisAlignment: MainAxisAlignment.spaceAround,
    //                     children: [
    //                       // Will need to pass in actual status from API when Genus plugged in
    //                       StatusChip(status: transactionStatus),
    //                       Text(
    //                         '${renderSentReceivedMintedText()} on $formattedDate',
    //                         style: RibnToolkitTextStyles.assetLongNameStyle.copyWith(fontSize: 11),
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ],
    //         ),
    //       ),
    //     );
    //   },
    // );
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
