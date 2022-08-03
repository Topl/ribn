import 'package:flutter/foundation.dart';
import 'package:redux/redux.dart';
import 'package:ribn/actions/misc_actions.dart';
import 'package:ribn/constants/keys.dart';
import 'package:ribn/constants/routes.dart';
import 'package:ribn/models/app_state.dart';
import 'package:ribn/platform/platform.dart';
import 'package:ribn/repositories/login_repository.dart';
import 'package:ribn/repositories/misc_repository.dart';

List<Middleware<AppState>> createMiscMiddleware(LoginRepository loginRep, MiscRepository miscRepo) {
  return <Middleware<AppState>>[
    TypedMiddleware<AppState, DeleteWalletAction>(_onDeleteWallet(loginRep)),
    TypedMiddleware<AppState, DownloadAsFileAction>(_onDownloadAsFile(miscRepo)),
  ];
}

void Function(Store<AppState> store, DeleteWalletAction action, NextDispatcher next) _onDeleteWallet(
  LoginRepository loginRepo,
) {
  return (store, action, next) async {
    try {
      // Check if correct password was entered
      loginRepo.decryptKeyStore(
        {
          'keyStoreJson': store.state.keychainState.keyStoreJson!,
          'password': action.password,
        },
      );
      // Reset and persist app state
      next(const ResetAppStateAction());
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
      action.completer.complete(false);
    }
  };
}

void Function(Store<AppState> store, DownloadAsFileAction action, NextDispatcher next) _onDownloadAsFile(
  MiscRepository miscRepo,
) {
  return (store, action, next) {
    try {
      miscRepo.downloadAsFile(action.fileName, action.text);
    } catch (e) {
      next(ApiErrorAction(e.toString()));
    }
  };
}
