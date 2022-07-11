import 'dart:typed_data';
import 'package:bip_topl/bip_topl.dart';
import 'package:redux/redux.dart';
import 'package:ribn/actions/login_actions.dart';
import 'package:ribn/models/app_state.dart';
import 'package:ribn/platform/platform.dart';
import 'package:ribn/repositories/login_repository.dart';

List<Middleware<AppState>> createLoginMiddleware(LoginRepository loginRepository) {
  return <Middleware<AppState>>[
    TypedMiddleware<AppState, AttemptLoginAction>(_verifyPassword(loginRepository)),
  ];
}

/// Verifies that the wallet password is correct by attempting to decrypt the keystore.
void Function(Store<AppState> store, AttemptLoginAction action, NextDispatcher next) _verifyPassword(
  LoginRepository loginRepository,
) {
  return (store, action, next) async {
    try {
      final Uint8List toplExtendedPrvKeyUint8List = loginRepository.decryptKeyStore(
        keyStoreJson: store.state.keychainState.keyStoreJson!,
        password: action.password,
      );
      await PlatformLocalStorage.instance.saveSessionKey(Base58Encoder.instance.encode(toplExtendedPrvKeyUint8List));
      // if (kIsWeb) PlatformUtils.instance.createLoginSessionAlarm();
      action.completer.complete(true);
      next(LoginSuccessAction(toplExtendedPrvKeyUint8List));
    } catch (e) {
      action.completer.complete(false);
    }
  };
}
