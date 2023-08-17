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
  bool navigateToPage(BuildContext context, {int? index, bool reverse = false}) {
    if (index != null) {
      pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      return false;
    }
    final currentPage = pageController.page;
    if (currentPage == null) {
      throw AssertionError('PageController.page is null');
    }

    if (reverse) {
      if (currentPage > 0) {
        pageController.previousPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
        return false;
      }
      return true;
    } else {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      return true;
    }
  }

  finish() {
    // TODO
  }
  void reset() {
    pageController.jumpToPage(0);
  }
}
