import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:ribn/models/keychain_state.dart';
import 'package:ribn/models/login_state.dart';
import 'package:ribn/models/onboarding_state.dart';

@immutable
class AppState {
  final OnboardingState onboardingState;
  final LoginState loginState;
  final KeychainState keychainState;

  const AppState({
    required this.onboardingState,
    required this.loginState,
    required this.keychainState,
  });

  factory AppState.initial() {
    return AppState(
      onboardingState: OnboardingState.initial(),
      loginState: LoginState.initial(),
      keychainState: KeychainState.initial(),
    );
  }

  bool keyStoreExists() {
    return (keychainState.keyStoreJson ?? "").isNotEmpty;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AppState &&
        other.onboardingState == onboardingState &&
        other.loginState == loginState &&
        other.keychainState == keychainState;
  }

  @override
  int get hashCode => onboardingState.hashCode ^ loginState.hashCode ^ keychainState.hashCode;

  AppState copyWith({
    OnboardingState? onboardingState,
    LoginState? loginState,
    KeychainState? keychainState,
  }) {
    return AppState(
      onboardingState: onboardingState ?? this.onboardingState,
      loginState: loginState ?? this.loginState,
      keychainState: keychainState ?? this.keychainState,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'onboardingState': onboardingState.toMap(),
      'loginState': loginState.toMap(),
      'keychainState': keychainState.toMap(),
    };
  }

  factory AppState.fromMap(Map<String, dynamic> map) {
    return AppState(
      onboardingState: OnboardingState.fromMap(map['onboardingState']),
      loginState: LoginState.fromMap(map['loginState']),
      keychainState: KeychainState.fromMap(map['keychainState']),
    );
  }

  String toJson() => json.encode(toMap());

  factory AppState.fromJson(String source) => AppState.fromMap(json.decode(source));

  @override
  String toString() =>
      'AppState(onboardingState: $onboardingState, loginState: $loginState, keychainState: $keychainState)';
}
