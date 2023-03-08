// Dart imports:
import 'dart:async';
import 'dart:convert';

// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

// Package imports:
import 'package:bip_topl/bip_topl.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:redux/src/store.dart';

// Project imports:
import 'package:ribn/actions/keychain_actions.dart';
import 'package:ribn/actions/misc_actions.dart';
import 'package:ribn/constants/keys.dart';
import 'package:ribn/constants/routes.dart';
import 'package:ribn/constants/rules.dart';
import 'package:ribn/models/app_state.dart';
import 'package:ribn/models/state/login_state.dart';
import 'package:ribn/platform/platform.dart';
import 'package:ribn/providers/biometrics_provider.dart';
import 'package:ribn/providers/logger_provider.dart';
import 'package:ribn/providers/packages/flutter_secure_storage_provider.dart';
import 'package:ribn/providers/store_provider.dart';
import 'package:ribn/repositories/login_repository.dart';
import 'package:ribn/repositories/misc_repository.dart';
import 'package:ribn/utils.dart';

final loginProvider = StateNotifierProvider<LoginNotifier, LoginState>((ref) {
  final store = ref.read(storeProvider);
  return LoginNotifier(ref, store);
});

class LoginNotifier extends StateNotifier<LoginState> {
  final Ref ref;
  Store<AppState> store;

  LoginNotifier(this.ref, this.store) : super(LoginState()) {
    // check if biometrics is enabled
    BiometricsNotifier.isBiometricsEnabled(ref).then((value) => state = state.copyWith(isBiometricsEnabled: value));
  }

  // Verifies that the wallet password is correct by attempting to decrypt the keystore.
  Future<void> _verifyPassword(AttemptLoginAction action) async {
    try {
      final AppViews currAppView = await PlatformUtils.instance.getCurrentAppView();

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
            override: ref.read(flutterSecureStorageProvider)());
      }

      _onLogin(toplExtendedPrvKeyUint8List);

      action.completer.complete(true);
    } catch (e) {
      ref
          .read(loggerProvider)
          .log(logLevel: LogLevel.Severe, loggerClass: LoggerClass.Authentication, message: e.toString());
      action.completer.complete(false);
    }
  }

  void _onLogin(Uint8List toplExtendedPrvKeyUint8List) {
    // initialize hd wallet on success
    store.dispatch(InitializeHDWalletAction(
      toplExtendedPrivateKey: toplExtendedPrvKeyUint8List,
    ));

    //Generate Initial addresses for every network
    store.dispatch(GenerateInitialAddressesAction());

    state = state.copyWith(isLoggedIn: true);
  }

  /// Handler for when there is an attempt to login using [password].
  Future<void> attemptLogin(
      {required String password,
      required VoidCallback onIncorrectPasswordEntered,
      required BuildContext context}) async {
    final Completer<bool> loginCompleter = Completer();
    _verifyPassword(AttemptLoginAction(password, loginCompleter));

    await loginCompleter.future.then((bool loginSuccess) async {
      if (!loginSuccess) {
        onIncorrectPasswordEntered();
        return;
      }

      if (store.state.internalMessage?.additionalNavigation == Routes.connectDApp &&
          store.state.internalMessage != null) {
        await MiscRepository().persistAppState(StoreProvider.of<AppState>(context).state.toJson());
        Keys.navigatorKey.currentState?.pushNamed(Routes.connectDApp, arguments: store.state.internalMessage);
      } else {
        Keys.navigatorKey.currentState?.pushReplacementNamed(Routes.home);
      }
    });
  }

  /// Handler for when there is attempt to restore wallet from the login page.
  void restoreWallet() {
    store.dispatch(NavigateToRoute(Routes.restoreWallet));
  }
}

class AttemptLoginAction {
  final String password;
  final Completer completer;

  const AttemptLoginAction(this.password, this.completer);
}