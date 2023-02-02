import 'dart:math';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ribn/models/onboarding_state.dart';
import 'package:ribn/providers/packages/entropy_provider.dart';
import 'package:ribn/providers/packages/random_provider.dart';

final onboardingProvider = StateNotifierProvider<OnboardingNotifier, OnboardingState>((ref) {
  return OnboardingNotifier(ref);
});

class OnboardingNotifier extends StateNotifier<OnboardingState> {
  Ref ref;
  OnboardingNotifier(this.ref) : super(OnboardingState(mnemonic: _generateMnemonic(ref)));

  static String _generateMnemonic(ref) {
    final Random random = ref.read(randomProvider)();

    final entropy = ref.read(entropyProvider)(random);
    return ref.read(entropyFuncProvider)(entropy);
  }

  regenerateMnemonic() {
    state = state.copyWith(mnemonic: _generateMnemonic(ref));
  }
}
