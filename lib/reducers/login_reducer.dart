// Package imports:
import 'package:redux/redux.dart';

// Project imports:
import 'package:ribn/actions/login_actions.dart';
import 'package:ribn/models/login_state.dart';

/// Reducer responsible for updating [LoginState]
final loginReducer = combineReducers<LoginState>(
  [
    TypedReducer<LoginState, LoginSuccessAction>(_onLoginSuccess),
  ],
);

LoginState _onLoginSuccess(LoginState loginState, LoginSuccessAction action) {
  return loginState.copyWith(
    isLoggedIn: true,
    lastLogin: DateTime.now().toUtc().toString(),
  );
}
