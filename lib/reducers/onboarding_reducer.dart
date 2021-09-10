import 'dart:math';
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
    TypedReducer<OnboardingState, MnemonicSuccessfullyVerifiedAction>(_onMnemonicSuccessfullyVerified),
    TypedReducer<OnboardingState, MnemonicMismatchAction>(_onMnemonicMismatchError),
    TypedReducer<OnboardingState, UserSelectedWordAction>(_onUserSelectedWord),
    TypedReducer<OnboardingState, UserRemovedWordAction>(_onUserRemovedWord),
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
    shuffledMnemonic: List.from(action.mnemonic.split(" "))..shuffle(Random()),
    userSelectedWords: [],
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

OnboardingState _onMnemonicSuccessfullyVerified(
    OnboardingState onboardingState, MnemonicSuccessfullyVerifiedAction action) {
  return onboardingState.copyWith(
    mnemonicMismatchError: false,
    mnemonic: null,
    shuffledMnemonic: null,
    userSelectedWords: null,
  );
}

OnboardingState _onMnemonicMismatchError(OnboardingState onboardingState, MnemonicMismatchAction action) {
  return onboardingState.copyWith(
    mnemonicMismatchError: true,
  );
}

OnboardingState _onUserSelectedWord(OnboardingState onboardingState, UserSelectedWordAction action) {
  return onboardingState.copyWith(
    userSelectedWords: List.from(onboardingState.userSelectedWords ?? [])..add(action.word),
  );
}

OnboardingState _onUserRemovedWord(OnboardingState onboardingState, UserRemovedWordAction action) {
  return onboardingState.copyWith(
    userSelectedWords: List.from(onboardingState.userSelectedWords ?? [])..remove(action.word),
  );
}
