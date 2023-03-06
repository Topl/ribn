// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn_toolkit/constants/styles.dart';

// Project imports:
import 'package:ribn/constants/assets.dart';
import 'package:ribn/constants/keys.dart';
import 'package:ribn/constants/routes.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/presentation/onboarding/utils.dart';
import 'package:ribn/presentation/onboarding/widgets/confirmation_button.dart';
import 'package:ribn/presentation/onboarding/widgets/onboarding_container.dart';
import 'package:ribn/presentation/onboarding/widgets/web_onboarding_app_bar.dart';

class GettingStartedPage extends StatelessWidget {
  static const Key gettingStartedPageKey = Key('gettingStartedPageKey');
  static const Key gettingStartedConfirmationButtonKey = Key('gettingStartedConfirmationButtonKey');
  const GettingStartedPage({Key key = gettingStartedPageKey}) : super(key: key);

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
              const SizedBox(
                width: kIsWeb ? 730 : 350,
                child: Text(
                  Strings.gettingStartedDescription,
                  style: RibnToolkitTextStyles.onboardingH3,
                ),
              ),
              kIsWeb ? const SizedBox(height: 150) : const Spacer(),
<<<<<<< HEAD
              Padding(
                padding: EdgeInsets.only(bottom: 50),
                child: ConfirmationButton(
                  key: gettingStartedConfirmationButtonKey,
                  text: Strings.okLetsGo,
                  onPressed: () {
                    Keys.navigatorKey.currentState?.pushNamed(Routes.seedPhraseInfoChecklist);
                  },
                ),
=======
              ConfirmationButton(
                text: Strings.okLetsGo,
                onPressed: () {
                  Keys.navigatorKey.currentState
                      ?.pushNamed(Routes.seedPhraseInfoChecklist);
                },
>>>>>>> rc-0.4
              ),
            ],
          ),
        ),
      ),
    );
  }
}
