// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

enum StepperNavigationControl {
  done,
  next,
}

final stepperNavigationControlProvider =
    StateNotifierProvider.autoDispose<StepperNavigationControlNotifier, Map<StepperNavigationControl, bool>>(
  (ref) {
    return StepperNavigationControlNotifier();
  },
);

class StepperNavigationControlNotifier extends StateNotifier<Map<StepperNavigationControl, bool>> {
  StepperNavigationControlNotifier()
      : super({
          StepperNavigationControl.done: true,
          StepperNavigationControl.next: true,
        });

  void setNextButton(bool value) {
    state = {
      StepperNavigationControl.done: false,
      StepperNavigationControl.next: value,
    };
  }

  void setDoneButton(bool value) {
    state = {
      StepperNavigationControl.done: value,
      StepperNavigationControl.next: false,
    };
  }
}
