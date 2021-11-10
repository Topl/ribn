import 'dart:typed_data';

import 'package:redux/redux.dart';
import 'package:ribn/actions/keychain_actions.dart';
import 'package:ribn/actions/misc_actions.dart';
import 'package:ribn/actions/onboarding_actions.dart';
import 'package:ribn/constants/routes.dart';
import 'package:ribn/models/app_state.dart';
import 'package:ribn/repositories/onboarding_repository.dart';

List<Middleware<AppState>> createOnboardingMiddleware(OnboardingRespository onboardingRespository) {
  return <Middleware<AppState>>[
    TypedMiddleware<AppState, GenerateMnemonicAction>(_generateMnemonic(onboardingRespository)),
    TypedMiddleware<AppState, CreatePasswordAction>(_createPassword(onboardingRespository)),
  ];
}

/// Generates mnemonic for the user and redirects to [Routes.onboardingSteps]
void Function(Store<AppState> store, GenerateMnemonicAction action, NextDispatcher next) _generateMnemonic(
    OnboardingRespository onboardingRespository) {
  return (store, action, next) async {
    try {
      final String mnemonic = await onboardingRespository.generateMnemonicForUser();
      next(MnemonicSuccessfullyGeneratedAction(mnemonic));
      next(NavigateToRoute(Routes.onboardingSteps));
    } catch (e) {
      next(ApiErrorAction(e.toString()));
    }
  };
}

/// Generates a [KeyStore] with the provided password and initializes the HdWallet
void Function(Store<AppState> store, CreatePasswordAction action, NextDispatcher next) _createPassword(
    OnboardingRespository onboardingRespository) {
  return (store, action, next) async {
    try {
      final Map<String, dynamic> results = await onboardingRespository.generateKeyStore(
        store.state.onboardingState.mnemonic!,
        action.password,
      );
      next(
        InitializeHDWalletAction(
          toplExtendedPrivateKey: results['toplExtendedPrvKeyUint8List'] as Uint8List,
          keyStoreJson: results['keyStoreJson'] as String,
        ),
      );
    } catch (e) {
      next(ApiErrorAction(e.toString()));
    }
  };
}
