import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:ribn/actions/keychain_actions.dart';
import 'package:ribn/models/ribn_address.dart';
import 'package:ribn/models/app_state.dart';

class HomeContainer extends StatelessWidget {
  const HomeContainer({Key? key, required this.builder}) : super(key: key);
  final ViewModelBuilder<HomeViewModel> builder;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, HomeViewModel>(
      distinct: true,
      converter: (store) => HomeViewModel.fromStore(store),
      builder: builder,
    );
  }
}

class HomeViewModel {
  final List<RibnAddress> addresses;
  final String displayAddress;
  final List<String> networks;
  final String currentNetwork;
  final Function(String) updateNetwork;

  HomeViewModel({
    this.addresses = const [],
    required this.displayAddress,
    required this.networks,
    required this.updateNetwork,
    required this.currentNetwork,
  });
  static HomeViewModel fromStore(Store<AppState> store) {
    return HomeViewModel(
      addresses: store.state.keychainState.currentNetwork.addresses,
      displayAddress: store.state.keychainState.currentNetwork.addresses[0]?.address?.toBase58() ?? "",
      networks: store.state.keychainState.networks.map((e) => e.networkId.toString()).toList(),
      currentNetwork: store.state.keychainState.currentNetwork.networkId.toString(),
      updateNetwork: (String networkId) => store.dispatch(UpdateCurrentNetworkAction(networkId)),
    );
  }
}
