import 'package:flutter/material.dart';
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn_toolkit/widgets/molecules/onboarding_progress_bar.dart';

class WebOnboardingAppBar extends StatelessWidget {
  final int? currStep;
  final VoidCallback? onTap;

  const WebOnboardingAppBar({
    Key? key,
    this.currStep,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Row(
        children: [
          Expanded(
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: GestureDetector(
                    onTap: onTap ?? () => Navigator.of(context).pop(),
                    child: const Icon(
                      Icons.arrow_back,
                      size: 40,
                      color: RibnColors.lightGreyTitle,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: currStep != null
                        ? OnboardingProgressBar(
                            numSteps: 4,
                            currStep: currStep!,
                          )
                        : const SizedBox(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
