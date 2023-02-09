import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ribn/actions/restore_wallet_actions.dart';
import 'package:ribn/constants/rules.dart';
import 'package:ribn/platform/mobile/utils.dart';
import 'package:ribn/platform/mobile/worker_runner.dart';
import 'package:ribn/providers/store_provider.dart';
import 'package:ribn/repositories/login_repository.dart';
import 'package:ribn/repositories/onboarding_repository.dart';
import 'package:ribn/utils.dart';
import 'package:ribn/utils/error_handling_utils.dart';

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

      ref.read(storeProvider).dispatch(
            SuccessfullyRestoredWalletAction(
              keyStoreJson: results['keyStoreJson'],
              toplExtendedPrivateKey: uint8ListFromDynamic(results['toplExtendedPrvKeyUint8List']),
            ),
          );
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
      ref.read(storeProvider).dispatch(
            SuccessfullyRestoredWalletAction(
              keyStoreJson: toplKeyStoreJson,
              toplExtendedPrivateKey: toplExtendedPrvKeyUint8List,
            ),
          );
    } catch (e) {
      completer.complete(false);
    }
  }
}
