// Flutter imports:
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/stepper_screen_state.dart';

final stepperScreenProvider = StateNotifierProvider<StepperScreenNotifier, StepperScreenState>((ref) {
  return StepperScreenNotifier(ref);
});

class StepperScreenNotifier extends StateNotifier<StepperScreenState> {
  final Ref ref;
  final pageController = PageController(initialPage: 0);

  StepperScreenNotifier(this.ref) : super(_initializeStepperScreenState(ref)) {}

  static StepperScreenState _initializeStepperScreenState(ref) {
    return StepperScreenState();
  }

  /// Navigates to a different page in the [PageView].
  ///
  /// If [index] is specified, the [PageView] will animate to the page at that index.
  ///
  /// If [index] is `null`, the [PageView] will animate to the next or previous page
  /// based on the value of [reverse].
  ///
  /// Throws an [AssertionError] if [pageController.page] is `null`.
  ///
  /// If the result of navigation is out of the lower bounds for the page controller
  /// it will return [true] for [WillPopScope] to handle
  ///
  /// If successful, animates the transition to the new page using [pageController.animateToPage].
  ///
  /// Example:
  ///
  /// ```dart
  /// // Navigate to the next page in the PageView
  /// navigate();
  ///
  /// // Navigate to the third page in the PageView
  /// navigate(index: 2);
  ///
  /// // Navigate to the previous page in the PageView
  /// navigate(reverse: true);
  /// ```
  bool navigateToPage({int? index, bool reverse = false}) {
    assert(pageController.page != null);
    try {
      int goToIndex = 0;
      if (index != null) {
        goToIndex = index;
      } else {
        // Goes to the next page, goes to previous page if reverse is true
        goToIndex = pageController.page!.toInt() + (reverse ? -1 : 1);
        print("went to $goToIndex");
      }

      // catch out of bounds, return true for [WillPopScope] to handle
      if (goToIndex < 0) return true;

      state = state.copyWith(pageIndex: goToIndex);
      pageController.animateToPage(
        goToIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );

      return false;
    } catch (e) {
      return false;
    }
  }

  finish() {
    // TODO
  }

  void reset() {
    pageController.jumpToPage(0);
  }
}
