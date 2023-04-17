// Package imports:
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ribn/v1/providers/analytics/analytics_events.dart';

// Project imports:

part 'analytics_state.freezed.dart';

@freezed
class AnalyticsState with _$AnalyticsState {
  // Added constructor. Must not have any parameter
  const AnalyticsState._();

  const factory AnalyticsState({
    @Default(false) bool isEnabled,
    @Default(UserType.Initial) UserType userType,
  }) = _AnalyticsState;
}
