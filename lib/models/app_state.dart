import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:ribn/models/keychain_state.dart';
import 'package:ribn/models/login_state.dart';
import 'package:ribn/models/onboarding_state.dart';
import 'package:ribn/models/ui_state.dart';
import 'package:ribn/models/user_details_state.dart';

@immutable
class AppState {
  final OnboardingState onboardingState;
  final LoginState loginState;
  final KeychainState keychainState;
  final UiState uiState;
  final UserDetailsState userDetailsState;

  const AppState({
    required this.onboardingState,
    required this.loginState,
    required this.keychainState,
    required this.uiState,
    required this.userDetailsState,
  });

  factory AppState.initial() {
    return AppState(
      onboardingState: OnboardingState.initial(),
      loginState: LoginState.initial(),
      keychainState: KeychainState.initial(),
      uiState: UiState.initial(),
      userDetailsState: UserDetailsState.initial(),
    );
  }

  factory AppState.test() {
    return AppState(
      onboardingState: OnboardingState.test(),
      loginState: LoginState.initial(),
      keychainState: KeychainState.test(),
      uiState: UiState.initial(),
      userDetailsState: UserDetailsState.initial(),
    );
  }

  bool needsOnboarding() {
    return (keychainState.keyStoreJson ?? '').isEmpty;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AppState &&
        other.onboardingState == onboardingState &&
        other.loginState == loginState &&
        other.keychainState == keychainState &&
        other.uiState == uiState &&
        other.userDetailsState == userDetailsState;
  }

  @override
  int get hashCode {
    return onboardingState.hashCode ^
        loginState.hashCode ^
        keychainState.hashCode ^
        uiState.hashCode ^
        userDetailsState.hashCode;
  }

  AppState copyWith({
    OnboardingState? onboardingState,
    LoginState? loginState,
    KeychainState? keychainState,
    UiState? uiState,
    UserDetailsState? userDetailsState,
  }) {
    return AppState(
      onboardingState: onboardingState ?? this.onboardingState,
      loginState: loginState ?? this.loginState,
      keychainState: keychainState ?? this.keychainState,
      uiState: uiState ?? this.uiState,
      userDetailsState: userDetailsState ?? this.userDetailsState,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'onboardingState': onboardingState.toMap(),
      'loginState': loginState.toMap(),
      'keychainState': keychainState.toMap(),
      'uiState': uiState.toMap(),
      'userDetailsState': userDetailsState.toMap(),
    };
  }

  factory AppState.fromMap(Map<String, dynamic> map) {
    return AppState(
      onboardingState: OnboardingState.fromMap(map['onboardingState']),
      loginState: LoginState.fromMap(map['loginState']),
      keychainState: KeychainState.fromMap(map['keychainState']),
      uiState: UiState.initial(),
      userDetailsState: UserDetailsState.fromMap(map['userDetailsState']),
    );
  }

  String toJson() => json.encode(toMap());

  factory AppState.fromJson(String source) => AppState.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AppState(onboardingState: $onboardingState, loginState: $loginState, keychainState: $keychainState, uiState: $uiState, userDetailsState: $userDetailsState)';
  }
}
