import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ribn/constants/assets.dart';
import 'package:ribn/constants/routes.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/presentation/onboarding/utils.dart';
import 'package:ribn/presentation/onboarding/widgets/confirmation_button.dart';
import 'package:ribn/presentation/onboarding/widgets/onboarding_container.dart';
import 'package:ribn/presentation/onboarding/widgets/web_onboarding_app_bar.dart';
import 'package:ribn/utils.dart';
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn_toolkit/constants/styles.dart';

class GettingStartedPage extends StatelessWidget {
  const GettingStartedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OnboardingContainer(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              renderIfWeb(const WebOnboardingAppBar()),
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
                width: kIsWeb ? 730 : 350,
                child: Text(
                  Strings.gettingStartedDescription,
                  style: onboardingH3,
                ),
              ),
              kIsWeb ? const SizedBox(height: 150) : const Spacer(),
              ConfirmationButton(
                text: Strings.okLetsGo,
                onPressed: () => navigateToRoute(context, Routes.seedPhraseInfoChecklist),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
