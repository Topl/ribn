import 'dart:async';

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
  /// Handler for when there is an attempt to login using [password].
  final Function({required String password, required VoidCallback onIncorrectPasswordEntered}) attemptLogin;

  /// Handler for when there is attempt to restore wallet from the login page.
  final VoidCallback restoreWallet;

  const LoginViewModel({
    required this.attemptLogin,
    required this.restoreWallet,
  });
  static LoginViewModel fromStore(Store<AppState> store) {
    return LoginViewModel(
      attemptLogin: ({required String password, required VoidCallback onIncorrectPasswordEntered}) async {
        final Completer<bool> actionCompleter = Completer();
        store.dispatch(AttemptLoginAction(password, actionCompleter));
        await actionCompleter.future.then((value) {
          if (!value) onIncorrectPasswordEntered();
        });
      },
      restoreWallet: () => store.dispatch(NavigateToRoute(Routes.restoreWallet)),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LoginViewModel && other.restoreWallet == restoreWallet;
  }

  @override
  int get hashCode => restoreWallet.hashCode;
}
