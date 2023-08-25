// Package imports:
import 'package:freezed_annotation/freezed_annotation.dart';

part 'recovery_state.freezed.dart';

@freezed
class RecoveryState with _$RecoveryState {
  const factory RecoveryState({
    @Default("") String pin,
    @Default(false) bool biometricsEnrolled,
    required List<String?> recoveryPhrase,
  }) = _RecoveryState;
}
