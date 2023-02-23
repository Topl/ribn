// Dart imports:
import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:bip_topl/bip_topl.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ribn/actions/keychain_actions.dart';
import 'package:ribn/constants/rules.dart';
import 'package:ribn/models/state/login_state.dart';
import 'package:ribn/platform/platform.dart';
import 'package:ribn/providers/store_provider.dart';
import 'package:ribn/repositories/login_repository.dart';
import 'package:ribn/utils.dart';

final loginProvider = StateNotifierProvider<LoginNotifier, LoginState>((ref) => LoginNotifier(ref));

class LoginNotifier extends StateNotifier<LoginState> {
  final Ref ref;

  LoginNotifier(this.ref) : super(LoginState.fromStore(ref.read(storeProvider))) {}

  // Verifies that the wallet password is correct by attempting to decrypt the keystore.
  Future<void> verifyPassword(AttemptLoginAction action) async {
    try {
      final AppViews currAppView = await PlatformUtils.instance.getCurrentAppView();

      final store = ProviderContainer().read(storeProvider);

      // create isolate/worker to avoid hanging the UI
      final List result = jsonDecode(
        await PlatformWorkerRunner.instance.runWorker(
          workerScript: currAppView == AppViews.webDebug ? '/web/workers/login_worker.js' : '/workers/login_worker.js',
          function: LoginRepository().decryptKeyStore,
          params: {
            'keyStoreJson': store.state.keychainState.keyStoreJson,
            'password': action.password,
          },
        ),
      );

      final Uint8List toplExtendedPrvKeyUint8List = uint8ListFromDynamic(result);
      // if extension: key is temporarily stored in `chrome.storage.session` & session alarm created
      // if mobile: key is persisted securely in secure storage
      if (currAppView == AppViews.extension || currAppView == AppViews.extensionTab) {
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
      store.dispatch(InitializeHDWalletAction(
        toplExtendedPrivateKey: toplExtendedPrvKeyUint8List,
      ));

      //Generate Initial addresses for every network
      store.dispatch(GenerateInitialAddressesAction());


      state = LoginState.fromStore(store, login: true);

      action.completer.complete(true);
    } catch (e) {
      action.completer.complete(false);
    }
  }
}

class AttemptLoginAction {
  final String password;
  final Completer completer;

  const AttemptLoginAction(this.password, this.completer);
}

