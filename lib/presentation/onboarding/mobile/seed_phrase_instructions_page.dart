import 'package:flutter/material.dart';
import 'package:ribn/constants/assets.dart';
import 'package:ribn/constants/routes.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/presentation/onboarding/mobile/widgets/confirmation_button.dart';
import 'package:ribn/presentation/onboarding/mobile/widgets/onboarding_container.dart';
import 'package:ribn/presentation/onboarding/mobile/widgets/onboarding_page_padding.dart';
import 'package:ribn/utils.dart';
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn_toolkit/constants/styles.dart';

/// This page shows intructions on how to keep the seed phrase secure.
class SeedPhraseInstructionsPage extends StatelessWidget {
  const SeedPhraseInstructionsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OnboardingContainer(
        child: OnboardingPagePadding(
          child: Center(
            child: Column(
              children: [
                Text(
                  Strings.beforeYouStart,
                  style: RibnToolkitTextStyles.h1.copyWith(
                    color: RibnColors.lightGreyTitle,
                    fontSize: 28,
                  ),
                ),
                const SizedBox(height: 60),
                Text(
                  Strings.weRecommendSub,
                  style: RibnToolkitTextStyles.h3.copyWith(
                    color: RibnColors.lightGreyTitle,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 40),
                _buildListItem(RibnAssets.penPaperPng, Strings.paperAndPen, topTextPadding: 5),
                _buildListItem(
                  RibnAssets.passwordLockPng,
                  Strings.securePasswordManager,
                  rightIconPadding: 4,
                  topTextPadding: 5,
                ),
                _buildListItem(RibnAssets.programPng, Strings.encryptTextFile, rightIconPadding: 2),
                const Spacer(),
                ConfirmationButton(
                  text: Strings.iUnderstand,
                  onPressed: () => navigateToRoute(context, Routes.generateSeedPhrase),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildListItem(
    String pngIcon,
    String text, {
    double leftIconPadding = 0,
    double rightIconPadding = 0,
    double topTextPadding = 0,
    double width = 30,
    double height = 30,
  }) {
    return SizedBox(
      width: 350,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Wrap(
          children: [
            SizedBox(
              width: width,
              height: height,
              child: Padding(
                padding: EdgeInsets.only(left: leftIconPadding, right: rightIconPadding),
                child: Image.asset(pngIcon, width: 30),
              ),
            ),
            const SizedBox(width: 10),
            Padding(
              padding: EdgeInsets.only(top: topTextPadding),
              child: SizedBox(
                width: 295,
                child: Text(
                  text,
                  textHeightBehavior: const TextHeightBehavior(applyHeightToFirstAscent: false),
                  style: RibnToolkitTextStyles.h3.copyWith(
                    color: RibnColors.lightGreyTitle,
                    fontSize: 18,
                    height: 1.67,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
