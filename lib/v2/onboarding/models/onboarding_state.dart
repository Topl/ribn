// Package imports:
import 'package:freezed_annotation/freezed_annotation.dart';

part 'onboarding_state.freezed.dart';

@freezed
class OnboardingState with _$OnboardingState {
  const factory OnboardingState({
    /// True if biometrics authentication is enabled for login
    @Default("") String pin,
    @Default(false) bool biometricsEnrolled,
    @Default([]) List<String> recoveryPhrase,
    @Default(0) int pageIndex,
  }) = _OnboardingState;
}
