import 'package:redux/redux.dart';
import 'package:ribn/actions/onboarding_actions.dart';
import 'package:ribn/models/onboarding_state.dart';

/// Reducer responsible for updating [OnboardingState]
final onboardingReducer = combineReducers<OnboardingState>(
  [
    TypedReducer<OnboardingState, PasswordMismatchAction>(_onPasswordMismatch),
    TypedReducer<OnboardingState, LoadingPasswordValidationAction>(_onLoadingPasswordValidation),
    TypedReducer<OnboardingState, PasswordTooShortAction>(_onPasswordTooShort),
    TypedReducer<OnboardingState, PasswordSuccessfullyCreatedAction>(_onPasswordSuccessfullyCreated),
  ],
);

OnboardingState _onPasswordSuccessfullyCreated(
    OnboardingState onboardingState, PasswordSuccessfullyCreatedAction action) {
  return onboardingState.copyWith(
    keyStoreJson: action.keyStoreJson,
    passwordMismatchError: false,
    passwordTooShortError: false,
    loadingPasswordValidation: false,
    mnemonic: action.mnemonic,
  );
}

OnboardingState _onPasswordMismatch(OnboardingState onboardingState, PasswordMismatchAction action) {
  return onboardingState.copyWith(
    passwordMismatchError: true,
    passwordTooShortError: false,
    loadingPasswordValidation: false,
  );
}

OnboardingState _onLoadingPasswordValidation(
    OnboardingState onboardingState, LoadingPasswordValidationAction action) {
  return onboardingState.copyWith(
    loadingPasswordValidation: true,
  );
}

OnboardingState _onPasswordTooShort(OnboardingState onboardingState, PasswordTooShortAction action) {
  return onboardingState.copyWith(
    passwordTooShortError: true,
    loadingPasswordValidation: false,
    passwordMismatchError: false,
  );
}
