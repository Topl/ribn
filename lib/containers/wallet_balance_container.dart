import 'dart:async';

import 'package:brambldart/model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'package:ribn/actions/keychain_actions.dart';
import 'package:ribn/actions/misc_actions.dart';
import 'package:ribn/constants/routes.dart';
import 'package:ribn/models/app_state.dart';
import 'package:ribn/models/asset_details.dart';

/// Intended to wrap the [WalletBalancePage] and provide it with the the [WalletBalanceViewModel].
class WalletBalanceContainer extends StatelessWidget {
  final ViewModelBuilder<WalletBalanceViewModel> builder;
  final void Function(WalletBalanceViewModel vm) onInitialBuild;
  final void Function(WalletBalanceViewModel?, WalletBalanceViewModel) onWillChange;
  const WalletBalanceContainer({
    Key? key,
    required this.builder,
    required this.onInitialBuild,
    required this.onWillChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, WalletBalanceViewModel>(
      distinct: true,
      converter: WalletBalanceViewModel.fromStore,
      builder: builder,
      onInitialBuild: onInitialBuild,
      onWillChange: onWillChange,
    );
  }
}

class WalletBalanceViewModel {
  /// The current poly balance in the wallet.
  final num polyBalance;

  /// All the assets owned by this wallet.
  final List<AssetAmount> assets;

  /// Locally stored custom asset details.
  final Map<String, AssetDetails> assetDetails;

  /// Callback to initiate send asset flow, i.e. navigate to [Routes.assetTransferInput].
  final Function(AssetAmount) navigateToSendAsset;

  /// Callback to initiate send polys flow, i.e. navigate to [Routes.polyTransferInput].
  final Function() navigateToSendPolys;

  /// Callback to view asset details, i.e. navigate to [Routes.assetDetails].
  final Function(AssetAmount) viewAssetDetails;

  /// Callback to refresh balances.
  final void Function({required Function(bool success) onBalancesRefreshed}) refreshBalances;

  final int networkId;

  WalletBalanceViewModel({
    required this.polyBalance,
    required this.assets,
    required this.navigateToSendAsset,
    required this.navigateToSendPolys,
    required this.viewAssetDetails,
    required this.assetDetails,
    required this.refreshBalances,
    required this.networkId,
  });
  static WalletBalanceViewModel fromStore(Store<AppState> store) {
    return WalletBalanceViewModel(
      polyBalance: store.state.keychainState.currentNetwork.getPolysInWallet(),
      assets: store.state.keychainState.currentNetwork.getAllAssetsInWallet(),
      assetDetails: store.state.userDetailsState.assetDetails,
      navigateToSendAsset: (AssetAmount asset) => store.dispatch(
        NavigateToRoute(Routes.assetTransferInput, arguments: asset),
      ),
      navigateToSendPolys: () => store.dispatch(NavigateToRoute(Routes.polyTransferInput)),
      viewAssetDetails: (AssetAmount assetAmount) => store.dispatch(
        NavigateToRoute(
          Routes.assetDetails,
          arguments: {
            'assetAmount': assetAmount,
          },
        ),
      ),
      refreshBalances: ({required Function(bool success) onBalancesRefreshed}) {
        final Completer<bool> actionCompleter = Completer();
        store.dispatch(RefreshBalancesAction(actionCompleter));
        actionCompleter.future.then((bool value) => onBalancesRefreshed(value));
      },
      networkId: store.state.keychainState.currentNetwork.networkId,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is WalletBalanceViewModel &&
        other.polyBalance == polyBalance &&
        listEquals(other.assets, assets) &&
        mapEquals(other.assetDetails, assetDetails) &&
        other.navigateToSendAsset == navigateToSendAsset &&
        other.navigateToSendPolys == navigateToSendPolys &&
        other.viewAssetDetails == viewAssetDetails &&
        other.networkId == networkId;
  }

  @override
  int get hashCode {
    return polyBalance.hashCode ^
        assets.hashCode ^
        assetDetails.hashCode ^
        navigateToSendAsset.hashCode ^
        navigateToSendPolys.hashCode ^
        viewAssetDetails.hashCode ^
        networkId.hashCode;
  }
}
