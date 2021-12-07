import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:ribn/models/keychain_state.dart';
import 'package:ribn/models/login_state.dart';
import 'package:ribn/models/onboarding_state.dart';
import 'package:ribn/models/ui_state.dart';

@immutable
class AppState {
  final OnboardingState onboardingState;
  final LoginState loginState;
  final KeychainState keychainState;
  final UiState uiState;

  const AppState({
    required this.onboardingState,
    required this.loginState,
    required this.keychainState,
    required this.uiState,
  });

  factory AppState.initial() {
    return AppState(
      onboardingState: OnboardingState.initial(),
      loginState: LoginState.initial(),
      keychainState: KeychainState.initial(),
      uiState: UiState.initial(),
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
        other.keychainState == keychainState &&
        other.uiState == uiState;
  }

  @override
  int get hashCode {
    return onboardingState.hashCode ^ loginState.hashCode ^ keychainState.hashCode ^ uiState.hashCode;
  }

  AppState copyWith({
    OnboardingState? onboardingState,
    LoginState? loginState,
    KeychainState? keychainState,
    UiState? uiState,
  }) {
    return AppState(
      onboardingState: onboardingState ?? this.onboardingState,
      loginState: loginState ?? this.loginState,
      keychainState: keychainState ?? this.keychainState,
      uiState: uiState ?? this.uiState,
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
      onboardingState: OnboardingState.fromMap(map['onboardingState'] as Map<String, dynamic>),
      loginState: LoginState.fromMap(map['loginState'] as Map<String, dynamic>),
      keychainState: KeychainState.fromMap(map['keychainState'] as Map<String, dynamic>),
      uiState: UiState.initial(),
    );
  }

  String toJson() => json.encode(toMap());

  factory AppState.fromJson(String source) => AppState.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AppState(onboardingState: $onboardingState, loginState: $loginState, keychainState: $keychainState, uiState: $uiState)';
  }
}
