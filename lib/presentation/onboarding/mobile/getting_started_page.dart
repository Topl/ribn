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

class GettingStartedPageMobile extends StatelessWidget {
  const GettingStartedPageMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OnboardingContainer(
        child: OnboardingPagePadding(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  Strings.gettingStarted,
                  textAlign: TextAlign.center,
                  style: RibnToolkitTextStyles.h1.copyWith(
                    color: RibnColors.lightGreyTitle,
                    fontSize: 28,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 35.0, bottom: 45),
                  child: Image.asset(RibnAssets.gettingStartedPng, width: 70),
                ),
                SizedBox(
                  width: 310,
                  height: 220,
                  child: Text(
                    Strings.gettingStartedDescription,
                    style: RibnToolkitTextStyles.h3.copyWith(
                      color: RibnColors.lightGreyTitle,
                      fontSize: 18,
                      height: 1.6,
                    ),
                  ),
                ),
                const Spacer(),
                ConfirmationButton(
                  text: Strings.okLetsGo,
                  onPressed: () => navigateToRoute(context, Routes.seedPhraseInfoChecklist),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
