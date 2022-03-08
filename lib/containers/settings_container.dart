import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'package:ribn/actions/misc_actions.dart';
import 'package:ribn/models/app_state.dart';

/// Intended to wrap the [SettingsPage] and provide it with the the [SettingsViewModel].
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
  /// Callback to download Topl Main Key
  final VoidCallback exportToplMainKey;

  /// Handler for deleting the wallet.
  final void Function({
    required String password,
    required VoidCallback onIncorrectPasswordEntered,
  }) deleteWallet;

  /// The current app version.
  final String appVersion;

  SettingsViewModel({
    required this.exportToplMainKey,
    required this.deleteWallet,
    required this.appVersion,
  });
  static SettingsViewModel fromStore(Store<AppState> store) {
    return SettingsViewModel(
      exportToplMainKey: () => store.dispatch(
        DownloadAsFileAction(
          'topl_main_key.json',
          store.state.keychainState.keyStoreJson!,
        ),
      ),
      deleteWallet: ({
        required String password,
        required VoidCallback onIncorrectPasswordEntered,
      }) {
        final Completer<bool> actionCompleter = Completer();
        store.dispatch(
          DeleteWalletAction(
            password: password,
            completer: actionCompleter,
          ),
        );
        actionCompleter.future.asStream().listen((event) {
          if (event == false) onIncorrectPasswordEntered();
        });
      },
      appVersion: store.state.appVersion,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SettingsViewModel && other.exportToplMainKey == exportToplMainKey && other.appVersion == appVersion;
  }

  @override
  int get hashCode => exportToplMainKey.hashCode ^ appVersion.hashCode;
}
