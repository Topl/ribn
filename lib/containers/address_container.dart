import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:ribn/actions/keychain_actions.dart';
import 'package:ribn/actions/misc_actions.dart';
import 'package:ribn/models/ribn_address.dart';
import 'package:ribn/models/app_state.dart';

class AddressesContainer extends StatelessWidget {
  const AddressesContainer({Key? key, required this.builder}) : super(key: key);
  final ViewModelBuilder<AddressesViewModel> builder;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AddressesViewModel>(
      distinct: true,
      converter: (store) => AddressesViewModel.fromStore(store),
      builder: builder,
    );
  }
}

class AddressesViewModel {
  final List<RibnAddress> addresses;
  final Function generateNewAddress;

  AddressesViewModel({
    this.addresses = const [],
    required this.generateNewAddress,
  });
  static AddressesViewModel fromStore(Store<AppState> store) {
    return AddressesViewModel(
        addresses: store.state.keychainState.addresses,
        generateNewAddress: () {
          try {
            int nextAddrIdx = store.state.keychainState.getNextExternalAddressIndex();
            store.dispatch(GenerateAddressAction(nextAddrIdx));
          } catch (e) {
            store.dispatch(ApiErrorAction(e.toString()));
          }
        });
  }
}
