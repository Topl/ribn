// Package imports:
import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_state.freezed.dart';

@freezed
class LoginState with _$LoginState {
  const factory LoginState({
    /// True if biometrics authentication is enabled for login
    @Default(false) bool isBiometricsEnabled,
    @Default(false) bool isLoggedIn,
  }) = _LoginState;
}
