// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:redux/redux.dart';

// Project imports:
import 'package:ribn/actions/misc_actions.dart';
import 'package:ribn/constants/keys.dart';
import 'package:ribn/constants/routes.dart';
import 'package:ribn/models/app_state.dart';
import 'package:ribn/providers/login_provider.dart';
import 'package:ribn/repositories/misc_repository.dart';

class LoginState {
  /// Handler for when there is an attempt to login using [password].
  final Function(
      {required String password,
      required VoidCallback onIncorrectPasswordEntered,
      required BuildContext context}) attemptLogin;

  /// Handler for when there is attempt to restore wallet from the login page.
  final VoidCallback restoreWallet;

  /// True if biometrics authentication is enabled for login
  final bool isBiometricsEnabled;

  final bool isLoggedIn;

  LoginState({
    required this.attemptLogin,
    required this.restoreWallet,
    required this.isBiometricsEnabled,
    required this.isLoggedIn,
  });

  static LoginState fromStore(Store<AppState> store, {bool login = false} ) {
    return LoginState(
      attemptLogin: ({
        required BuildContext context,
        required String password,
        required VoidCallback onIncorrectPasswordEntered,
      }) async =>
          _attemptLogin(context: context,
              onIncorrectPasswordEntered: onIncorrectPasswordEntered,
              password: password,
              store: store),
      restoreWallet: () => store.dispatch(NavigateToRoute(Routes.restoreWallet)),
      isBiometricsEnabled: store.state.userDetailsState.isBiometricsEnabled,
      isLoggedIn: login
    );
  }

  static _attemptLogin({
    required BuildContext context,
    required void Function() onIncorrectPasswordEntered,
    required String password,
    required Store<AppState> store
  }) async {
    final Completer<bool> loginCompleter = Completer();
    final login = ProviderContainer().read(loginProvider.notifier);
    login.verifyPassword(AttemptLoginAction(password, loginCompleter));

    await loginCompleter.future.then((bool loginSuccess) async {
      if (loginSuccess) {
        if (store.state.internalMessage?.additionalNavigation == Routes.connectDApp &&
            store.state.internalMessage != null) {
          await MiscRepository().persistAppState(StoreProvider
              .of<AppState>(context)
              .state
              .toJson());
          Keys.navigatorKey.currentState?.pushNamed(Routes.connectDApp, arguments: store.state.internalMessage);
        } else {
          Keys.navigatorKey.currentState?.pushReplacementNamed(Routes.home);
        }
      } else {
        onIncorrectPasswordEntered();
      }
    });
  }
}
