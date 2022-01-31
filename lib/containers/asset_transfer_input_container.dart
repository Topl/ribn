import 'package:brambldart/brambldart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'package:ribn/actions/transaction_actions.dart';
import 'package:ribn/constants/rules.dart';
import 'package:ribn/models/app_state.dart';
import 'package:ribn/models/transfer_details.dart';

/// Intended to wrap the [AssetTransferInputPage] and provide it with the the [AssetTransferInputViewModel].
class AssetTransferInputContainer extends StatelessWidget {
  const AssetTransferInputContainer({Key? key, required this.builder}) : super(key: key);
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
  final Function(String, String, String, AssetCode) initiateTx;
  final bool loadingRawTx;
  final num networkFee;

  AssetTransferInputViewModel({
    required this.assets,
    required this.initiateTx,
    required this.loadingRawTx,
    required this.networkFee,
  });

  static AssetTransferInputViewModel fromStore(Store<AppState> store) {
    return AssetTransferInputViewModel(
      initiateTx: (String recipient, String amount, String note, AssetCode assetCode) {
        final TransferDetails transferDetails = TransferDetails(
          transferType: TransferType.assetTransfer,
          recipient: recipient,
          amount: amount,
          data: note,
          assetCode: assetCode,
        );
        store.dispatch((InitiateTxAction(transferDetails)));
      },
      assets: store.state.keychainState.currentNetwork.addresses
          .map((addr) => addr.balance.assets ?? [])
          .expand((amount) => amount)
          .toList(),
      loadingRawTx: store.state.uiState.loadingRawTx,
      networkFee: Rules.networkFees[store.state.keychainState.currentNetwork.networkId]!.getInNanopoly,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AssetTransferInputViewModel &&
        listEquals(other.assets, assets) &&
        other.initiateTx == initiateTx &&
        other.loadingRawTx == loadingRawTx &&
        other.networkFee == networkFee;
  }

  @override
  int get hashCode {
    return assets.hashCode ^ initiateTx.hashCode ^ loadingRawTx.hashCode ^ networkFee.hashCode;
  }
}
