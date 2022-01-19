import 'package:brambldart/brambldart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'package:ribn/actions/transaction_actions.dart';
import 'package:ribn/constants/rules.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/models/app_state.dart';
import 'package:ribn/models/transfer_details.dart';

/// Intended to wrap the [MintInputPage] and provide it with the the [MintInputViewmodel].
class MintInputContainer extends StatelessWidget {
  const MintInputContainer({Key? key, required this.builder}) : super(key: key);
  final ViewModelBuilder<MintInputViewmodel> builder;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, MintInputViewmodel>(
      distinct: true,
      converter: MintInputViewmodel.fromStore,
      builder: builder,
    );
  }
}

class MintInputViewmodel {
  final void Function({
    required String assetShortName,
    required String amount,
    required String recipient,
    required String note,
    bool mintingToMyWallet,
  }) initiateTx;
  final bool loadingRawTx;
  final num networkFee;
  final List<AssetAmount> assets;
  final int currNetworkId;
  MintInputViewmodel({
    required this.initiateTx,
    required this.loadingRawTx,
    required this.networkFee,
    required this.assets,
    required this.currNetworkId,
  });

  static MintInputViewmodel fromStore(Store<AppState> store) {
    return MintInputViewmodel(
      initiateTx: ({
        required String assetShortName,
        required String amount,
        required String recipient,
        required String note,
        bool mintingToMyWallet = false,
      }) {
        final ToplAddress issuerAddress = store.state.keychainState.currentNetwork.myWalletAddress.address;
        final TransferDetails transferDetails = TransferDetails(
          transferType: Strings.minting,
          assetCode: AssetCode.initialize(
            Rules.assetCodeVersion,
            issuerAddress,
            assetShortName,
            Rules.networkStrings[store.state.keychainState.currentNetwork.networkId]!,
          ),
          recipient: mintingToMyWallet ? issuerAddress.toBase58() : recipient,
          amount: amount,
          data: note,
        );
        store.dispatch(InitiateTxAction(transferDetails));
      },
      loadingRawTx: store.state.uiState.loadingRawTx,
      assets: store.state.keychainState.currentNetwork.getAssetsIssuedByWallet(),
      currNetworkId: store.state.keychainState.currentNetwork.networkId,
      networkFee: Rules.networkFees[store.state.keychainState.currentNetwork.networkId]!.getInNanopoly,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MintInputViewmodel &&
        other.initiateTx == initiateTx &&
        other.loadingRawTx == loadingRawTx &&
        other.networkFee == networkFee &&
        listEquals(other.assets, assets) &&
        other.currNetworkId == currNetworkId;
  }

  @override
  int get hashCode {
    return initiateTx.hashCode ^ loadingRawTx.hashCode ^ networkFee.hashCode ^ assets.hashCode ^ currNetworkId.hashCode;
  }
}
