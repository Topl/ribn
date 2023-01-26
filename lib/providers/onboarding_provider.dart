import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ribn/models/onboarding_state.dart';

final onboardingProvider = StateProvider<OnboardingState>((ref) {
  return OnboardingState();
});
