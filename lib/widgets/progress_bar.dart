import 'package:flutter/material.dart';
import 'package:ribn/constants/colors.dart';
import 'package:ribn/constants/strings.dart';
import 'package:steps_indicator/steps_indicator.dart';

/// Custom progress bar displayed during onboarding
class CustomProgressBar extends StatelessWidget {
  const CustomProgressBar(this.currPage, {Key? key}) : super(key: key);
  final int currPage;
  final int numPages = 5;

  @override
  Widget build(BuildContext context) {
    return StepsIndicator(
      selectedStep: currPage,
      nbSteps: numPages,
      selectedStepColorOut: Colors.white,
      selectedStepColorIn: Colors.white,
      doneStepColor: Colors.white,
      doneLineColor: RibnColors.primary,
      undoneLineColor: RibnColors.inactive,
      isHorizontal: true,
      doneLineThickness: 3,
      lineLength: 195,
      undoneLineThickness: 3,
      selectedStepSize: 10,
      doneStepWidget: const CircleAvatar(
        backgroundColor: RibnColors.primary,
        foregroundColor: Colors.white,
        radius: 15,
        child: Icon(Icons.check),
      ),
      unselectedStepWidget: const CircleAvatar(
        backgroundColor: RibnColors.inactive,
        radius: 7,
      ),
      selectedStepWidget: CircleAvatar(
        radius: 22,
        backgroundColor: RibnColors.accent,
        child: CircleAvatar(
          backgroundColor: RibnColors.primary,
          foregroundColor: Colors.white,
          radius: 15,
          child: Text('${currPage + 1}'),
        ),
      ),
    );
  }

  String getLabel() {
    switch (currPage) {
      case 0:
        return Strings.generateSeedPhrase.toUpperCase();
      case 1:
        return Strings.writeDownSeedPhrase.toUpperCase();
      case 2:
        return Strings.confirmSeedPhrase.toUpperCase();
      default:
        return Strings.createWalletPassword.toUpperCase();
    }
  }
}
