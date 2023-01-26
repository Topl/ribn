import 'dart:math';

import 'package:bip_topl/bip_topl.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ribn/models/onboarding_state.dart';
import 'package:pinenacl/encoding.dart';

final randomProvider = Provider<Random Function()>((ref) {
  return () => Random.secure();
});

final entropyProvider = Provider<Entropy Function(dynamic)>((ref) {
  return (random) => Entropy.generate(from_entropy_size(128), RandomBridge(random).nextUint8);
});

final entropyFuncProvider = Provider<String Function(dynamic)>((ref) {
  return (entropy) =>
      entropyToMnemonic(HexCoder.instance.encode(entropy.bytes), language: 'english');
});

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
