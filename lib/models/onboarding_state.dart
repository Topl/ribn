import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

@immutable
class OnboardingState {
  final bool passwordMismatchError;
  final bool passwordTooShortError;
  final bool loadingPasswordValidation;
  final String? mnemonic; // never persisted
  final bool mnemonicMismatchError;
  final List<String>? shuffledMnemonic; // never persisted
  final List<int>? userSelectedIndices; // never persisted

  const OnboardingState({
    this.passwordMismatchError = false,
    this.passwordTooShortError = false,
    this.loadingPasswordValidation = false,
    this.mnemonic,
    this.mnemonicMismatchError = false,
    this.shuffledMnemonic,
    this.userSelectedIndices,
  });

  factory OnboardingState.initial() {
    return const OnboardingState(
      passwordMismatchError: false,
      passwordTooShortError: false,
      loadingPasswordValidation: false,
      mnemonicMismatchError: false,
    );
  }

  OnboardingState copyWith({
    bool? passwordMismatchError,
    bool? passwordTooShortError,
    bool? loadingPasswordValidation,
    String? mnemonic,
    bool? mnemonicMismatchError,
    List<String>? shuffledMnemonic,
    List<int>? userSelectedIndices,
  }) {
    return OnboardingState(
      passwordMismatchError: passwordMismatchError ?? this.passwordMismatchError,
      passwordTooShortError: passwordTooShortError ?? this.passwordTooShortError,
      loadingPasswordValidation: loadingPasswordValidation ?? this.loadingPasswordValidation,
      mnemonic: mnemonic ?? this.mnemonic,
      mnemonicMismatchError: mnemonicMismatchError ?? this.mnemonicMismatchError,
      shuffledMnemonic: shuffledMnemonic ?? this.shuffledMnemonic,
      userSelectedIndices: userSelectedIndices ?? this.userSelectedIndices,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'passwordMismatchError': passwordMismatchError,
      'passwordTooShortError': passwordTooShortError,
      'loadingPasswordValidation': loadingPasswordValidation,
      'mnemonicMismatchError': mnemonicMismatchError,
    };
  }

  factory OnboardingState.fromMap(Map<String, dynamic> map) {
    return OnboardingState(
      passwordMismatchError: map['passwordMismatchError'],
      passwordTooShortError: map['passwordTooShortError'],
      loadingPasswordValidation: map['loadingPasswordValidation'],
      mnemonicMismatchError: map['mnemonicMismatchError'],
    );
  }

  String toJson() => json.encode(toMap());

  factory OnboardingState.fromJson(String source) => OnboardingState.fromMap(json.decode(source));

  @override
  String toString() {
    return 'OnboardingState(passwordMismatchError: $passwordMismatchError, passwordTooShortError: $passwordTooShortError, loadingPasswordValidation: $loadingPasswordValidation, mnemonic: $mnemonic, mnemonicMismatchError: $mnemonicMismatchError, shuffledMnemonic: $shuffledMnemonic, userSelectedIndices: $userSelectedIndices)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OnboardingState &&
        other.passwordMismatchError == passwordMismatchError &&
        other.passwordTooShortError == passwordTooShortError &&
        other.loadingPasswordValidation == loadingPasswordValidation &&
        other.mnemonic == mnemonic &&
        other.mnemonicMismatchError == mnemonicMismatchError &&
        listEquals(other.shuffledMnemonic, shuffledMnemonic) &&
        listEquals(other.userSelectedIndices, userSelectedIndices);
  }

  @override
  int get hashCode {
    return passwordMismatchError.hashCode ^
        passwordTooShortError.hashCode ^
        loadingPasswordValidation.hashCode ^
        mnemonic.hashCode ^
        mnemonicMismatchError.hashCode ^
        shuffledMnemonic.hashCode ^
        userSelectedIndices.hashCode;
  }
}
