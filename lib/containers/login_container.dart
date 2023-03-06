// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
// Project imports:
import 'package:ribn/actions/login_actions.dart';
import 'package:ribn/actions/misc_actions.dart';
import 'package:ribn/constants/keys.dart';
import 'package:ribn/constants/routes.dart';
import 'package:ribn/models/app_state.dart';

import '../repositories/misc_repository.dart';

/// Intended to wrap the [LoginPage] and provide it with the the [LoginViewModel].
class LoginContainer extends StatelessWidget {
  const LoginContainer({
    Key? key,
    required this.builder,
    required this.onInitialBuild,
  }) : super(key: key);
  final ViewModelBuilder<LoginViewModel> builder;
  final void Function(LoginViewModel vm) onInitialBuild;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, LoginViewModel>(
      distinct: true,
      converter: LoginViewModel.fromStore,
      builder: builder,
      onInitialBuild: onInitialBuild,
    );
  }
}

class LoginViewModel {
  /// Handler for when there is an attempt to login using [password].
  final Function(
      {required String password,
      required VoidCallback onIncorrectPasswordEntered,
      required BuildContext context}) attemptLogin;

  /// Handler for when there is attempt to restore wallet from the login page.
  final VoidCallback restoreWallet;

  /// True if biometrics authentication is enabled for login
  final bool isBiometricsEnabled;

  const LoginViewModel({
    required this.attemptLogin,
    required this.restoreWallet,
    required this.isBiometricsEnabled,
  });
  static LoginViewModel fromStore(Store<AppState> store) {
    return LoginViewModel(
      attemptLogin: ({
        required BuildContext context,
        required String password,
        required VoidCallback onIncorrectPasswordEntered,
      }) async {
        final Completer<bool> loginCompleter = Completer();
        store.dispatch(AttemptLoginAction(password, loginCompleter));
        await loginCompleter.future.then((bool loginSuccess) async {
          if (loginSuccess) {
            if (store.state.internalMessage?.additionalNavigation == Routes.connectDApp &&
                store.state.internalMessage != null) {
              await MiscRepository()
                  .persistAppState(StoreProvider.of<AppState>(context).state.toJson());
              Keys.navigatorKey.currentState
                  ?.pushNamed(Routes.connectDApp, arguments: store.state.internalMessage);
            } else {
              Keys.navigatorKey.currentState?.pushReplacementNamed(Routes.home);
            }
          } else {
            onIncorrectPasswordEntered();
          }
        });
      },
      restoreWallet: () => store.dispatch(NavigateToRoute(Routes.restoreWallet)),
      isBiometricsEnabled: store.state.userDetailsState.isBiometricsEnabled,
    );
  }

  @override
  bool operator ==(covariant LoginViewModel other) {
    if (identical(this, other)) return true;

    return other.restoreWallet == restoreWallet;
  }

  @override
  int get hashCode => restoreWallet.hashCode;
}
