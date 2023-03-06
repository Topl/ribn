<<<<<<< HEAD
=======
// Dart imports:
import 'dart:convert';

>>>>>>> rc-0.4
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
<<<<<<< HEAD
  factory OnboardingState.fromJson(Map<String, dynamic> json) => _$OnboardingStateFromJson(json);
=======

  OnboardingState copyWith({
    String? mnemonic,
    List<String>? shuffledMnemonic,
    List<int>? userSelectedIndices,
  }) {
    return OnboardingState(
      mnemonic: mnemonic ?? this.mnemonic,
      shuffledMnemonic: shuffledMnemonic ?? this.shuffledMnemonic,
      userSelectedIndices: userSelectedIndices ?? this.userSelectedIndices,
    );
  }

  Map<String, dynamic> toMap() {
    return {};
  }

  // ignore: avoid_unused_constructor_parameters
  factory OnboardingState.fromMap(Map<String, dynamic> map) {
    return const OnboardingState();
  }

  String toJson() => json.encode(toMap());

  factory OnboardingState.fromJson(String source) =>
      OnboardingState.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'OnboardingState(mnemonic: $mnemonic, shuffledMnemonic: $shuffledMnemonic, userSelectedIndices: $userSelectedIndices)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OnboardingState &&
        other.mnemonic == mnemonic &&
        listEquals(other.shuffledMnemonic, shuffledMnemonic) &&
        listEquals(other.userSelectedIndices, userSelectedIndices);
  }

  @override
  int get hashCode =>
      mnemonic.hashCode ^
      shuffledMnemonic.hashCode ^
      userSelectedIndices.hashCode;
>>>>>>> rc-0.4
}
