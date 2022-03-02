import 'dart:typed_data';

import 'package:redux/redux.dart';
import 'package:ribn/actions/restore_wallet_actions.dart';
import 'package:ribn/models/app_state.dart';
import 'package:ribn/repositories/login_repository.dart';
import 'package:ribn/repositories/onboarding_repository.dart';

/// Creates a list of middlewares to handle logic around the 'Restore Wallet' flow.
List<Middleware<AppState>> createRestorewalletMiddleware(
  OnboardingRespository onboardingRepo,
  LoginRepository loginRepo,
) {
  return <Middleware<AppState>>[
    TypedMiddleware<AppState, RestoreWalletWithMnemonicAction>(_restoreWalletWithMnemonic(onboardingRepo)),
    TypedMiddleware<AppState, RestoreWalletWithToplKeyAction>(_restoreWalletWithToplKey(loginRepo)),
  ];
}

/// Handles the [RestoreWalletWithMnemonicAction] action.
///
/// Uses the [action.mnemonic] and [action.password] to generate a keystore.
/// Dispatches [SuccessfullyRestoredWalletAction] if successfully generated keystore, otherwise [FailedToRestoreWalletAction].
void Function(Store<AppState> store, RestoreWalletWithMnemonicAction action, NextDispatcher next)
    _restoreWalletWithMnemonic(OnboardingRespository onboardingRepo) {
  return (store, action, next) async {
    try {
      final Map<String, dynamic> results = onboardingRepo.generateKeyStore(
        mnemonic: action.mnemonic,
        password: action.password,
      );
      next(
        SuccessfullyRestoredWalletAction(
          keyStoreJson: results['keyStoreJson'],
          toplExtendedPrivateKey: results['toplExtendedPrvKeyUint8List'],
        ),
      );
    } catch (e) {
      next(FailedToRestoreWalletAction());
    }
  };
}

/// Handles the [RestoreWalletWithToplKeyAction] action.
///
/// Attempts to decrypt [action.toplKeyStoreJson] using [action.password].
/// Dispatches [SuccessfullyRestoredWalletAction] upon success, otherwise [FailedToRestoreWalletAction].
void Function(Store<AppState> store, RestoreWalletWithToplKeyAction action, NextDispatcher next)
    _restoreWalletWithToplKey(LoginRepository loginRepo) {
  return (store, action, next) async {
    try {
      final Uint8List toplExtendedPrvKeyUint8List = loginRepo.decryptKeyStore(
        keyStoreJson: action.toplKeyStoreJson,
        password: action.password,
      );
      next(
        SuccessfullyRestoredWalletAction(
          keyStoreJson: action.toplKeyStoreJson,
          toplExtendedPrivateKey: toplExtendedPrvKeyUint8List,
        ),
      );
    } catch (e) {
      next(FailedToRestoreWalletAction());
    }
  };
}
