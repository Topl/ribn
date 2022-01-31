import 'package:brambldart/model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'package:ribn/actions/misc_actions.dart';
import 'package:ribn/constants/routes.dart';
import 'package:ribn/models/app_state.dart';
import 'package:ribn/models/asset_details.dart';

/// Intended to wrap the [WalletBalancePage] and provide it with the the [WalletBalanceViewModel].
class WalletBalanceContainer extends StatelessWidget {
  const WalletBalanceContainer({Key? key, required this.builder}) : super(key: key);
  final ViewModelBuilder<WalletBalanceViewModel> builder;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, WalletBalanceViewModel>(
      distinct: true,
      converter: WalletBalanceViewModel.fromStore,
      builder: builder,
    );
  }
}

class WalletBalanceViewModel {
  final num polyBalance;
  final List<AssetAmount> assets;
  final Map<String, AssetDetails> assetDetails;
  final Function(AssetAmount) initiateSendAsset;
  final Function() initiateSendPolys;
  final bool failedToFetchBalances;
  final bool fetchingBalances;
  final Function(AssetAmount) viewAssetDetails;

  WalletBalanceViewModel({
    required this.polyBalance,
    required this.assets,
    required this.initiateSendAsset,
    required this.initiateSendPolys,
    required this.failedToFetchBalances,
    required this.fetchingBalances,
    required this.viewAssetDetails,
    required this.assetDetails,
  });
  static WalletBalanceViewModel fromStore(Store<AppState> store) {
    return WalletBalanceViewModel(
      polyBalance: store.state.keychainState.currentNetwork.getPolysInWallet(),
      assets: store.state.keychainState.currentNetwork.getAllAssetsInWallet(),
      assetDetails: store.state.userDetailsState.assetDetails,
      initiateSendAsset: (AssetAmount asset) => store.dispatch(
        NavigateToRoute(Routes.assetTransferInput, arguments: asset),
      ),
      initiateSendPolys: () => store.dispatch(NavigateToRoute(Routes.polyTransferInput)),
      failedToFetchBalances: store.state.uiState.failedToFetchBalances,
      fetchingBalances: store.state.uiState.fetchingBalances,
      viewAssetDetails: (AssetAmount assetAmount) => store.dispatch(
        NavigateToRoute(
          Routes.assetDetails,
          arguments: {
            'assetAmount': assetAmount,
          },
        ),
      ),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is WalletBalanceViewModel &&
        other.polyBalance == polyBalance &&
        listEquals(other.assets, assets) &&
        other.initiateSendAsset == initiateSendAsset &&
        other.initiateSendPolys == initiateSendPolys &&
        other.failedToFetchBalances == failedToFetchBalances &&
        other.fetchingBalances == fetchingBalances &&
        other.viewAssetDetails == viewAssetDetails;
  }

  @override
  int get hashCode {
    return polyBalance.hashCode ^
        assets.hashCode ^
        initiateSendAsset.hashCode ^
        initiateSendPolys.hashCode ^
        failedToFetchBalances.hashCode ^
        fetchingBalances.hashCode ^
        viewAssetDetails.hashCode;
  }
}
