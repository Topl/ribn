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
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn_toolkit/widgets/atoms/text/ribn_h1_text_widget.dart';
import 'package:ribn_toolkit/widgets/atoms/text/ribn_onboarding_h3_text_widget.dart';

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
              const RibnH1TextWidget(
                text: Strings.gettingStarted,
                textAlignment: TextAlign.center,
                textColor: RibnColors.lightGreyTitle,
                fontWeight: FontWeight.w700,
                textHeight: 1.57,
                letterSpacing: 1.68,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 35.0, bottom: 45),
                child: Image.asset(RibnAssets.gettingStartedPng, width: 70),
              ),
              const SizedBox(
                  width: kIsWeb ? 730 : 350,
                  child: RibnOnboardingH3TextWidget(
                    text: Strings.gettingStartedDescription,
                    textAlignment: TextAlign.justify,
                    textColor: RibnColors.lightGreyTitle,
                  ),),
              kIsWeb ? const SizedBox(height: 150) : const Spacer(),
              ConfirmationButton(
                text: Strings.okLetsGo,
                onPressed: () {
                  Keys.navigatorKey.currentState
                      ?.pushNamed(Routes.seedPhraseInfoChecklist);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
