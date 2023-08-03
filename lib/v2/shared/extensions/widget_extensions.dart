// Flutter imports:
import 'package:flutter/material.dart';

/// Extension methods for widgets.
extension WidgetExtensions on Widget {
  /// Shows the widget as a modal bottom sheet.
  ///
  /// @required [context] - The build context.
  ///
  /// [initialChildSize] - The initial height of the modal bottom sheet as a fraction of the screen height. Default is 0.95.
  ///
  /// [maxChildSize] - The maximum height of the modal bottom sheet as a fraction of the screen height. Default is 1.0.
  ///
  /// [minChildSize] - The minimum height of the modal bottom sheet as a fraction of the screen height. Default is 0.25.
  ///
  /// [controller] - The controller for the draggable scrollable sheet. Default is a new instance of [DraggableScrollableController].
  Future<void> showAsModal(BuildContext context,
      {double initialChildSize = 0.95,
      double maxChildSize = 1.0,
      double minChildSize = 0.25,
      DraggableScrollableController? controller}) async {
    assert(initialChildSize > 0.0 && initialChildSize <= 1.0, 'Initial child size must be between 0.0 and 1.0.');
    assert(maxChildSize >= initialChildSize && maxChildSize <= 1.0,
        'Max child size must be greater than or equal to initial child size and less than or equal to 1.0.');
    assert(minChildSize >= 0.0 && minChildSize <= initialChildSize,
        'Min child size must be between 0.0 and initial child size.');

    final DraggableScrollableController scrollController = controller ?? DraggableScrollableController();
    await showModalBottomSheet(
      isScrollControlled: true,
      useSafeArea: true,
      context: context,
      enableDrag: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
            initialChildSize: initialChildSize,
            maxChildSize: maxChildSize,
            minChildSize: minChildSize,
            expand: false,
            controller: scrollController,
            builder: (BuildContext context, ScrollController scrollController) {
              return this;
            });
      },
    );
  }
}
