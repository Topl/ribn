import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
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

  HomeViewModel({
    this.addresses = const [],
    required this.displayAddress,
  });
  static HomeViewModel fromStore(Store<AppState> store) {
    return HomeViewModel(
      addresses: store.state.keyChainState.addresses,
      displayAddress: store.state.keyChainState.addresses[0].address.toBase58(),
    );
  }
}
