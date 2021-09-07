import 'dart:typed_data';

import 'package:redux/redux.dart';
import 'package:ribn/actions/login_actions.dart';
import 'package:ribn/actions/misc_actions.dart';
import 'package:ribn/constants/keys.dart';
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
    Future.delayed(const Duration(seconds: 2));
    try {
      Uint8List toplExtendedPrvKeyUint8List =
          loginRepository.decryptKeyStore(store.state.onboardingState.keyStoreJson!, action.password);
      next(LoginSuccessAction(toplExtendedPrvKeyUint8List));
      next(PersistAppState());
      Keys.navigatorKey.currentState!.pushNamed(Routes.home);
    } catch (e) {
      next(LoginFailureAction());
    }
  };
}
