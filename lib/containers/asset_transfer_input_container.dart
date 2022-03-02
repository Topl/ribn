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
  final List<AssetAmount> assets;
  final Function(String, String, String, AssetCode, AssetDetails?) initiateTx;
  final bool loadingRawTx;
  final num networkFee;
  final Map<String, AssetDetails> assetDetails;
  final int currNetworkId;

  AssetTransferInputViewModel({
    required this.assets,
    required this.initiateTx,
    required this.loadingRawTx,
    required this.networkFee,
    required this.assetDetails,
    required this.currNetworkId,
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
      assets: store.state.keychainState.currentNetwork.addresses
          .map((addr) => addr.balance.assets ?? [])
          .expand((amount) => amount)
          .toList(),
      loadingRawTx: store.state.uiState.loadingRawTx,
      currNetworkId: store.state.keychainState.currentNetwork.networkId,
      networkFee: Rules.networkFees[store.state.keychainState.currentNetwork.networkId]!.getInNanopoly,
      assetDetails: store.state.userDetailsState.assetDetails,
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
        other.currNetworkId == currNetworkId;
  }

  @override
  int get hashCode {
    return assets.hashCode ^
        initiateTx.hashCode ^
        loadingRawTx.hashCode ^
        networkFee.hashCode ^
        assetDetails.hashCode ^
        currNetworkId.hashCode;
  }
}
