// Dart imports:
import 'dart:convert';

// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:ribn/v1/models/internal_message.dart';
import 'package:ribn/v1/models/keychain_state.dart';
import 'package:ribn/v1/models/onboarding_state.dart';
import 'package:ribn/v1/models/user_details_state.dart';

@immutable
class AppState {
  final KeychainState keychainState;
  final UserDetailsState userDetailsState;
  final InternalMessage? internalMessage;

  AppState({
    required this.keychainState,
    required this.userDetailsState,
    this.internalMessage,
  });

  factory AppState.initial() {
    return AppState(
      keychainState: KeychainState.initial(),
      userDetailsState: UserDetailsState.initial(),
    );
  }

  factory AppState.test({
    bool isNewUser = false,
  }) {
    return AppState(
      keychainState: !isNewUser ? KeychainState.test() : KeychainState.initial(),
      userDetailsState: UserDetailsState.initial(),
    );
  }

  bool needsOnboarding() {
    return (keychainState.keyStoreJson ?? '').isEmpty;
  }

  bool needsLogin() => keychainState.hdWallet == null;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AppState &&
        other.keychainState == keychainState &&
        other.userDetailsState == userDetailsState &&
        other.internalMessage == internalMessage;
  }

  @override
  int get hashCode {
    return keychainState.hashCode ^ userDetailsState.hashCode ^ internalMessage.hashCode;
  }

  AppState copyWith({
    OnboardingState? onboardingState,
    KeychainState? keychainState,
    UserDetailsState? userDetailsState,
    InternalMessage? internalMessage,
    String? appVersion,
  }) {
    return AppState(
      keychainState: keychainState ?? this.keychainState,
      userDetailsState: userDetailsState ?? this.userDetailsState,
      internalMessage: internalMessage ?? this.internalMessage,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'keychainState': keychainState.toMap(),
      'userDetailsState': userDetailsState.toMap(),
    };
  }

  factory AppState.fromMap(Map<String, dynamic> map) {
    return AppState(
      keychainState: KeychainState.fromMap(map['keychainState']),
      userDetailsState: UserDetailsState.fromMap(map['userDetailsState']),
    );
  }

  String toJson() => json.encode(toMap());

  factory AppState.fromJson(String source) => AppState.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AppState(keychainState: $keychainState, userDetailsState: $userDetailsState, internalMessage: $internalMessage)';
  }
}
