// Flutter imports:

// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:brambldart/brambldart.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

// Project imports:
import 'package:ribn/genus/generated/filters.pb.dart';
import 'package:ribn/genus/generated/services_types.pb.dart';
import 'package:ribn/genus/generated/transactions_query.pbgrpc.dart';
import 'package:ribn/models/app_state.dart';
import 'package:ribn/platform/platform.dart';

/// Intended to wrap the [TransactionHistoryPage] and provide it with the the [TransactionHistoryViewmodel].
class TransactionHistoryContainer extends StatelessWidget {
  const TransactionHistoryContainer({Key? key, required this.builder}) : super(key: key);
  final ViewModelBuilder<TransactionHistoryViewmodel> builder;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, TransactionHistoryViewmodel>(
      distinct: true,
      converter: TransactionHistoryViewmodel.fromStore,
      builder: builder,
    );
  }
}

class TransactionHistoryViewmodel {
  /// Helpful representation of the address as a [ToplAddress].
  final ToplAddress toplAddress;

  /// The networkId for returning correct transaction data per each Topl network
  final int networkId;

  /// All the assets owned by this wallet.
  final List<AssetAmount> assets;

  /// Get the current block height
  final Future<String>? blockHeight;

  /// Gets transactions associated with my wallet address from the Mempool and Genus
  final Future<List<TransactionReceipt>> Function({int pageNum}) getTransactions;

  TransactionHistoryViewmodel({
    required this.toplAddress,
    required this.networkId,
    required this.assets,
    this.blockHeight,
    required this.getTransactions,
  });

  static TransactionHistoryViewmodel fromStore(Store<AppState> store) {
    final currNetwork = store.state.keychainState.currentNetwork;
    return TransactionHistoryViewmodel(
      toplAddress: currNetwork.myWalletAddress!.toplAddress,
      networkId: store.state.keychainState.currentNetwork.networkId,
      assets: store.state.keychainState.currentNetwork.getAllAssetsInWallet(),
      blockHeight: store.state.keychainState.currentNetwork.client!.getBlockNumber(),
      getTransactions: ({int pageNum = 0}) async {
        final myWalletAddress = currNetwork.myWalletAddress!.toplAddress.toBase58();
        final mempoolTxs = await getMempoolTxs(
          client: currNetwork.client!,
          walletAddress: myWalletAddress,
        );
        final genusTxs = await getGenusTxs(walletAddress: myWalletAddress);
        return [...mempoolTxs, ...genusTxs];
      },
    );
  }

  static Future<List<TransactionReceipt>> getMempoolTxs({
    required BramblClient client,
    required String walletAddress,
  }) async {
    final mempoolTxs = await client.getMempool();
    final pendingTxsForWallet = mempoolTxs.where((tx) {
      final walletAddrInSenders = tx.from?.any(
            (sender) => sender.senderAddress.toBase58() == walletAddress,
          ) ??
          false;
      // simple recipient or asset recipient
      final walletAddrInRecipients = tx.to.any((recipient) => recipient.toJson()[0] == walletAddress);
      return walletAddrInSenders || walletAddrInRecipients;
    }).toList();
    final List<TransactionReceipt> formattedTxs = [];
    pendingTxsForWallet.toList().forEach((rawTx) {
      rawTx.to.toList().forEach((recipient) {
        final tx = TransactionReceipt(
          id: rawTx.id,
          from: rawTx.from,
          to: [recipient],
          fee: rawTx.fee,
          newBoxes: rawTx.newBoxes,
          boxesToRemove: rawTx.boxesToRemove,
          timestamp: rawTx.timestamp,
          propositionType: rawTx.propositionType,
          txType: rawTx.txType,
          minting: rawTx.minting,
        );
        formattedTxs.add(tx);
      });
    });
    return formattedTxs;
  }

  static Future<List<TransactionReceipt>> getGenusTxs({
    required String walletAddress,
    int pageNumber = 0,
  }) async {
    final txQueryClient = TransactionsQueryClient(PlatformGenusConfig.channel);
    final txQueryResult = await txQueryClient.query(
      QueryTxsReq(
        filter: TransactionFilter(
          outputAddressSelection: StringSelection(
            values: [
              walletAddress,
              // 'AUAWPHb6iRfWs6a2QEkXYBLQefAYAczbcEcmeGJKgpmqYnooWis1',
            ],
          ),
        ),
        pagingOptions: Paging(pageNumber: pageNumber, pageSize: 10),
        confirmationDepth: 1,
      ),
    );
    final Map<String, dynamic> txResultJson = txQueryResult.toProto3Json() as Map<String, dynamic>;
    final List<TransactionReceipt> txs = [];
    for (var element in (txResultJson['success']['transactions'] as List)) {
      if (element['inputs'] == null) continue;
      try {
        final outputs = formatRecipients(element['outputs'] as List);
        final newBoxes = formatNewBoxes(element['newBoxes']);
        final inputs = (element['inputs'] as List).map((input) => [input['address'], input['nonce']]).toList();
        if (inputs.isEmpty) continue;
        // get tx per recipient
        outputs.toList().forEach((output) {
          final tx = TransactionReceipt.fromJson({
            'txId': element['txId'],
            'from': inputs,
            'to': [output],
            'txType': element['txType'],
            'fee': element['fee'],
            'timestamp': int.parse(element['timestamp']),
            'boxesToRemove': element['boxesToRemove'] as List,
            'newBoxes': newBoxes,
            'propositionType': element['propositionType'],
            'blockNumber': int.parse(element['blockHeight']),
            'blockId': element['blockId'],
            'minting': element['minting'],
          });
          txs.add(tx);
        });
      } catch (e) {
        debugPrint(e.toString());
        debugPrint(element);
        break;
      }
    }
    return txs;
  }

  static List<dynamic> formatRecipients(List<dynamic> outputs) {
    final formattedOutputs = [];
    outputs.toList().forEach((e) {
      final String address = e['address'];
      final String type = (e['value'] as Map<String, dynamic>).keys.first;
      final quantity = (e['value'] as Map<String, dynamic>)[type]['quantity'];
      final assetCode = (e['value'] as Map<String, dynamic>)[type]['code'];
      final securityRoot = (e['value'] as Map<String, dynamic>)[type]['securityRoot'];
      final metadata = (e['value'] as Map<String, dynamic>)[type]['metadata'];
      formattedOutputs.add([
        address,
        {
          'type': type == 'asset' ? 'Asset' : 'Simple',
          'quantity': quantity,
          'assetCode': assetCode,
          'securityRoot': securityRoot,
          'metadata': metadata
        }
      ]);
    });
    return formattedOutputs;
  }

  static formatNewBoxes(List<dynamic> newBoxes) {
    final formattedNewBoxes = [];
    newBoxes.toList().forEach((box) {
      final Map<String, dynamic> boxValue = box['value'];
      final String type = boxValue.keys.first;
      final quantity = boxValue[type]['quantity'];
      final assetCode = boxValue[type]['code'];
      final securityRoot = boxValue[type]['securityRoot'];
      final metadata = boxValue[type]['metadata'];
      final Map<String, dynamic> value = {
        'type': type,
        'quantity': quantity,
        'assetCode': assetCode,
        'securityRoot': securityRoot,
        'metadata': metadata
      };
      formattedNewBoxes.add({
        'id': box['id'],
        'type': box['boxType'],
        'evidence': box['evidence'],
        'nonce': box['nonce'],
        'value': value,
      });
    });
    return formattedNewBoxes;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TransactionHistoryViewmodel &&
        other.toplAddress == toplAddress &&
        other.networkId == networkId &&
        listEquals(other.assets, assets) &&
        other.blockHeight == blockHeight &&
        other.getTransactions == getTransactions;
  }

  @override
  int get hashCode {
    return toplAddress.hashCode ^
        networkId.hashCode ^
        assets.hashCode ^
        blockHeight.hashCode ^
        getTransactions.hashCode;
  }
}
