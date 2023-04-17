// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:ribn/v1/platform/platform.dart';
import 'package:ribn/v1/providers/app_state_provider.dart';
import 'package:ribn/v1/providers/store_provider.dart';
import 'package:ribn/v1/providers/utility_provider.dart';
import 'package:ribn/v1/repositories/login_repository.dart';
import '../constants/keys.dart';
import '../constants/routes.dart';

final canDisconnectDAppsProvider = FutureProvider.autoDispose<bool>((ref) async {
  if (!kIsWeb) return false;

  final List<String> dApps = await PlatformUtils.instance.convertToFuture(PlatformUtils.instance.getDAppList());
  await PlatformUtils.instance.consoleLog(dApps.toString());

  return dApps.isNotEmpty;
});

final settingsProvider = Provider<SettingsNotifier>((ref) => SettingsNotifier(ref));

class SettingsNotifier {
  final Ref ref;

  SettingsNotifier(this.ref);

  void ExportToplMainKey() {
    final store = ref.read(storeProvider);
    ref.read(downloadFileProvider(File(fileName: 'topl_main_key.json', text: store.state.keychainState.keyStoreJson!)));
  }

  Future<void> DeleteWallet(String password, Completer<bool> completer) async {
    final store = ref.read(storeProvider);

    try {
      // Check if correct password was entered
      LoginRepository().decryptKeyStore(
        {
          'keyStoreJson': store.state.keychainState.keyStoreJson!,
          'password': password,
        },
      );

      // Reset and persist app state
      ref.read(appStateProvider.notifier).resetAppState();

      await PlatformLocalStorage.instance.saveState(store.state.toJson());
      if (kIsWeb) {
        await PlatformLocalStorage.instance.clearSessionStorage();
        PlatformUtils.instance.closeWindow();
      } else {
        await PlatformLocalStorage.instance.clearSecureStorage();
        await Keys.navigatorKey.currentState?.pushNamedAndRemoveUntil(Routes.welcome, (_) => false);
      }
    } catch (e) {
      // Complete with false to indicate error, i.e. incorrect password was entered
      completer.complete(false);
    }
  }
}
