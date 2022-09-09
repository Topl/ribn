import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ribn/constants/assets.dart';
import 'package:ribn/constants/keys.dart';
import 'package:ribn/constants/routes.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/presentation/onboarding/utils.dart';
import 'package:ribn/presentation/onboarding/widgets/confirmation_button.dart';
import 'package:ribn/presentation/onboarding/widgets/onboarding_container.dart';
import 'package:ribn/presentation/onboarding/widgets/web_onboarding_app_bar.dart';
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
        child: SingleChildScrollView(
          clipBehavior: Clip.none,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                renderIfWeb(const WebOnboardingAppBar()),
                const Text(
                  Strings.beforeYouStart,
                  style: RibnToolkitTextStyles.onboardingH1,
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
                _buildListItem(
                  RibnAssets.penPaperPng,
                  Strings.paperAndPen,
                  textTopPadding: 5,
                  width: 30,
                  height: 32,
                ),
                _buildListItem(
                  RibnAssets.passwordLockPng,
                  Strings.securePasswordManager,
                  iconRightPadding: 4,
                  textTopPadding: 5,
                  width: 27,
                  height: 31,
                ),
                _buildListItem(
                  RibnAssets.programPng,
                  Strings.encryptTextFile,
                  iconRightPadding: 2,
                  width: 23,
                  height: 25,
                ),
                SizedBox(height: adaptHeight(0.1)),
                ConfirmationButton(
                  text: Strings.iUnderstand,
                  onPressed: () {
                    Keys.navigatorKey.currentState?.pushNamed(Routes.generateSeedPhrase);
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
                width: kIsWeb ? 500 : 295,
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
