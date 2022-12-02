// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:ribn/actions/misc_actions.dart';
import 'package:ribn/models/app_state.dart';
import 'package:ribn/platform/platform.dart';
import 'package:ribn/presentation/settings/sections/delete_wallet_confirmation_dialog.dart';
import 'package:ribn/presentation/settings/sections/disconnect_wallet_confirmation_dialog.dart';


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
  /// Callback to download the Topl Main Key.
  final VoidCallback exportToplMainKey;

  /// Handler for when user selects 'delete wallet'
  final Future<void> Function(BuildContext context) onDeletePressed;

  /// Handler for when user selects 'disconnect wallet'
  final Future<void> Function(BuildContext context) onDisconnectPressed;

  /// The current app version.
  final String appVersion;

  /// True if biometrics authentication is enabled
  final bool isBiometricsEnabled;

  bool canDisconnect = false;

  SettingsViewModel({
    required this.exportToplMainKey,
    required this.onDeletePressed,
    required this.onDisconnectPressed,
    required this.appVersion,
    required this.isBiometricsEnabled,
  });

  static SettingsViewModel fromStore(Store<AppState> store) {
    return SettingsViewModel(
      exportToplMainKey: () => store.dispatch(
        DownloadAsFileAction(
          'topl_main_key.json',
          store.state.keychainState.keyStoreJson!,
        ),
      ),
      onDeletePressed: (BuildContext context) async {
        await showDialog(
          context: context,
          builder: (context) => DeleteWalletConfirmationDialog(
            onConfirmDeletePressed: (
              String password,
              VoidCallback onIncorrectPasswordEntered,
            ) async {
              final Completer<bool> actionCompleter = Completer();
              store.dispatch(
                DeleteWalletAction(
                  password: password,
                  completer: actionCompleter,
                ),
              );
              // onIncorrectPasswordEntered called if response returned is false
              await actionCompleter.future.then((value) {
                if (!value) onIncorrectPasswordEntered();
              });
            },
          ),
        );
      },
      onDisconnectPressed: (BuildContext context) async {
        final dApps = await PlatformUtils.instance
            .convertToFuture(PlatformUtils.instance.getDAppList());
        await PlatformUtils.instance.consoleLog(dApps);
        // final bool disconnectResult =
        await showDialog(
          context: context,
          builder: (context) =>
              DisconnectWalletConfirmationDialog(dApps: dApps),
        );
      },
      appVersion: store.state.appVersion,
      isBiometricsEnabled: store.state.userDetailsState.isBiometricsEnabled,
    );
  }

  @override
  bool operator ==(covariant SettingsViewModel other) {
    if (identical(this, other)) return true;

    return other.exportToplMainKey == exportToplMainKey &&
        other.onDeletePressed == onDeletePressed &&
        other.appVersion == appVersion &&
        other.isBiometricsEnabled == isBiometricsEnabled;
  }

  @override
  int get hashCode {
    return exportToplMainKey.hashCode ^
        onDeletePressed.hashCode ^
        appVersion.hashCode ^
        isBiometricsEnabled.hashCode;
  }
}
