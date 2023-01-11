import 'dart:convert';
import 'dart:typed_data';

import 'package:redux/redux.dart';
import 'package:ribn/actions/misc_actions.dart';
import 'package:ribn/actions/restore_wallet_actions.dart';
import 'package:ribn/constants/rules.dart';
import 'package:ribn/models/app_state.dart';
import 'package:ribn/platform/platform.dart';
import 'package:ribn/repositories/login_repository.dart';
import 'package:ribn/repositories/onboarding_repository.dart';
import 'package:ribn/utils.dart';

/// Creates a list of middlewares to handle logic around the 'Restore Wallet' flow.
List<Middleware<AppState>> createRestorewalletMiddleware(
  OnboardingRespository onboardingRepo,
  LoginRepository loginRepo,
) {
  return <Middleware<AppState>>[
    TypedMiddleware<AppState, RestoreWalletWithMnemonicAction>(
        _restoreWalletWithMnemonic(onboardingRepo)),
    TypedMiddleware<AppState, RestoreWalletWithToplKeyAction>(
        _restoreWalletWithToplKey(loginRepo)),
  ];
}

/// Handles the [RestoreWalletWithMnemonicAction] action.
///
/// Uses the [action.mnemonic] and [action.password] to generate a keystore.
/// Dispatches [SuccessfullyRestoredWalletAction] if successfully generated keystore, otherwise [FailedToRestoreWalletAction].
void Function(Store<AppState> store, RestoreWalletWithMnemonicAction action,
        NextDispatcher next)
    _restoreWalletWithMnemonic(OnboardingRespository onboardingRepo) {
  return (store, action, next) async {
    try {
      final AppViews currAppView =
          await PlatformUtils.instance.getCurrentAppView();
      final Map<String, dynamic> results = jsonDecode(
        await PlatformWorkerRunner.instance.runWorker(
          workerScript: currAppView == AppViews.webDebug
              ? '/web/workers/generate_keystore_worker.js'
              : '/workers/generate_keystore_worker.js',
          function: onboardingRepo.generateKeyStore,
          params: {
            'mnemonic': action.mnemonic,
            'password': action.password,
          },
        ),
      );
      next(
        SuccessfullyRestoredWalletAction(
          keyStoreJson: results['keyStoreJson'],
          toplExtendedPrivateKey:
              uint8ListFromDynamic(results['toplExtendedPrvKeyUint8List']),
        ),
      );
    } catch (e) {
      next(ApiErrorAction(e.toString()));
    }
  };
}

/// Handles the [RestoreWalletWithToplKeyAction] action.
///
/// Attempts to decrypt [action.toplKeyStoreJson] using [action.password].
/// Dispatches [SuccessfullyRestoredWalletAction] upon success, otherwise [FailedToRestoreWalletAction].
void Function(Store<AppState> store, RestoreWalletWithToplKeyAction action,
    NextDispatcher next) _restoreWalletWithToplKey(LoginRepository loginRepo) {
  return (store, action, next) async {
    try {
      final Uint8List toplExtendedPrvKeyUint8List = loginRepo.decryptKeyStore({
        'keyStoreJson': action.toplKeyStoreJson,
        'password': action.password,
      });
      action.completer.complete(true);
      next(
        SuccessfullyRestoredWalletAction(
          keyStoreJson: action.toplKeyStoreJson,
          toplExtendedPrivateKey: toplExtendedPrvKeyUint8List,
        ),
      );
    } catch (e) {
      action.completer.complete(false);
    }
  };
}
