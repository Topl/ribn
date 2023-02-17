import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:local_auth/local_auth.dart';
import 'package:redux/redux.dart';
import 'package:ribn/models/app_state.dart';
import 'package:ribn/platform/platform.dart';
import 'package:ribn/presentation/settings/sections/disconnect_wallet_confirmation_dialog.dart';
import 'package:ribn/providers/store_provider.dart';
import 'package:ribn/providers/utility_provider.dart';

// import 'package:ribn/utils.dart';
import '../actions/misc_actions.dart';
import '../presentation/settings/sections/delete_wallet_confirmation_dialog.dart';



final canDisconnectDAppsProvider =
    FutureProvider.autoDispose<bool>((ref) async {
  if (!kIsWeb) return false;

  final List<String> dApps = await PlatformUtils.instance
      .convertToFuture(PlatformUtils.instance.getDAppList());
  await PlatformUtils.instance.consoleLog(dApps.toString());

  return dApps.isNotEmpty;
});

final settingsProvider =
    StateNotifierProvider<SettingsNotifier, SettingState>(
        (ref) => SettingsNotifier(ref));

class SettingsNotifier extends StateNotifier<SettingState> {
  final Ref ref;

  SettingsNotifier(this.ref)
      : super(SettingState.fromStore(ref.read(storeProvider))) {}
}

class SettingState {
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

  SettingState({
    required this.exportToplMainKey,
    required this.onDeletePressed,
    required this.onDisconnectPressed,
    required this.appVersion,
    required this.isBiometricsEnabled,
  });

  static SettingState fromStore(Store<AppState> store) {
    final container = ProviderContainer();

    return SettingState(
      exportToplMainKey: () => store.dispatch(
        DownloadAsFileAction(
          'topl_main_key.json',
          store.state.keychainState.keyStoreJson!,
        ),
      ),
      onDeletePressed: (BuildContext context) async =>
          _onDeletePressed(context, store),
      onDisconnectPressed: _onDisconnectPressed,
      appVersion: container.read(appVersionProvider),
      isBiometricsEnabled: store.state.userDetailsState.isBiometricsEnabled,
    );
  }

  static Future<void> _onDisconnectPressed(BuildContext context) async {
    final dApps = await PlatformUtils.instance
        .convertToFuture(PlatformUtils.instance.getDAppList());
    await showDialog(
      context: context,
      builder: (context) => DisconnectWalletConfirmationDialog(dApps: dApps),
    );
  }

  static _onDeletePressed(BuildContext context, Store<AppState> store) async {
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
  }
}
