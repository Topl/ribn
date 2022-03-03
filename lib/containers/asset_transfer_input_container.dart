import 'package:brambldart/brambldart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'package:ribn/actions/transaction_actions.dart';
import 'package:ribn/constants/rules.dart';
import 'package:ribn/models/app_state.dart';
import 'package:ribn/models/asset_details.dart';
import 'package:ribn/models/transfer_details.dart';

/// Intended to wrap the [AssetTransferInputPage] and provide it with the the [AssetTransferInputViewModel].
class AssetTransferInputContainer extends StatelessWidget {
  const AssetTransferInputContainer({
    Key? key,
    required this.builder,
    this.onWillChange,
  }) : super(key: key);
  final ViewModelBuilder<AssetTransferInputViewModel> builder;
  final Function(AssetTransferInputViewModel?, AssetTransferInputViewModel)? onWillChange;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AssetTransferInputViewModel>(
      distinct: true,
      converter: AssetTransferInputViewModel.fromStore,
      builder: builder,
      onWillChange: onWillChange,
    );
  }
}

class AssetTransferInputViewModel {
  /// True if loading indicator needs to be shown while rawTx is being created.
  final bool loadingRawTx;

  /// All assets owned by this wallet.
  final List<AssetAmount> assets;

  /// The tx fee on the current network.
  final num networkFee;

  /// Locally stored asset details.
  final Map<String, AssetDetails> assetDetails;

  /// The current network ID.
  final int currNetworkId;

  /// True if unexpected error occurs while creating rawTx.
  final bool failedToCreateRawTx;

  /// Handler for initiating tx.
  final Function(
    String recipient,
    String amount,
    String note,
    AssetCode assetCode,
    AssetDetails? assetDetails,
  ) initiateTx;

  AssetTransferInputViewModel({
    required this.assets,
    required this.initiateTx,
    required this.loadingRawTx,
    required this.networkFee,
    required this.assetDetails,
    required this.currNetworkId,
    required this.failedToCreateRawTx,
  });

  static AssetTransferInputViewModel fromStore(Store<AppState> store) {
    return AssetTransferInputViewModel(
      initiateTx: (String recipient, String amount, String note, AssetCode assetCode, AssetDetails? assetDetails) {
        final TransferDetails transferDetails = TransferDetails(
          transferType: TransferType.assetTransfer,
          recipient: recipient,
          amount: amount,
          data: note,
          assetCode: assetCode,
          assetDetails: assetDetails,
        );
        store.dispatch((InitiateTxAction(transferDetails)));
      },
      assets: store.state.keychainState.currentNetwork.getAllAssetsInWallet(),
      loadingRawTx: store.state.uiState.loadingRawTx,
      currNetworkId: store.state.keychainState.currentNetwork.networkId,
      networkFee: Rules.networkFees[store.state.keychainState.currentNetwork.networkId]!.getInNanopoly,
      assetDetails: store.state.userDetailsState.assetDetails,
      failedToCreateRawTx: store.state.uiState.failedToCreateRawTx,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AssetTransferInputViewModel &&
        listEquals(other.assets, assets) &&
        other.initiateTx == initiateTx &&
        other.loadingRawTx == loadingRawTx &&
        other.networkFee == networkFee &&
        mapEquals(other.assetDetails, assetDetails) &&
        other.currNetworkId == currNetworkId &&
        other.failedToCreateRawTx == failedToCreateRawTx;
  }

  @override
  int get hashCode {
    return assets.hashCode ^
        initiateTx.hashCode ^
        loadingRawTx.hashCode ^
        networkFee.hashCode ^
        assetDetails.hashCode ^
        currNetworkId.hashCode ^
        failedToCreateRawTx.hashCode;
  }
}
