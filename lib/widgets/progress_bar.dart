import 'package:flutter/material.dart';
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn_toolkit/constants/styles.dart';
import 'package:steps_indicator/steps_indicator.dart';

/// Custom progress bar displayed during onboarding
class CustomProgressBar extends StatelessWidget {
  const CustomProgressBar(this.currPage, {Key? key}) : super(key: key);
  final int currPage;
  final int numPages = 5;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      width: 1000,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            height: 45,
            child: StepsIndicator(
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
            ),
          ),
          SizedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                buildPageLabel(0, 180),
                const SizedBox(width: 30),
                buildPageLabel(1, 180),
                const SizedBox(width: 30),
                buildPageLabel(2, 180),
                const SizedBox(width: 35),
                buildPageLabel(3, 200),
                const SizedBox(width: 60),
                buildPageLabel(4, 100),
              ],
            ),
          )
        ],
      ),
    );
  }

  /// Builds the appropriate label under the currently active position in the progress bar.
  Widget buildPageLabel(int pageNum, double width) {
    return SizedBox(
      width: width,
      child: Center(
        child: Text(
          getLabel(pageNum),
          style: RibnToolkitTextStyles.smallBoldLabel.copyWith(
            color: pageNum != currPage ? Colors.transparent : RibnColors.defaultText,
          ),
        ),
      ),
    );
  }

  String getLabel(int pageNum) {
    switch (pageNum) {
      case 0:
        return Strings.generateSeedPhrase.toUpperCase();
      case 1:
        return Strings.writeDownSeedPhrase.toUpperCase();
      case 2:
        return Strings.confirmSeedPhrase.toUpperCase();
      case 3:
        return Strings.createWalletPassword.toUpperCase();
      case 4:
        return Strings.finalReview.toUpperCase();
      default:
        return '';
    }
  }
}
