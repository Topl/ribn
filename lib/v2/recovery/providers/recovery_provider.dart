import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ribn/v2/recovery/providers/recovery_state.dart';
import 'package:ribn/v2/user/providers/user_provider.dart';

final recoveryProvider = StateNotifierProvider.autoDispose<RecoveryNotifier, RecoveryState>((ref) {
  return RecoveryNotifier(ref);
});

class RecoveryNotifier extends StateNotifier<RecoveryState> {
  final Ref ref;

  final createPinController = TextEditingController();
  final confirmPinController = TextEditingController();

  RecoveryNotifier(this.ref) : super(_initializeRecoveryState());

  static RecoveryState _initializeRecoveryState() {
    return RecoveryState(recoveryPhrase: List.generate(16, (index) => null));
  }

  void setPin(String pin) {
    state = state.copyWith(pin: pin);
  }

  void setBiometricsEnrolled(bool biometricsEnrolled) {
    state = state.copyWith(biometricsEnrolled: biometricsEnrolled);
  }

  void updateRecoveryPhrase({
    required int index,
    required String? word,
  }) {
    final List<String?> recoveryPhrase = [...state.recoveryPhrase];
    recoveryPhrase[index] = word;
    state = state.copyWith(recoveryPhrase: recoveryPhrase);
  }

  Future<void> saveWallet() async {
    // TODO: Implement SDK
    await ref.read(userProvider.notifier).saveUser(pin: state.pin, mnemonic: state.recoveryPhrase.join(' '));
  }
}
