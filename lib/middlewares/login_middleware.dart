import 'dart:typed_data';
import 'package:redux/redux.dart';
import 'package:ribn/actions/keychain_actions.dart';
import 'package:ribn/actions/login_actions.dart';
import 'package:ribn/actions/misc_actions.dart';
import 'package:ribn/constants/routes.dart';
import 'package:ribn/models/app_state.dart';
import 'package:ribn/repositories/login_repository.dart';

List<Middleware<AppState>> createLoginMiddleware(LoginRepository loginRepository) {
  return <Middleware<AppState>>[
    TypedMiddleware<AppState, AttemptLoginAction>(_verifyPassword(loginRepository)),
  ];
}

void Function(Store<AppState> store, AttemptLoginAction action, NextDispatcher next) _verifyPassword(
    LoginRepository loginRepository) {
  return (store, action, next) async {
    /// start loading indicator
    next(LoginLoadingAction());
    try {
      Uint8List toplExtendedPrvKeyUint8List = loginRepository.decryptKeyStore(
        action.keyStoreJson,
        action.password,
      );
      next(const LoginSuccessAction());
      next(InitializeHDWalletAction(toplExtendedPrivateKey: toplExtendedPrvKeyUint8List));
      // AppState persisted after successful login
      next(PersistAppState());
      next(RefreshBalancesAction());
      next(NavigateToRoute(Routes.home));
    } catch (e) {
      if (e.runtimeType == ArgumentError &&
          (e as ArgumentError).message.toString().contains("supplied the wrong password")) {
        next(LoginFailureAction());
      } else {
        next(ApiErrorAction(e.toString()));
      }
    }
  };
}
