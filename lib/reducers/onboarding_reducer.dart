// Dart imports:
import 'dart:math';

// Package imports:
import 'package:redux/redux.dart';

// Project imports:
import 'package:ribn/actions/onboarding_actions.dart';
import 'package:ribn/models/onboarding_state.dart';

/// Reducer responsible for updating [OnboardingState]
final onboardingReducer = combineReducers<OnboardingState>(
  [
    TypedReducer<OnboardingState, UserSelectedWordAction>(_onUserSelectedWord),
    TypedReducer<OnboardingState, MnemonicSuccessfullyGeneratedAction>(
        _onMnemonicGenerated),
  ],
);

/// Updates the mnemonic in [AppState]
OnboardingState _onMnemonicGenerated(OnboardingState onboardingState,
    MnemonicSuccessfullyGeneratedAction action) {
  return onboardingState.copyWith(
    mnemonic: action.mnemonic,
    shuffledMnemonic: List.from(action.mnemonic.split(' '))..shuffle(Random()),
    userSelectedIndices: [],
  );
}

OnboardingState _onUserSelectedWord(
    OnboardingState onboardingState, UserSelectedWordAction action) {
  return onboardingState.copyWith(
    userSelectedIndices: List.from(onboardingState.userSelectedIndices ?? [])
      ..add(action.idx),
  );
}
