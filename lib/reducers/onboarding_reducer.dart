import 'package:redux/redux.dart';
import 'package:ribn/actions/onboarding_actions.dart';
import 'package:ribn/models/onboarding_state.dart';

/// Reducer responsible for updating [OnboardingState]
final onboardingReducer = combineReducers<OnboardingState>(
  [
    TypedReducer<OnboardingState, CreatePasswordAction>(_onCreatePassword),
    TypedReducer<OnboardingState, PasswordMismatchAction>(_onPasswordMismatch),
    TypedReducer<OnboardingState, LoadingPasswordValidationAction>(_onLoadingPasswordValidation),
    TypedReducer<OnboardingState, PasswordTooShortAction>(_onPasswordTooShort),
  ],
);

OnboardingState _onCreatePassword(OnboardingState onboardingState, CreatePasswordAction action) {
  return onboardingState.copyWith(passwordMismatchError: false, loadingPasswordValidation: false);
}

OnboardingState _onPasswordMismatch(
    OnboardingState onboardingState, PasswordMismatchAction action) {
  return onboardingState.copyWith(passwordMismatchError: true, loadingPasswordValidation: false);
}

OnboardingState _onLoadingPasswordValidation(
    OnboardingState onboardingState, LoadingPasswordValidationAction action) {
  return onboardingState.copyWith(loadingPasswordValidation: true);
}

OnboardingState _onPasswordTooShort(
    OnboardingState onboardingState, PasswordTooShortAction action) {
  return onboardingState.copyWith(passwordTooShortError: true, loadingPasswordValidation: false);
}
