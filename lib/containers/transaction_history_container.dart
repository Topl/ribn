import 'package:brambldart/brambldart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:ribn/models/app_state.dart';

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

  TransactionHistoryViewmodel({
    required this.toplAddress,
    required this.networkId,
    required this.assets,
    this.blockHeight,
  });

  static TransactionHistoryViewmodel fromStore(Store<AppState> store) {
    return TransactionHistoryViewmodel(
      toplAddress: store.state.keychainState.currentNetwork.myWalletAddress!.toplAddress,
      networkId: store.state.keychainState.currentNetwork.networkId,
      assets: store.state.keychainState.currentNetwork.getAllAssetsInWallet(),
      blockHeight: store.state.keychainState.currentNetwork.client!.getBlockNumber(),
    );
  }
}
