import 'package:flutter/material.dart';

/// A widget that displays a sequence of indicators to indicate progress through a series of steps.
///
/// The [StepIndicator] displays a sequence of indicators in a row to indicate
/// the current step and the progress made towards the final step
/// .
/// The [StepIndicator] displays a horizontal row of indicators, with each indicator representing
/// a single step in the sequence. The current step is highlighted with the [currentIndicatorColor],
/// and progress towards the final step is indicated by the color of the inactive indicators.
///
/// @throws [AssertionError] if the [currentStep] is less than 0 or greater than or equal to [totalSteps],
/// if the [totalSteps] is less than 1, if the [indicatorSize] is less than or equal to 0,
/// or if the [indicatorSpacing] is less than 0.

/// @throws [AssertionError] when [currentStep] is less than 0 or greater than or equal to [totalSteps],
/// or when [totalSteps] is less than 1,
/// or when [indicatorSize] is less than or equal to 0,
/// or when [indicatorSpacing] is less than 0.
///
class StepIndicator extends StatelessWidget {
  const StepIndicator({
    Key? key,
    required this.currentStep,
    required this.totalSteps,
    this.indicatorSize = 5.0,
    this.indicatorSpacing = 3.0,
    this.indicatorColor = Colors.grey,
    this.currentIndicatorColor = Colors.blue,
  })  : assert(currentStep >= 0 && currentStep < totalSteps, 'The current step must be greater than or equal to 0 and less than the total number of steps.'),
        assert(totalSteps > 0, 'The total number of steps must be greater than 0.'),
        assert(indicatorSize > 0, 'The indicator size must be greater than 0.'),
        assert(indicatorSpacing >= 0, 'The indicator spacing must be greater than or equal to 0.'),
        super(key: key);

  /// The current step index. The current step is highlighted with the [currentIndicatorColor].
  final int currentStep;

  /// The total number of steps.
  final int totalSteps;

  /// The size of each indicator. Defaults to 5.0.
  final double indicatorSize;

  /// The spacing between each indicator. Defaults to 3.0.
  final double indicatorSpacing;

  /// The color of inactive indicators. Defaults to Colors.grey
  final Color indicatorColor;

  /// The color of the active indicator. Defaults to Colors.blue
  final Color currentIndicatorColor;


  @override
  Widget build(BuildContext context) {

    // Create the list of indicators.
    final indicators = List.generate(totalSteps, (index) {
      final isCurrentStep = index == currentStep;
      final color = isCurrentStep ? currentIndicatorColor : indicatorColor;
      return Expanded(
        child: Container(
          height: indicatorSize,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(indicatorSize / 2),
          ),
        ),
      );
    });

    // Create the separator between the indicators.
    final separator = SizedBox(width: indicatorSpacing);

    // Return the list of indicators.
    // The fold method is used to combine the indicators list with the separator widget.
    // The first argument to fold is an initial value for the accumulator
    // The second argument is a function that takes two parameters: the accumulator and the current item in the list.
    // In each iteration, the fold function checks if the list is empty, which means it is the first iteration and the separator widget should not be included.
    // Otherwise, the separator widget is included before the current indicator.
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: indicators.fold<List<Widget>>([], (list, current) {
        final isLast = list.isEmpty;
        final result = [...list, if (!isLast) separator, current];
        return result;
      }),
    );
  }
}
