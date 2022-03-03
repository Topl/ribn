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

/// Intended to wrap the [MintInputPage] and provide it with the the [MintInputViewmodel].
class MintInputContainer extends StatelessWidget {
  const MintInputContainer({Key? key, required this.builder, this.onWillChange}) : super(key: key);
  final ViewModelBuilder<MintInputViewmodel> builder;
  final Function(MintInputViewmodel?, MintInputViewmodel)? onWillChange;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, MintInputViewmodel>(
      distinct: true,
      converter: MintInputViewmodel.fromStore,
      builder: builder,
      onWillChange: onWillChange,
    );
  }
}

class MintInputViewmodel {
  /// True if loading indicator needs to be shown while rawTx is being created.
  final bool loadingRawTx;

  /// The tx fee on the current network.
  final num networkFee;

  /// The list of assets previously issued/minted by this wallet.
  final List<AssetAmount> assets;

  /// The current network ID.
  final int currNetworkId;

  /// Locally stored asset details.
  final Map<String, AssetDetails> assetDetails;

  /// True if unexpected error occurs while creating rawTx.
  final bool failedToCreateRawTx;

  /// Handler for initiating mint asset tx.
  final void Function({
    required String assetShortName,
    required String amount,
    required String recipient,
    required String note,
    bool mintingToMyWallet,
    bool mintingNewAsset,
    AssetDetails? assetDetails,
  }) initiateTx;

  MintInputViewmodel({
    required this.initiateTx,
    required this.loadingRawTx,
    required this.networkFee,
    required this.assets,
    required this.currNetworkId,
    required this.assetDetails,
    required this.failedToCreateRawTx,
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
      }) {
        final ToplAddress issuerAddress = store.state.keychainState.currentNetwork.myWalletAddress.address;
        final TransferType transferType = mintingNewAsset ? TransferType.mintingAsset : TransferType.remintingAsset;
        final TransferDetails transferDetails = TransferDetails(
          transferType: transferType,
          assetCode: AssetCode.initialize(
            Rules.assetCodeVersion,
            issuerAddress,
            assetShortName,
            Rules.networkStrings[store.state.keychainState.currentNetwork.networkId]!,
          ),
          recipient: mintingToMyWallet ? issuerAddress.toBase58() : recipient,
          amount: amount,
          data: note,
          assetDetails: assetDetails,
        );
        store.dispatch(InitiateTxAction(transferDetails));
      },
      loadingRawTx: store.state.uiState.loadingRawTx,
      assets: store.state.keychainState.currentNetwork.getAssetsIssuedByWallet(),
      currNetworkId: store.state.keychainState.currentNetwork.networkId,
      networkFee: Rules.networkFees[store.state.keychainState.currentNetwork.networkId]!.getInNanopoly,
      assetDetails: store.state.userDetailsState.assetDetails,
      failedToCreateRawTx: store.state.uiState.failedToCreateRawTx,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MintInputViewmodel &&
        other.loadingRawTx == loadingRawTx &&
        other.networkFee == networkFee &&
        listEquals(other.assets, assets) &&
        other.currNetworkId == currNetworkId &&
        mapEquals(other.assetDetails, assetDetails) &&
        other.failedToCreateRawTx == failedToCreateRawTx;
  }

  @override
  int get hashCode {
    return loadingRawTx.hashCode ^
        networkFee.hashCode ^
        assets.hashCode ^
        currNetworkId.hashCode ^
        assetDetails.hashCode ^
        failedToCreateRawTx.hashCode;
  }
}
