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
  /// The tx fee on the current network.
  final num networkFee;

  /// The list of assets previously issued/minted by this wallet.
  final List<AssetAmount> assets;

  /// The current network.
  final RibnNetwork currentNetwork;

  /// Locally stored asset details.
  final Map<String, AssetDetails> assetDetails;

  /// Handler for initiating mint asset tx.
  final Future<void> Function({
    required String assetShortName,
    required String amount,
    required String recipient,
    required String note,
    bool mintingToMyWallet,
    bool mintingNewAsset,
    AssetDetails? assetDetails,
    required Function(bool success) onRawTxCreated,
  }) initiateTx;

  MintInputViewmodel({
    required this.initiateTx,
    required this.networkFee,
    required this.assets,
    required this.currentNetwork,
    required this.assetDetails,
  });

  static MintInputViewmodel fromStore(Store<AppState> store) {
    return MintInputViewmodel(
      initiateTx: ({
        required String assetShortName,
        required String amount,
        required String recipient,
        required String note,
        bool mintingToMyWallet = false,
        bool mintingNewAsset = true,
        AssetDetails? assetDetails,
        required Function(bool success) onRawTxCreated,
      }) async {
        final ToplAddress issuerAddress = store.state.keychainState.currentNetwork.myWalletAddress.address;
        final TransferType transferType = mintingNewAsset ? TransferType.mintingAsset : TransferType.remintingAsset;
        final TransferDetails transferDetails = TransferDetails(
          transferType: transferType,
          assetCode: AssetCode.initialize(
            Rules.assetCodeVersion,
            issuerAddress,
            assetShortName,
            store.state.keychainState.currentNetwork.networkName,
          ),
          recipient: mintingToMyWallet ? issuerAddress.toBase58() : recipient,
          amount: amount,
          data: note,
          assetDetails: assetDetails,
        );
        final Completer<bool> actionCompleter = Completer();
        store.dispatch(InitiateTxAction(transferDetails, actionCompleter));
        await actionCompleter.future.then(onRawTxCreated);
      },
      assets: store.state.keychainState.currentNetwork.getAssetsIssuedByWallet(),
      currentNetwork: store.state.keychainState.currentNetwork,
      networkFee: NetworkUtils.networkFees[store.state.keychainState.currentNetwork.networkId]!.getInNanopoly,
      assetDetails: store.state.userDetailsState.assetDetails,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MintInputViewmodel &&
        other.networkFee == networkFee &&
        listEquals(other.assets, assets) &&
        other.currentNetwork == currentNetwork &&
        mapEquals(other.assetDetails, assetDetails);
  }

  @override
  int get hashCode {
    return networkFee.hashCode ^ assets.hashCode ^ currentNetwork.hashCode ^ assetDetails.hashCode;
  }
}
