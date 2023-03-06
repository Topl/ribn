// Flutter imports:
import 'package:flutter/foundation.dart';

// Project imports:
import 'package:ribn/constants/test_data.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'onboarding_state.freezed.dart';
part 'onboarding_state.g.dart';

@freezed
class OnboardingState with _$OnboardingState {
  const factory OnboardingState({
    required String mnemonic,
    required List<String> shuffledMnemonic,
    List<int>? userSelectedIndices,
    @Default([8, 10, 14, 13]) List<int> mobileConfirmIdxs,
  }) = _OnboardingState;

  factory OnboardingState.test() {
    return const OnboardingState(
      mnemonic: TestData.mnemonic,
      shuffledMnemonic: TestData.shuffledMnemonic,
      userSelectedIndices: [],
    );
  }
  factory OnboardingState.fromJson(Map<String, dynamic> json) => _$OnboardingStateFromJson(json);
}
