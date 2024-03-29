// Dart imports:

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:brambldart/model.dart';
import 'package:brambldart/utils.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:intl/intl.dart';
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn_toolkit/widgets/molecules/ribn_activity_tile.dart';

// Project imports:
import 'package:ribn/v1/constants/assets.dart';
import 'package:ribn/v1/constants/routes.dart';
import 'package:ribn/v1/models/app_state.dart';
import 'package:ribn/v1/models/asset_details.dart';
import 'package:ribn/v1/utils/extensions.dart';

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
    final bool isPolyTransaction = widget.transactionReceipt.txType == 'PolyTransfer' ||
        widget.transactionReceipt.to.first.toJson()[1].runtimeType == String;
    final int timestampInt = widget.transactionReceipt.timestamp;
    final DateTime date = DateTime.fromMillisecondsSinceEpoch(timestampInt);
    final DateFormat dateFormat = DateFormat('MMM d');
    final DateFormat dateFormatAlternate = DateFormat('MM-dd-yyyy');
    final String formattedDate = dateFormat.format(date);
    final String formattedDateAlternate = dateFormatAlternate.format(date);
    final String transactionReceiverAddress = widget.transactionReceipt.to.first.toJson()[0].toString();
    final String transactionQuantity = isPolyTransaction
        ? widget.transactionReceipt.to.first.toJson()[1]
        : widget.transactionReceipt.to.first.toJson()[1]['quantity'];
    final Sender transactionSenderAddress = widget.transactionReceipt.from![0];

    final String fee = '${widget.transactionReceipt.fee!.quantity} nanoPOLYs';
    final Latin1Data? note = widget.transactionReceipt.data;
    final String securityRoot = isPolyTransaction ? '' : widget.transactionReceipt.to.first.toJson()[1]['securityRoot'];
    final String assetCode =
        isPolyTransaction ? '' : widget.transactionReceipt.to.first.toJson()[1]['assetCode'].toString();
    final ModifierId? blockId = widget.transactionReceipt.blockId;
    final BlockNum? blockNumber = widget.transactionReceipt.blockNumber;
    final ModifierId transactionId = widget.transactionReceipt.id;
    final String renderPlusOrMinusPolyTransfer =
        transactionReceiverAddress == widget.myRibnWalletAddress && isPolyTransaction ? '+' : '-';
    final String transactionAmountForPolyTransfer = '$renderPlusOrMinusPolyTransfer$transactionQuantity';

    String? transactionAmountForAssetTransfer() {
      if (transactionReceiverAddress == widget.myRibnWalletAddress && !transactionQuantity.contains('-')) {
        return '+$transactionQuantity';
      } else if (transactionReceiverAddress == widget.myRibnWalletAddress && transactionQuantity.contains('-')) {
        return transactionQuantity;
      } else if (transactionReceiverAddress != widget.myRibnWalletAddress && transactionQuantity.contains('-')) {
        return transactionQuantity;
      } else if (transactionReceiverAddress != widget.myRibnWalletAddress &&
          widget.transactionReceipt.minting == true) {
        return '+$transactionQuantity';
      }
      return '-$transactionQuantity';
    }

    String? renderSentReceivedMintedText() {
      if (transactionReceiverAddress == widget.myRibnWalletAddress && !transactionQuantity.contains('-')) {
        return 'Received';
      }
      return 'Sent';
    }

    return StoreConnector<AppState, AssetDetails?>(
      // Get access to AssetDetails for this asset from the store only if not poly transaction
      converter: (store) => store.state.userDetailsState.assetDetails[assetCode],
      builder: (context, assetDetails) {
        final List filteredAsset = widget.assets
            .where(
              (item) => item.assetCode.toString() == assetCode,
            )
            .toList();

        return RibnActivityTile(
          tileColor: RibnColors.whiteColor,
          assetIcon: isPolyTransaction ? renderPolyIcon() : renderAssetIcon(assetDetails?.icon),
          assetBalance: '${transactionAmountForAssetTransfer()} ${(assetDetails?.unit ?? 'Unit').formatAssetUnit()}',
          assetShortName: isPolyTransaction
              ? 'POLY'
              : filteredAsset.isNotEmpty
                  ? filteredAsset[0].assetCode.shortName.show.replaceAll('\x00', '')
                  : '',
          transactionStatus: transactionStatus,
          transactionDate: '${renderSentReceivedMintedText()} on $formattedDate',
          onTap: () {
            final Map details = {
              'isPolyTransaction': isPolyTransaction,
              'transactionType': renderSentReceivedMintedText(),
              'timestamp': formattedDateAlternate,
              'assetDetails': isPolyTransaction ? {} : assetDetails ?? {'unit': transactionAmountForAssetTransfer()},
              'icon': isPolyTransaction ? renderPolyIcon() : renderAssetIcon(assetDetails?.icon),
              'shortName': isPolyTransaction
                  ? 'POLY'
                  : filteredAsset.isNotEmpty
                      ? filteredAsset[0].assetCode.shortName.show.replaceAll('\x00', '')
                      : '',
              'transactionStatus': transactionStatus,
              'transactionAmount': isPolyTransaction
                  ? transactionAmountForPolyTransfer
                  : '${transactionAmountForAssetTransfer()} ${(assetDetails?.unit ?? 'Unit').formatAssetUnit()}',
              'fee': fee,
              'myRibnWalletAddress': widget.myRibnWalletAddress,
              'transactionSenderAddress': transactionSenderAddress.senderAddress.toBase58(),
              'note': note,
              'securityRoot': isPolyTransaction ? '' : securityRoot,
              'blockId': blockId.toString(),
              'blockHeight': blockNumber?.blockNum,
              'transactionId': transactionId.toString(),
              'networkId': widget.networkId,
            };
            Navigator.pushNamed(
              context,
              Routes.txHistoryDetails,
              arguments: details,
            );
          },
        );
      },
    );
  }

  String renderAssetIcon(assetDetailsIcon) {
    return assetDetailsIcon == null ? RibnAssets.undefinedIcon : assetDetailsIcon!;
  }

  String renderPolyIcon() {
    return RibnAssets.polyIconCircle;
  }
}
