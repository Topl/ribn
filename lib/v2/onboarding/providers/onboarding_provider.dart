// import 'dart:math';

// Dart imports:
import 'dart:math';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:bip_topl/bip_topl.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ribn/v2/onboarding/constants/constants.dart';
import 'package:ribn/v2/onboarding/models/confirm_recovery_phrase_model.dart';

// Project imports:
import 'package:ribn/v2/onboarding/models/onboarding_state.dart';
import 'package:ribn/v2/shared/providers/packages/entropy_provider.dart';
import 'package:ribn/v2/shared/providers/packages/random_provider.dart';
import 'package:ribn/v2/user/providers/user_provider.dart';

// Project imports:

final onboardingProvider = StateNotifierProvider.autoDispose<OnboardingNotifier, OnboardingState>((ref) {
  return OnboardingNotifier(ref);
});

class OnboardingNotifier extends StateNotifier<OnboardingState> {
  final Ref ref;
  final pageController = PageController(initialPage: 0);
  static const pinLength = 6;

  final createPinController = TextEditingController();
  final confirmPinController = TextEditingController();

  OnboardingNotifier(this.ref) : super(_initializeOnboardingState(ref)) {}

  static OnboardingState _initializeOnboardingState(ref) {
    final String mnemonic = _generateMnemonic(ref);
    final List<String> splitMnemonic = mnemonic.split(' ').toList();
    final Map<int, List<ConfirmRecoveryPhraseModel>> confirmationWords = _checkItWords(mnemonic: splitMnemonic);

    // Makes a map of selected confirmation words from the confirmation words map
    final selectedConfirmationWords = Map<int, ConfirmRecoveryPhraseModel>.fromIterable(
      confirmationWords.entries,
      key: (entry) => entry.key,
      value: (entry) => entry.value[1],
    );
    return OnboardingState(
      recoveryPhrase: splitMnemonic,
      confirmationWords: confirmationWords,
      selectedConfirmationWords: selectedConfirmationWords,
    );
  }

  static String _generateMnemonic(Ref ref) {
    final Random random = ref.read(randomProvider)();

    final Entropy entropy = ref.read(entropyProvider)(random);
    return ref.read(entropyFuncProvider)(entropy);
  }

  regenerateMnemonic() {
    // TODO SDK
    final OnboardingState onboardingState = _initializeOnboardingState(ref);
    state = state.copyWith(
      recoveryPhrase: onboardingState.recoveryPhrase,
    );
  }

  /// Returns a map of recovery phrase indexes and corresponding lists of confirm recovery phrase models.
  ///
  /// The function generates a map of recovery phrase indexes and corresponding lists of confirm recovery phrase models.
  /// Each list contains one correct recovery phrase and two incorrect recovery phrases.
  /// The correct recovery phrase is selected from the recovery phrase list at the index specified in the `wordIndexes` list.
  /// The two incorrect recovery phrases are randomly selected from the remaining recovery phrases.
  /// The function shuffles the list of confirm recovery phrase models before adding it to the map.
  ///
  /// Example usage:
  ///
  /// ```dart
  /// final onboardingProvider = OnboardingProvider();
  /// final confirmRecoveryPhrases = onboardingProvider.checkItWords();
  /// ```
  static Map<int, List<ConfirmRecoveryPhraseModel>> _checkItWords({
    required List<String> mnemonic,
  }) {
    final Map<int, List<ConfirmRecoveryPhraseModel>> confirmRecoveryPhases = {};
    for (int i = 0; i < confirmRecoveryPhaseIndexes.length; i++) {
      final List<ConfirmRecoveryPhraseModel> phrases = [];
      final recoveryWords = [...mnemonic];

      final correctWord = recoveryWords[confirmRecoveryPhaseIndexes[i]];

      phrases.add(ConfirmRecoveryPhraseModel(
        phraseString: correctWord,
        isCorrect: true,
      ));

      recoveryWords.remove(correctWord);

      // Generate a list of 2 other words that are incorrect
      final List<String> incorrectWords = [];
      for (int j = 0; j < 2; j++) {
        final randomWord = recoveryWords[Random().nextInt(recoveryWords.length)];
        phrases.add(ConfirmRecoveryPhraseModel(
          phraseString: randomWord,
          isCorrect: false,
        ));
        incorrectWords.add(randomWord);
        recoveryWords.remove(randomWord);
      }

      // Shuffle the list of phrases
      phrases.shuffle();

      confirmRecoveryPhases[confirmRecoveryPhaseIndexes[i]] = phrases;
    }

    return confirmRecoveryPhases;
  }

  /// Sets the selected confirmation word for the given [index].
  selectConfirmationWord({
    required int index,
    required ConfirmRecoveryPhraseModel word,
  }) {
    final Map<int, ConfirmRecoveryPhraseModel> selectedConfirmationWords = {...state.selectedConfirmationWords};
    selectedConfirmationWords[index] = word;
    state = state.copyWith(
      selectedConfirmationWords: selectedConfirmationWords,
    );
  }

  bool verifyConfirmationWords() {
    bool isCorrect = true;
    state.selectedConfirmationWords.forEach((key, value) {
      if (!value.isCorrect) {
        isCorrect = false;
      }
    });

    state = state.copyWith(
      isCorrectConfirmationWords: isCorrect,
    );

    return isCorrect;
  }

  void setPin(pin) => state = state.copyWith(
        pin: pin,
      );

  Future<void> setBiometrics() async {
    try {
      // TODO SDK Biometrics logic
    } catch (e) {
      print(e);
    }
  }

  Future<void> saveWallet() async {
    await ref.read(userProvider.notifier).saveUser(pin: state.pin, mnemonic: state.recoveryPhrase.join(' '));
  }
}
