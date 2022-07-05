import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ribn/constants/assets.dart';
import 'package:ribn/constants/routes.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/presentation/onboarding/mobile/helpers.dart';
import 'package:ribn/presentation/onboarding/mobile/widgets/confirmation_button.dart';
import 'package:ribn/presentation/onboarding/mobile/widgets/onboarding_container.dart';
import 'package:ribn/presentation/onboarding/mobile/widgets/onboarding_page_padding.dart';
import 'package:ribn/utils.dart';
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn_toolkit/constants/styles.dart';

/// This page shows intructions on how to keep the seed phrase secure.
class SeedPhraseInstructionsPageMobile extends StatelessWidget {
  const SeedPhraseInstructionsPageMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OnboardingContainer(
        child: OnboardingPagePadding(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  Strings.beforeYouStart,
                  style: RibnToolkitTextStyles.h1.copyWith(
                    color: RibnColors.lightGreyTitle,
                    fontSize: 28,
                  ),
                ),
                const SizedBox(height: 60),
                SizedBox(
                  width: kIsWeb ? 550 : 350,
                  child: Text(
                    Strings.weRecommendSub,
                    style: RibnToolkitTextStyles.h3.copyWith(
                      color: RibnColors.lightGreyTitle,
                      fontSize: 18,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                _buildListItem(RibnAssets.penPaperPng, Strings.paperAndPen, textTopPadding: 5),
                _buildListItem(
                  RibnAssets.passwordLockPng,
                  Strings.securePasswordManager,
                  iconRightPadding: 4,
                  textTopPadding: 5,
                ),
                _buildListItem(RibnAssets.programPng, Strings.encryptTextFile, iconRightPadding: 2),
                adaptableSpacer(),
                ConfirmationButton(
                  text: Strings.iUnderstand,
                  onPressed: () {
                    navigateToRoute(context, Routes.generateSeedPhrase);
                  },
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
    double iconLeftPadding = 0,
    double iconRightPadding = 0,
    double textTopPadding = 0,
    double width = 30,
    double height = 30,
  }) {
    return SizedBox(
      width: kIsWeb ? 550 : 350,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Wrap(
          children: [
            SizedBox(
              width: width,
              height: height,
              child: Padding(
                padding: EdgeInsets.only(left: iconLeftPadding, right: iconRightPadding),
                child: Image.asset(pngIcon, width: 30),
              ),
            ),
            const SizedBox(width: 10),
            Padding(
              padding: EdgeInsets.only(top: textTopPadding),
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
