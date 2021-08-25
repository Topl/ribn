import 'dart:convert';

import 'package:flutter/material.dart';

@immutable
class OnboardingState {
  final bool passwordMismatchError;
  final bool passwordTooShortError;
  final bool loadingPasswordValidation;

  const OnboardingState({
    required this.passwordMismatchError,
    required this.passwordTooShortError,
    required this.loadingPasswordValidation,
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
    bool? loadingPasswordValidation,
    bool? passwordTooShortError,
  }) {
    return OnboardingState(
      passwordMismatchError: passwordMismatchError ?? this.passwordMismatchError,
      loadingPasswordValidation: loadingPasswordValidation ?? this.loadingPasswordValidation,
      passwordTooShortError: passwordTooShortError ?? this.passwordTooShortError,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'passwordMismatchError': passwordMismatchError,
      'loadingPasswordValidation': loadingPasswordValidation,
      'passwordTooShortError': passwordTooShortError,
    };
  }

  factory OnboardingState.fromMap(Map<String, dynamic> map) {
    return OnboardingState(
      passwordMismatchError: map['passwordMismatchError'],
      loadingPasswordValidation: map['loadingPasswordValidation'],
      passwordTooShortError: map['passwordTooShortError'],
    );
  }

  String toJson() => json.encode(toMap());

  factory OnboardingState.fromJson(String source) => OnboardingState.fromMap(json.decode(source));

  @override
  String toString() =>
      'OnboardingState(passwordMismatchError: $passwordMismatchError, loadingPasswordValidation: $loadingPasswordValidation, passwordTooShortError: $passwordTooShortError)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OnboardingState &&
        other.passwordMismatchError == passwordMismatchError &&
        other.loadingPasswordValidation == loadingPasswordValidation &&
        other.passwordTooShortError == passwordTooShortError;
  }

  @override
  int get hashCode =>
      passwordMismatchError.hashCode ^
      loadingPasswordValidation.hashCode ^
      passwordTooShortError.hashCode;
}
