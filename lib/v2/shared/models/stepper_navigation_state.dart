import 'package:freezed_annotation/freezed_annotation.dart';

part 'stepper_navigation_state.freezed.dart';

@freezed
class StepperNavigationState with _$StepperNavigationState {
  const factory StepperNavigationState({
    @Default(false) bool next,
    @Default(false) bool done,
  }) = _StepperNavigationState;
}
