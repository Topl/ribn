import 'dart:convert';

import 'package:flutter/material.dart';

@immutable
class OnboardingState {
  final bool passwordMismatchError;
  final bool passwordTooShortError;
  final bool loadingPasswordValidation;
  final String? keyStoreJson;
  final String? mnemonic;

  const OnboardingState({
    required this.passwordMismatchError,
    required this.passwordTooShortError,
    required this.loadingPasswordValidation,
    this.keyStoreJson,
    this.mnemonic,
  });

  factory OnboardingState.initial() {
    return const OnboardingState(
      passwordMismatchError: false,
      passwordTooShortError: false,
      loadingPasswordValidation: false,
    );
  }

  OnboardingState copyWith({
    bool? passwordMismatchError,
    bool? passwordTooShortError,
    bool? loadingPasswordValidation,
    String? keyStoreJson,
    String? mnemonic,
  }) {
    return OnboardingState(
      passwordMismatchError: passwordMismatchError ?? this.passwordMismatchError,
      passwordTooShortError: passwordTooShortError ?? this.passwordTooShortError,
      loadingPasswordValidation: loadingPasswordValidation ?? this.loadingPasswordValidation,
      keyStoreJson: keyStoreJson ?? this.keyStoreJson,
      mnemonic: mnemonic ?? this.mnemonic,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'passwordMismatchError': passwordMismatchError,
      'passwordTooShortError': passwordTooShortError,
      'loadingPasswordValidation': loadingPasswordValidation,
      'keyStoreJson': keyStoreJson,
      // mnemonic will never be persisted
    };
  }

  factory OnboardingState.fromMap(Map<String, dynamic> map) {
    return OnboardingState(
      passwordMismatchError: map['passwordMismatchError'],
      passwordTooShortError: map['passwordTooShortError'],
      loadingPasswordValidation: map['loadingPasswordValidation'],
      keyStoreJson: map['keyStoreJson'],
    );
  }

  String toJson() => json.encode(toMap());

  factory OnboardingState.fromJson(String source) => OnboardingState.fromMap(json.decode(source));

  @override
  String toString() {
    return 'OnboardingState(passwordMismatchError: $passwordMismatchError, passwordTooShortError: $passwordTooShortError, loadingPasswordValidation: $loadingPasswordValidation, keyStoreJson: $keyStoreJson, mnemonic: $mnemonic)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OnboardingState &&
        other.passwordMismatchError == passwordMismatchError &&
        other.passwordTooShortError == passwordTooShortError &&
        other.loadingPasswordValidation == loadingPasswordValidation &&
        other.keyStoreJson == keyStoreJson &&
        other.mnemonic == mnemonic;
  }

  @override
  int get hashCode {
    return passwordMismatchError.hashCode ^
        passwordTooShortError.hashCode ^
        loadingPasswordValidation.hashCode ^
        keyStoreJson.hashCode ^
        mnemonic.hashCode;
  }
}
