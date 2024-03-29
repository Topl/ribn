// Dart imports:
import 'dart:async';
import 'dart:convert';

// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:ribn/v1/constants/keys.dart';
import 'package:ribn/v1/constants/routes.dart';
import 'package:ribn/v1/constants/rules.dart';
import 'package:ribn/v1/platform/mobile/utils.dart';
import 'package:ribn/v1/platform/mobile/worker_runner.dart';
import 'package:ribn/v1/providers/app_state_provider.dart';
import 'package:ribn/v1/providers/keychain_provider.dart';
import 'package:ribn/v1/repositories/login_repository.dart';
import 'package:ribn/v1/repositories/onboarding_repository.dart';
import 'package:ribn/v1/utils/error_handling_utils.dart';
import 'package:ribn/v1/utils/extensions.dart';

final restoreWalletProvider = StateNotifierProvider<RestoreWalletNotifier, void>((ref) {
  return RestoreWalletNotifier(ref);
});

class RestoreWalletNotifier extends StateNotifier<void> {
  final Ref ref;
  RestoreWalletNotifier(this.ref) : super(null);

  /// Uses the [mnemonic] and [password] to generate a keystore.
  Future<void> restoreWalletWithMnemonic({
    required String password,
    required String mnemonic,
  }) async {
    try {
      final AppViews currAppView = await PlatformUtils.instance.getCurrentAppView();
      final Map<String, dynamic> results = jsonDecode(
        await PlatformWorkerRunner.instance.runWorker(
          workerScript: currAppView == AppViews.webDebug
              ? '/web/workers/generate_keystore_worker.js'
              : '/workers/generate_keystore_worker.js',
          function: OnboardingRespository().generateKeyStore,
          params: {
            'mnemonic': mnemonic,
            'password': password,
          },
        ),
      );
      await _restoreFlow(
        toplExtendedPrivateKey: (results['toplExtendedPrvKeyUint8List'] as List<dynamic>).toUint8List(),
        keyStoreJson: results['keyStoreJson'],
      );
      const String navigateToRoute = kIsWeb ? Routes.extensionInfo : Routes.home;

      Keys.navigatorKey.currentState?.pushNamedAndRemoveUntil(navigateToRoute, (route) => false);
    } catch (e) {
      handleApiError(errorMessage: e.toString());
    }
  }

  /// Attempts to decrypt [toplKeyStoreJson] using [password].
  Future<void> restoreWalletWithToplKey({
    required String toplKeyStoreJson,
    required String password,
    required Completer<bool> completer,
  }) async {
    try {
      final Uint8List toplExtendedPrvKeyUint8List = LoginRepository().decryptKeyStore({
        'keyStoreJson': toplKeyStoreJson,
        'password': password,
      });
      completer.complete(true);
      await _restoreFlow(
        keyStoreJson: toplKeyStoreJson,
        toplExtendedPrivateKey: toplExtendedPrvKeyUint8List,
      );
    } catch (e) {
      completer.complete(false);
    }
  }

  Future<void> _restoreFlow({
    required toplExtendedPrivateKey,
    required keyStoreJson,
  }) async {
    await ref.read(appStateProvider.notifier).resetAppState();

    await ref.read(keychainProvider.notifier).initializeHdWallet(
          toplExtendedPrivateKey: toplExtendedPrivateKey,
          keyStoreJson: keyStoreJson,
        );

    await ref.read(appStateProvider.notifier).persistAppState();
  }
}
