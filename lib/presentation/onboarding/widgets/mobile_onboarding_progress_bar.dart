import 'package:flutter/material.dart';
import 'package:ribn_toolkit/widgets/molecules/onboarding_progress_bar.dart';

class MobileOnboardingProgressBar extends StatelessWidget {
  final int currStep;
  const MobileOnboardingProgressBar({
    Key? key,
    required this.currStep,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: OnboardingProgressBar(numSteps: 4, currStep: currStep),
    );
  }
}
