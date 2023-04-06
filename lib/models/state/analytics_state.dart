// Package imports:
import 'package:freezed_annotation/freezed_annotation.dart';

// Project imports:
import 'package:ribn/providers/analytics/analytics_events.dart';

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
