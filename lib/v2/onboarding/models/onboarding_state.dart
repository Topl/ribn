// Package imports:
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ribn/v2/onboarding/models/confirm_recovery_phrase_model.dart';

part 'onboarding_state.freezed.dart';

@freezed
class OnboardingState with _$OnboardingState {
  const factory OnboardingState({
    /// True if biometrics authentication is enabled for login
    @Default("") String pin,
    @Default(false) bool biometricsEnrolled,
    required List<String> recoveryPhrase,

    /// Map of confirmation words for each page
    /// The key is the index of the word in the mnemonic
    /// The value is a list of [ConfirmRecoveryPhraseModel]
    required Map<int, List<ConfirmRecoveryPhraseModel>> confirmationWords,

    /// Map of selected confirmation words for each option
    required Map<int, ConfirmRecoveryPhraseModel> selectedConfirmationWords,
    @Default(0) int pageIndex,
  }) = _OnboardingState;
}
