import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ribn/models/internal_message.dart';
import 'package:ribn/models/keychain_state.dart';
import 'package:ribn/models/login_state.dart';
import 'package:ribn/models/onboarding_state.dart';
import 'package:ribn/models/user_details_state.dart';
import 'package:ribn/platform/platform.dart';

@immutable
class AppState {
  final OnboardingState onboardingState;
  final LoginState loginState;
  final KeychainState keychainState;
  final UserDetailsState userDetailsState;
  final InternalMessage? internalMessage;
  final String appVersion;

  const AppState({
    required this.onboardingState,
    required this.loginState,
    required this.keychainState,
    required this.userDetailsState,
    this.internalMessage,
    required this.appVersion,
  });

  factory AppState.initial() {
    return AppState(
      onboardingState: OnboardingState.initial(),
      loginState: LoginState.initial(),
      keychainState: KeychainState.initial(),
      userDetailsState: UserDetailsState.initial(),
      appVersion: getAppVersion(),
    );
  }

  factory AppState.test() {
    final String appVersion = getAppVersion();
    return AppState(
      onboardingState: OnboardingState.test(),
      loginState: LoginState.initial(),
      keychainState: KeychainState.test(),
      userDetailsState: UserDetailsState.initial(),
      appVersion: appVersion,
    );
  }

  bool needsOnboarding() {
    return (keychainState.keyStoreJson ?? '').isEmpty;
  }

  bool needsLogin() => keychainState.hdWallet == null;

  static String getAppVersion() {
    try {
      return PlatformUtils.instance.getCurrentAppVersion();
    } catch (e) {
      return 'Dev';
    }
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AppState &&
        other.onboardingState == onboardingState &&
        other.loginState == loginState &&
        other.keychainState == keychainState &&
        other.userDetailsState == userDetailsState &&
        other.internalMessage == internalMessage &&
        other.appVersion == appVersion;
  }

  @override
  int get hashCode {
    return onboardingState.hashCode ^
        loginState.hashCode ^
        keychainState.hashCode ^
        userDetailsState.hashCode ^
        internalMessage.hashCode ^
        appVersion.hashCode;
  }

  AppState copyWith({
    OnboardingState? onboardingState,
    LoginState? loginState,
    KeychainState? keychainState,
    UserDetailsState? userDetailsState,
    InternalMessage? internalMessage,
    String? appVersion,
  }) {
    return AppState(
      onboardingState: onboardingState ?? this.onboardingState,
      loginState: loginState ?? this.loginState,
      keychainState: keychainState ?? this.keychainState,
      userDetailsState: userDetailsState ?? this.userDetailsState,
      internalMessage: internalMessage ?? this.internalMessage,
      appVersion: appVersion ?? this.appVersion,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'loginState': loginState.toMap(),
      'keychainState': keychainState.toMap(),
      'userDetailsState': userDetailsState.toMap(),
      'appVersion': appVersion,
    };
  }

  factory AppState.fromMap(Map<String, dynamic> map) {
    return AppState(
      onboardingState: OnboardingState.initial(),
      loginState: LoginState.fromMap(map['loginState']),
      keychainState: KeychainState.fromMap(map['keychainState']),
      userDetailsState: UserDetailsState.fromMap(map['userDetailsState']),
      appVersion: getAppVersion(),
    );
  }

  String toJson() => json.encode(toMap());

  factory AppState.fromJson(String source) => AppState.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AppState(onboardingState: $onboardingState, loginState: $loginState, keychainState: $keychainState, userDetailsState: $userDetailsState, internalMessage: $internalMessage, appVersion: $appVersion)';
  }
}
