import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'package:ribn/actions/login_actions.dart';
import 'package:ribn/models/app_state.dart';

class LoginContainer extends StatelessWidget {
  const LoginContainer({Key? key, required this.builder}) : super(key: key);
  final ViewModelBuilder<LoginViewModel> builder;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, LoginViewModel>(
      distinct: true,
      converter: (store) => LoginViewModel.fromStore(store),
      builder: builder,
    );
  }
}

class LoginViewModel {
  final bool incorrectPasswordError;
  final bool loadingPasswordCheck;

  final Function(String) attemptLogin;

  const LoginViewModel({
    this.incorrectPasswordError = false,
    this.loadingPasswordCheck = false,
    required this.attemptLogin,
  });
  static LoginViewModel fromStore(Store<AppState> store) {
    return LoginViewModel(
      incorrectPasswordError: store.state.loginState.incorrectPasswordError,
      loadingPasswordCheck: store.state.loginState.loadingPasswordCheck,
      attemptLogin: (password) => store.dispatch(AttemptLoginAction(
        password,
        store.state.keychainState.keyStoreJson!,
      )),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LoginViewModel &&
        other.incorrectPasswordError == incorrectPasswordError &&
        other.loadingPasswordCheck == loadingPasswordCheck &&
        other.attemptLogin == attemptLogin;
  }

  @override
  int get hashCode => incorrectPasswordError.hashCode ^ loadingPasswordCheck.hashCode ^ attemptLogin.hashCode;
}
