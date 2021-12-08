import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'package:ribn/actions/misc_actions.dart';
import 'package:ribn/models/app_state.dart';

class SettingsContainer extends StatelessWidget {
  const SettingsContainer({Key? key, required this.builder}) : super(key: key);
  final ViewModelBuilder<SettingsViewModel> builder;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, SettingsViewModel>(
      distinct: true,
      converter: SettingsViewModel.fromStore,
      builder: builder,
    );
  }
}

class SettingsViewModel {
  final VoidCallback exportKeyStore;
  final VoidCallback deleteWallet;
  SettingsViewModel({
    required this.exportKeyStore,
    required this.deleteWallet,
  });
  static SettingsViewModel fromStore(Store<AppState> store) {
    return SettingsViewModel(
      exportKeyStore: () => store.dispatch(DownloadAsFile('keystore.json', store.state.keychainState.keyStoreJson!)),
      deleteWallet: () => store.dispatch(const DeleteWalletAction()),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SettingsViewModel && other.exportKeyStore == exportKeyStore && other.deleteWallet == deleteWallet;
  }

  @override
  int get hashCode => exportKeyStore.hashCode ^ deleteWallet.hashCode;
}
