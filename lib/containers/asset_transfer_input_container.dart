import 'dart:async';

import 'package:brambldart/brambldart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'package:ribn/actions/transaction_actions.dart';
import 'package:ribn/constants/network_utils.dart';
import 'package:ribn/constants/rules.dart';
import 'package:ribn/models/app_state.dart';
import 'package:ribn/models/asset_details.dart';
import 'package:ribn/models/ribn_network.dart';
import 'package:ribn/models/transfer_details.dart';

/// Intended to wrap the [AssetTransferInputPage] and provide it with the the [AssetTransferInputViewModel].
class AssetTransferInputContainer extends StatelessWidget {
  const AssetTransferInputContainer({
    Key? key,
    required this.builder,
  }) : super(key: key);
  final ViewModelBuilder<AssetTransferInputViewModel> builder;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AssetTransferInputViewModel>(
      distinct: true,
      converter: AssetTransferInputViewModel.fromStore,
      builder: builder,
    );
  }
}

class AssetTransferInputViewModel {
  /// All assets owned by this wallet.
  final List<AssetAmount> assets;

  /// The tx fee on the current network.
  final num networkFee;

  /// Locally stored asset details.
  final Map<String, AssetDetails> assetDetails;

  /// The current network.
  final RibnNetwork currentNetwork;

  /// Handler for initiating tx.
  final Future<void> Function({
    required String recipient,
    required String amount,
    required String note,
    required AssetCode assetCode,
    AssetDetails? assetDetails,
    required Function(bool success) onRawTxCreated,
  }) initiateTx;

  AssetTransferInputViewModel({
    required this.assets,
    required this.initiateTx,
    required this.networkFee,
    required this.assetDetails,
    required this.currentNetwork,
  });

  static AssetTransferInputViewModel fromStore(Store<AppState> store) {
    return AssetTransferInputViewModel(
      initiateTx: ({
        required String recipient,
        required String amount,
        required String note,
        required AssetCode assetCode,
        AssetDetails? assetDetails,
        required Function(bool success) onRawTxCreated,
      }) async {
        final TransferDetails transferDetails = TransferDetails(
          transferType: TransferType.assetTransfer,
          recipient: recipient,
          amount: amount,
          data: note,
          assetCode: assetCode,
          assetDetails: assetDetails,
        );
        final Completer<bool> actionCompleter = Completer();
        store.dispatch((InitiateTxAction(transferDetails, actionCompleter)));
        await actionCompleter.future.then(onRawTxCreated);
      },
      assets: store.state.keychainState.currentNetwork.getAllAssetsInWallet(),
      currentNetwork: store.state.keychainState.currentNetwork,
      networkFee: NetworkUtils.networkFees[store.state.keychainState.currentNetwork.networkId]!.getInNanopoly,
      assetDetails: store.state.userDetailsState.assetDetails,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AssetTransferInputViewModel &&
        listEquals(other.assets, assets) &&
        other.networkFee == networkFee &&
        mapEquals(other.assetDetails, assetDetails) &&
        other.currentNetwork == currentNetwork;
  }

  @override
  int get hashCode {
    return assets.hashCode ^ networkFee.hashCode ^ assetDetails.hashCode ^ currentNetwork.hashCode;
  }
}
