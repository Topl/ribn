import 'package:brambldart/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:ribn/actions/keychain_actions.dart';
import 'package:ribn/actions/misc_actions.dart';
import 'package:ribn/constants/routes.dart';
import 'package:ribn/models/app_state.dart';

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
  final int currentNetwork;
  final Function(String) updateNetwork;
  final List<AssetAmount> assets;
  final Function(AssetAmount) initiateSendAsset;

  WalletBalanceViewModel({
    required this.polyBalance,
    required this.updateNetwork,
    required this.currentNetwork,
    required this.assets,
    required this.initiateSendAsset,
  });
  static WalletBalanceViewModel fromStore(Store<AppState> store) {
    return WalletBalanceViewModel(
      polyBalance: store.state.keychainState.currentNetwork.addresses.fold(
        0,
        (prev, currBalance) => prev + currBalance.balance.polys.getInNanopoly,
      ),
      currentNetwork: store.state.keychainState.currentNetwork.networkId,
      updateNetwork: (String networkId) {
        store.dispatch(UpdateCurrentNetworkAction(networkId));
        store.dispatch(RefreshBalancesAction());
      },
      assets: store.state.keychainState.currentNetwork.addresses
          .map((addr) => addr.balance.assets ?? [])
          .expand((amount) => amount)
          .toList(),
      initiateSendAsset: (AssetAmount asset) => store.dispatch(
        NavigateToRoute(Routes.assetTransferInput, arguments: asset),
      ),
    );
  }
}
