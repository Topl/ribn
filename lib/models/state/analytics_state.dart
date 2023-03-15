// Package imports:
import 'package:freezed_annotation/freezed_annotation.dart';

part 'analytics_state.freezed.dart';

@freezed
class AnalyticsState with _$AnalyticsState {
  // Added constructor. Must not have any parameter
  const AnalyticsState._();

  const factory AnalyticsState({
    @Default(false) bool isEnabled,
  }) = _AnalyticsState;
}
