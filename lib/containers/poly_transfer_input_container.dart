// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

// Project imports:
import 'package:ribn/actions/misc_actions.dart';
import 'package:ribn/actions/transaction_actions.dart';
import 'package:ribn/constants/keys.dart';
import 'package:ribn/constants/network_utils.dart';
import 'package:ribn/constants/routes.dart';
import 'package:ribn/constants/rules.dart';
import 'package:ribn/models/app_state.dart';
import 'package:ribn/models/ribn_network.dart';
import 'package:ribn/models/transfer_details.dart';

/// Intended to wrap the [PolyTransferInputPage] and provide it with the the [PolyTransferInputViewModel].
class PolyTransferInputContainer extends StatelessWidget {
  const PolyTransferInputContainer({Key? key, required this.builder})
      : super(key: key);
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
  /// Tx fee for the current network.
  final num networkFee;

  /// Current network id.
  final RibnNetwork currentNetwork;

  /// Maximum amount available for transfer.
  final num maxTransferrableAmount;

  /// Allows redirect to asset transfer input through redux action
  final Function navigateToSendAssets;

  /// Handler for initiating poly transfer tx.
  final Future<void> Function({
    required String amount,
    required String recipient,
    required String note,
    bool mintingToMyWallet,
    required void Function(bool success) onRawTxCreated,
  }) initiateTx;

  PolyTransferInputViewModel({
    required this.initiateTx,
    required this.networkFee,
    required this.currentNetwork,
    required this.maxTransferrableAmount,
    required this.navigateToSendAssets,
  });

  static PolyTransferInputViewModel fromStore(Store<AppState> store) {
    final num networkFee = NetworkUtils
        .networkFees[store.state.keychainState.currentNetwork.networkId]!
        .getInNanopoly;
    return PolyTransferInputViewModel(
      initiateTx: ({
        required String amount,
        required String recipient,
        required String note,
        bool mintingToMyWallet = false,
        required void Function(bool success) onRawTxCreated,
      }) async {
        final TransferDetails transferDetails = TransferDetails(
          transferType: TransferType.polyTransfer,
          senders: [store.state.keychainState.currentNetwork.myWalletAddress!],
          recipient: recipient,
          amount: amount,
          data: note,
        );
        final Completer<TransferDetails?> rawTxCompleter = Completer();
        store.dispatch(InitiateTxAction(transferDetails, rawTxCompleter));
        await rawTxCompleter.future.then(
          (TransferDetails? transferDetails) {
            final success = transferDetails != null;
            onRawTxCreated(success);
            Keys.navigatorKey.currentState
                ?.pushNamed(Routes.txReview, arguments: transferDetails);
          },
        );
      },
      currentNetwork: store.state.keychainState.currentNetwork,
      networkFee: networkFee,
      maxTransferrableAmount:
          store.state.keychainState.currentNetwork.getPolysInWallet() -
              networkFee,
      navigateToSendAssets: () =>
          store.dispatch(NavigateToRoute(Routes.assetsTransferInput)),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PolyTransferInputViewModel &&
        other.networkFee == networkFee &&
        other.currentNetwork == currentNetwork;
  }

  @override
  int get hashCode => networkFee.hashCode ^ currentNetwork.hashCode;
}
