import 'package:freezed_annotation/freezed_annotation.dart';

part 'stepper_screen_state.freezed.dart';

@freezed
class StepperScreenState with _$StepperScreenState {
  const factory StepperScreenState({
    @Default(0) int pageIndex,
  }) = _StepperScreenState;
}
