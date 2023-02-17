import 'package:freezed_annotation/freezed_annotation.dart';

part 'password_state.freezed.dart';

@freezed
class PasswordState with _$PasswordState {
  // Added constructor. Must not have any parameter
  const PasswordState._();

  const factory PasswordState({
    @Default(false) bool termsOfUseChecked,
    @Default('') String password,
    @Default('') String confirmPassword,
  }) = _PasswordState;

  get passwordsMatch {
    return password == confirmPassword;
  }

  get atLeast8Chars {
    return password.length > 7;
  }
}
