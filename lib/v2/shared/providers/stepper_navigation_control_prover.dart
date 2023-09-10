// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/stepper_navigation_state.dart';

final stepperNavigationControlProvider =
    StateNotifierProvider.autoDispose<StepperNavigationControlNotifier, StepperNavigationState>(
  (ref) {
    return StepperNavigationControlNotifier();
  },
);

class StepperNavigationControlNotifier extends StateNotifier<StepperNavigationState> {
  StepperNavigationControlNotifier()
      : super(
          StepperNavigationState(),
        );

  void setNextButton(bool value) {
    state = StepperNavigationState(
      next: value,
      done: false,
    );
  }

  void setDoneButton(bool value) {
    state = StepperNavigationState(
      next: false,
      done: value,
    );
  }
}
