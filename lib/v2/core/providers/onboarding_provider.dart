// import 'dart:math';

// Dart imports:
import 'dart:math';

// Flutter imports:
import 'package:bip_topl/bip_topl.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
// Project imports:
import 'package:ribn/v2/core/providers/logger_provider.dart';
import 'package:ribn/v2/core/models/onboarding_state.dart';
import 'package:ribn/v2/core/providers/packages/entropy_provider.dart';
import 'package:ribn/v2/core/providers/packages/random_provider.dart';

// Project imports:

final onboardingProvider = StateNotifierProvider<OnboardingNotifier, OnboardingState>((ref) {
  return OnboardingNotifier(ref);
});

class OnboardingNotifier extends StateNotifier<OnboardingState> {
  final Ref ref;
  final pageController = PageController(initialPage: 0);
  final pinLength = 6;

  OnboardingNotifier(this.ref) : super(_initializeOnboardingState(ref)) {}

  static OnboardingState _initializeOnboardingState(ref) {
    final String mnemonic = _generateMnemonic(ref);
    final List<String> splitMnemonic = mnemonic.split(' ').toList();
    return OnboardingState(
      recoveryPhrase: splitMnemonic,
    );
  }

  static String _generateMnemonic(Ref ref) {
    final Random random = ref.read(randomProvider)();

    final Entropy entropy = ref.read(entropyProvider)(random);
    return ref.read(entropyFuncProvider)(entropy);
  }

  /// Navigates to a different page in the [PageView].
  ///
  /// If [index] is specified, the [PageView] will animate to the page at that index.
  ///
  /// If [index] is `null`, the [PageView] will animate to the next or previous page
  /// based on the value of [reverse].
  ///
  /// Throws an [AssertionError] if [pageController.page] is `null`.
  ///
  /// If the result of navigation is out of the lower bounds for the page controller
  /// it will return [true] for [WillPopScope] to handle
  ///
  /// If successful, animates the transition to the new page using [pageController.animateToPage].
  ///
  /// Example:
  ///
  /// ```dart
  /// // Navigate to the next page in the PageView
  /// navigate();
  ///
  /// // Navigate to the third page in the PageView
  /// navigate(index: 2);
  ///
  /// // Navigate to the previous page in the PageView
  /// navigate(reverse: true);
  /// ```
  bool navigate(BuildContext context, {reverse = false, int? index}) {
    assert(pageController.page != null);
    try {
      int goToIndex = 0;
      if (index != null) {
        goToIndex = index;
      } else {
        // Goes to the next page, goes to previous page if reverse is true
        goToIndex = pageController.page!.toInt() + (reverse ? -1 : 1);
        print("went to $goToIndex");
      }

      // catch out of bounds, return true for [WillPopScope] to handle
      if (goToIndex < 0) return true;

      state = state.copyWith(pageIndex: goToIndex);
      pageController.animateToPage(
        goToIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );

      return false;
    } catch (e) {
      ref.read(loggerProvider).log(
            logLevel: LogLevel.Info,
            loggerClass: LoggerClass.Analytics,
            message: "Analytics enabled",
          );
      return false;
    }
  }

  regenerateMnemonic() {
    final OnboardingState onboardingState = _initializeOnboardingState(ref);
    state = state.copyWith(
      recoveryPhrase: onboardingState.recoveryPhrase,
    );
  }

  setPassword(password) => state = state.copyWith(
        password: password,
      );

  Future<void> setBiometrics() async {
    try {
      // TODO Biometrics logic
    } catch (e) {
      print(e);
    }
  }

  Future<void> saveOnboardingData() async {
    try {
      // TODO Password storing logic
    } catch (e) {
      print(e);
    }
  }
}

final credentialsProvider = Provider<CredentialsNotifier>((ref) {
  return CredentialsNotifier(ref);
});

class CredentialsNotifier {
  final Ref ref;

  CredentialsNotifier(this.ref) {}

  /// Saves the given [password] securely and indicates whether biometrics are enrolled.
  ///
  /// Throws an exception if there is an error while storing the password.
  ///
  /// If [biometricsEnrolled] is not provided, it defaults to `false`.
  ///
  /// Usage:
  ///
  /// ```dart
  /// await saveCredentialsData('password', biometricsEnrolled: true);
  /// ```
  Future<void> saveCredentialsData(String password, {bool biometricsEnrolled = false}) async {
    try {
      assert(password.isNotEmpty, 'Password should not be empty');

      // TODO Password storing logic
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
