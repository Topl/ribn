// import 'dart:math';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ribn/models/onboarding_state.dart';
// import 'package:ribn/providers/packages/entropy_provider.dart';
// import 'package:ribn/providers/packages/random_provider.dart';

final onboardingProvider = StateNotifierProvider<OnboardingNotifier, OnboardingState>((ref) {
  return OnboardingNotifier(ref);
});

class OnboardingNotifier extends StateNotifier<OnboardingState> {
  Ref ref;
  OnboardingNotifier(this.ref) : super(_generateOnboardingState(ref)) {}

  static OnboardingState _generateOnboardingState(ref) {
    final mnemonic = _generateMnemonic(ref);
    final splitMnemonic = mnemonic.split(' ').toList();
    return OnboardingState(
      mnemonic: mnemonic,
      shuffledMnemonic: splitMnemonic,
    );
  }

  static String _generateMnemonic(ref) {
    // QQQQ change back
    return 'vote initial ship clean pencil genre struggle say hidden later quit scissors sentence illness leaf';
    // final Random random = ref.read(randomProvider)();

    // final entropy = ref.read(entropyProvider)(random);
    // print('QQQQ mnemonic ${ref.read(entropyFuncProvider)(entropy)}');
    // return ref.read(entropyFuncProvider)(entropy);
  }

  regenerateMnemonic() {
    final onboardingState = _generateOnboardingState(ref);
    state = state.copyWith(
      mnemonic: onboardingState.mnemonic,
      shuffledMnemonic: onboardingState.shuffledMnemonic,
    );
  }
}
