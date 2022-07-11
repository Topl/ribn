import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:ribn/constants/test_data.dart';

@immutable
class OnboardingState {
  final String? mnemonic; // never persisted
  final List<String>? shuffledMnemonic; // never persisted
  final List<int>? userSelectedIndices; // never persisted
  final List<int> mobileConfirmIdxs;

  const OnboardingState({
    this.mnemonic,
    this.shuffledMnemonic,
    this.userSelectedIndices,
    this.mobileConfirmIdxs = const [8, 10, 14, 13],
  });

  factory OnboardingState.initial() {
    return const OnboardingState();
  }

  factory OnboardingState.test() {
    return const OnboardingState(
      mnemonic: TestData.mnemonic,
      shuffledMnemonic: TestData.shuffledMnemonic,
      userSelectedIndices: [],
    );
  }

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
  int get hashCode => mnemonic.hashCode ^ shuffledMnemonic.hashCode ^ userSelectedIndices.hashCode;
}
