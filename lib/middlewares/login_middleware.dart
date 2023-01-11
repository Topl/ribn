import 'dart:convert';
import 'dart:typed_data';

import 'package:bip_topl/bip_topl.dart';

import 'package:redux/redux.dart';
import 'package:ribn/actions/keychain_actions.dart';
import 'package:ribn/actions/login_actions.dart';
import 'package:ribn/constants/rules.dart';
import 'package:ribn/models/app_state.dart';
import 'package:ribn/platform/platform.dart';
import 'package:ribn/repositories/login_repository.dart';
import 'package:ribn/utils.dart';

List<Middleware<AppState>> createLoginMiddleware(
    LoginRepository loginRepository) {
  return <Middleware<AppState>>[
    TypedMiddleware<AppState, AttemptLoginAction>(
        _verifyPassword(loginRepository)),
  ];
}

/// Verifies that the wallet password is correct by attempting to decrypt the keystore.
void Function(
        Store<AppState> store, AttemptLoginAction action, NextDispatcher next)
    _verifyPassword(
  LoginRepository loginRepository,
) {
  return (store, action, next) async {
    try {
      final AppViews currAppView =
          await PlatformUtils.instance.getCurrentAppView();
      // create isolate/worker to avoid hanging the UI
      final List result = jsonDecode(
        await PlatformWorkerRunner.instance.runWorker(
          workerScript: currAppView == AppViews.webDebug
              ? '/web/workers/login_worker.js'
              : '/workers/login_worker.js',
          function: loginRepository.decryptKeyStore,
          params: {
            'keyStoreJson': store.state.keychainState.keyStoreJson,
            'password': action.password,
          },
        ),
      );
      final Uint8List toplExtendedPrvKeyUint8List =
          uint8ListFromDynamic(result);
      // if extension: key is temporarily stored in `chrome.storage.session` & session alarm created
      // if mobile: key is persisted securely in secure storage
      if (currAppView == AppViews.extension ||
          currAppView == AppViews.extensionTab) {
        await PlatformLocalStorage.instance.saveKeyInSessionStorage(
          Base58Encoder.instance.encode(toplExtendedPrvKeyUint8List),
        );
        PlatformUtils.instance.createLoginSessionAlarm();
      } else if (currAppView == AppViews.mobile) {
        await PlatformLocalStorage.instance.saveKeyInSecureStorage(
          Base58Encoder.instance.encode(toplExtendedPrvKeyUint8List),
        );
      }
      // initialize hd wallet on success
      next(InitializeHDWalletAction(
          toplExtendedPrivateKey: toplExtendedPrvKeyUint8List));

      //Generate Initial addresses for every network
      next(GenerateInitialAddressesAction());

      action.completer.complete(true);
    } catch (e) {
      action.completer.complete(false);
    }
  };
}
