import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ribn/models/onboarding_state.dart';

@immutable
class AppState {
  final OnboardingState onboardingState;
  const AppState({
    required this.onboardingState,
  });

  factory AppState.initial() {
    return AppState(onboardingState: OnboardingState.initial());
  }

  bool keyStoreExists() {
    return (onboardingState.keyStoreJson ?? "").isNotEmpty;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AppState && other.onboardingState == onboardingState;
  }

  @override
  int get hashCode => onboardingState.hashCode;

  AppState copyWith({
    OnboardingState? onboardingState,
  }) {
    return AppState(
      onboardingState: onboardingState ?? this.onboardingState,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'onboardingState': onboardingState.toMap(),
    };
  }

  factory AppState.fromMap(Map<String, dynamic> map) {
    return AppState(
      onboardingState: OnboardingState.fromMap(map['onboardingState']),
    );
  }

  String toJson() => json.encode(toMap());

  factory AppState.fromJson(String source) => AppState.fromMap(json.decode(source));

  @override
  String toString() => 'AppState(onboardingState: $onboardingState)';
}
