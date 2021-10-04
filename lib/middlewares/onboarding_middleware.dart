import 'dart:typed_data';

import 'package:redux/redux.dart';
import 'package:ribn/actions/keychain_actions.dart';
import 'package:ribn/actions/login_actions.dart';
import 'package:ribn/actions/misc_actions.dart';
import 'package:ribn/actions/onboarding_actions.dart';
import 'package:ribn/constants/routes.dart';
import 'package:ribn/constants/rules.dart';
import 'package:ribn/models/app_state.dart';
import 'package:ribn/repositories/onboarding_repository.dart';

List<Middleware<AppState>> createOnboardingMiddleware(OnboardingRespository onboardingRespository) {
  return <Middleware<AppState>>[
    TypedMiddleware<AppState, CreatePasswordAction>(_checkPassword(onboardingRespository)),
    TypedMiddleware<AppState, VerifyMnemonicAction>(_verifyMnemonic(onboardingRespository)),
  ];
}

void Function(Store<AppState> store, CreatePasswordAction action, NextDispatcher next) _checkPassword(
    OnboardingRespository onboardingRespository) {
  return (store, action, next) async {
    /// start loading indicator
    next(LoadingPasswordValidationAction());

    /// both password inputs should match
    if (action.password != action.confirmPassword) {
      next(PasswordMismatchAction());

      /// password must be at least [Rules.minPasswordLength] long
    } else if (action.password.length < Rules.minPasswordLength) {
      next(PasswordTooShortAction());
    } else {
      try {
        Map results = await onboardingRespository.generateMnemonicAndKeystore(action.password);
        next(PasswordSuccessfullyCreatedAction(results['mnemonic'] as String));
        next(
          InitializeHDWalletAction(
            toplExtendedPrivateKey: results['toplExtendedPrvKeyUint8List'] as Uint8List,
            keyStoreJson: results['keyStoreJson'] as String,
          ),
        );

        next(NavigateToRoute(Routes.seedPhrase));
      } catch (e) {
        next(ApiErrorAction(e.toString()));
      }
    }
  };
}

void Function(Store<AppState> store, VerifyMnemonicAction action, NextDispatcher next) _verifyMnemonic(
    OnboardingRespository onboardingRespository) {
  return (store, action, next) {
    if (action.userInput == store.state.onboardingState.mnemonic) {
      next(MnemonicSuccessfullyVerifiedAction());
      next(FirstTimeLoginAction());
      // Generate initial addresses
      next(GenerateInitialAddressesAction(store.state.keychainState.hdWallet));
      next(RefreshBalancesAction());
      next(NavigateToRoute(Routes.home));
    } else {
      next(MnemonicMismatchAction());
    }
  };
}
