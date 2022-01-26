import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'package:ribn/actions/transaction_actions.dart';
import 'package:ribn/constants/rules.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/models/app_state.dart';
import 'package:ribn/models/transfer_details.dart';

/// Intended to wrap the [PolyTransferInputPage] and provide it with the the [PolyTransferInputViewModel].
class PolyTransferInputContainer extends StatelessWidget {
  const PolyTransferInputContainer({Key? key, required this.builder}) : super(key: key);
  final ViewModelBuilder<PolyTransferInputViewModel> builder;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, PolyTransferInputViewModel>(
      distinct: true,
      converter: PolyTransferInputViewModel.fromStore,
      builder: builder,
    );
  }
}

/// ViewModel for [PolyTransferInputPage]
class PolyTransferInputViewModel {
  final void Function({
    required String amount,
    required String recipient,
    required String note,
    bool mintingToMyWallet,
  }) initiateTx;

  /// True if loading raw tx.
  final bool loadingRawTx;

  /// Tx fee for the current network.
  final num networkFee;

  /// Current network id.
  final int currNetworkId;
  PolyTransferInputViewModel({
    required this.initiateTx,
    required this.loadingRawTx,
    required this.networkFee,
    required this.currNetworkId,
  });

  static PolyTransferInputViewModel fromStore(Store<AppState> store) {
    return PolyTransferInputViewModel(
      initiateTx: ({
        required String amount,
        required String recipient,
        required String note,
        bool mintingToMyWallet = false,
      }) {
        final TransferDetails transferDetails = TransferDetails(
          transferType: Strings.polyTransfer,
          senders: [store.state.keychainState.currentNetwork.myWalletAddress],
          recipient: recipient,
          amount: amount,
          data: note,
        );
        store.dispatch(InitiateTxAction(transferDetails));
      },
      loadingRawTx: store.state.uiState.loadingRawTx,
      currNetworkId: store.state.keychainState.currentNetwork.networkId,
      networkFee: Rules.networkFees[store.state.keychainState.currentNetwork.networkId]!.getInNanopoly,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PolyTransferInputViewModel &&
        other.loadingRawTx == loadingRawTx &&
        other.networkFee == networkFee &&
        other.currNetworkId == currNetworkId;
  }

  @override
  int get hashCode {
    return loadingRawTx.hashCode ^ networkFee.hashCode ^ currNetworkId.hashCode;
  }
}
