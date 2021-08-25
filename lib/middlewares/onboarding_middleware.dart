import 'package:redux/redux.dart';
import 'package:ribn/actions/onboarding_actions.dart';
import 'package:ribn/constants/keys.dart';
import 'package:ribn/constants/routes.dart';
import 'package:ribn/constants/rules.dart';
import 'package:ribn/models/app_state.dart';

List<Middleware<AppState>> createOnboardingMiddleware() {
  return <Middleware<AppState>>[
    TypedMiddleware<AppState, CreatePasswordAction>(_checkPassword()),
  ];
}

void Function(Store<AppState> store, CreatePasswordAction action, NextDispatcher next)
    _checkPassword() {
  return (store, action, next) async {
    /// start loading indicator
    next(LoadingPasswordValidationAction());
    await Future.delayed(const Duration(seconds: 2));

    /// both password inputs should match
    if (action.password != action.confirmPassword) {
      next(PasswordMismatchAction());

      /// password must be at least [Rules.minPasswordLength] long
    } else if (action.password.length < Rules.minPasswordLength) {
      next(PasswordTooShortAction());
    } else {
      next(action);
      Keys.navigatorKey.currentState?.pushNamed(Routes.seedPhrase);
    }
  };
}
