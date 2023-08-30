// Flutter imports:
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ribn/v2/send_assets/models/send_asset_state.dart';
import 'package:ribn/v2/shared/providers/logger_provider.dart';

final sendAssetProvider = StateNotifierProvider<SendAssetNotifier, SendAssetState>((ref) {
  return SendAssetNotifier(ref);
});

class SendAssetNotifier extends StateNotifier<SendAssetState> {
  final Ref ref;
  final pageController = PageController(initialPage: 0);

  SendAssetNotifier(this.ref) : super(_initializeSendAssetState(ref)) {}

  static SendAssetState _initializeSendAssetState(ref) {
    return SendAssetState();
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
      ref.read(loggerProvider).log(
            logLevel: LogLevel.Severe,
            loggerClass: LoggerClass.Navigation,
            message: "Failed to navigate to page $index with error: $e",
          );
      return false;
    }
  }

  finish() {
    // TODO
    // pageController.jumpToPage(0);
  }

  void reset() {
    pageController.jumpToPage(0);
  }
}
