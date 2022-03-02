import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'package:ribn/actions/login_actions.dart';
import 'package:ribn/actions/misc_actions.dart';
import 'package:ribn/constants/routes.dart';
import 'package:ribn/models/app_state.dart';

/// Intended to wrap the [LoginPage] and provide it with the the [LoginViewModel].
class LoginContainer extends StatelessWidget {
  const LoginContainer({Key? key, required this.builder}) : super(key: key);
  final ViewModelBuilder<LoginViewModel> builder;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, LoginViewModel>(
      distinct: true,
      converter: LoginViewModel.fromStore,
      builder: builder,
    );
  }
}

class LoginViewModel {
  /// Indicates whether an incorrect password was entered.
  final bool incorrectPasswordError;

  /// Handler for when there is an attempt to login using [password].
  final Function(String password) attemptLogin;

  /// Handler for when there is attempt to restore wallet from the login page.
  final VoidCallback restoreWallet;

  const LoginViewModel({
    this.incorrectPasswordError = false,
    required this.attemptLogin,
    required this.restoreWallet,
  });
  static LoginViewModel fromStore(Store<AppState> store) {
    return LoginViewModel(
      incorrectPasswordError: store.state.loginState.incorrectPasswordError,
      attemptLogin: (String password) => store.dispatch(
        AttemptLoginAction(
          password,
          store.state.keychainState.keyStoreJson!,
        ),
      ),
      restoreWallet: () => store.dispatch(NavigateToRoute(Routes.loginRestoreWallet)),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LoginViewModel &&
        other.incorrectPasswordError == incorrectPasswordError &&
        other.attemptLogin == attemptLogin;
  }

  @override
  int get hashCode => incorrectPasswordError.hashCode ^ attemptLogin.hashCode;
}
