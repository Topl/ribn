import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:ribn/models/keychain_state.dart';
import 'package:ribn/models/login_state.dart';
import 'package:ribn/models/onboarding_state.dart';

@immutable
class AppState {
  final OnboardingState onboardingState;
  final LoginState loginState;
  final KeyChainState keyChainState;

  const AppState({
    required this.onboardingState,
    required this.loginState,
    required this.keyChainState,
  });

  factory AppState.initial() {
    return AppState(
      onboardingState: OnboardingState.initial(),
      loginState: LoginState.initial(),
      keyChainState: KeyChainState.initial(),
    );
  }

  bool keyStoreExists() {
    return (keyChainState.keyStoreJson ?? "").isNotEmpty;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AppState &&
        other.onboardingState == onboardingState &&
        other.loginState == loginState &&
        other.keyChainState == keyChainState;
  }

  @override
  int get hashCode => onboardingState.hashCode ^ loginState.hashCode ^ keyChainState.hashCode;

  AppState copyWith({
    OnboardingState? onboardingState,
    LoginState? loginState,
    KeyChainState? keyChainState,
  }) {
    return AppState(
      onboardingState: onboardingState ?? this.onboardingState,
      loginState: loginState ?? this.loginState,
      keyChainState: keyChainState ?? this.keyChainState,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'onboardingState': onboardingState.toMap(),
      'loginState': loginState.toMap(),
      'keyChainState': keyChainState.toMap(),
    };
  }

  factory AppState.fromMap(Map<String, dynamic> map) {
    return AppState(
      onboardingState: OnboardingState.fromMap(map['onboardingState']),
      loginState: LoginState.fromMap(map['loginState']),
      keyChainState: KeyChainState.fromMap(map['keyChainState']),
    );
  }

  String toJson() => json.encode(toMap());

  factory AppState.fromJson(String source) => AppState.fromMap(json.decode(source));

  @override
  String toString() =>
      'AppState(onboardingState: $onboardingState, loginState: $loginState, keyChainState: $keyChainState)';
}
