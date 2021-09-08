import 'package:redux/redux.dart';
import 'package:ribn/actions/login_actions.dart';
import 'package:ribn/models/login_state.dart';

/// Reducer responsible for updating [LoginState]
final loginReducer = combineReducers<LoginState>(
  [
    TypedReducer<LoginState, LoginSuccessAction>(_onLoginSuccess),
    TypedReducer<LoginState, LoginFailureAction>(_onLoginFailure),
    TypedReducer<LoginState, LoginLoadingAction>(_onLoginLoading),
    TypedReducer<LoginState, FirstTimeLoginAction>(_onFirstTimeLogin),
  ],
);

LoginState _onLoginSuccess(LoginState loginState, LoginSuccessAction action) {
  return loginState.copyWith(
    incorrectPasswordError: false,
    isLoggedIn: true,
    loadingPasswordCheck: false,
    lastLogin: DateTime.now().toUtc().toString(),
  );
}

LoginState _onLoginFailure(LoginState loginState, LoginFailureAction action) {
  return loginState.copyWith(
    incorrectPasswordError: true,
    isLoggedIn: false,
    loadingPasswordCheck: false,
  );
}

LoginState _onLoginLoading(LoginState loginState, LoginLoadingAction action) {
  return loginState.copyWith(
    incorrectPasswordError: false,
    isLoggedIn: false,
    loadingPasswordCheck: true,
  );
}

LoginState _onFirstTimeLogin(LoginState loginState, FirstTimeLoginAction action) {
  return loginState.copyWith(
    incorrectPasswordError: false,
    isLoggedIn: true,
    loadingPasswordCheck: false,
    lastLogin: DateTime.now().toUtc().toString(),
    firstTimeLogin: DateTime.now().toUtc().toString(),
  );
}
