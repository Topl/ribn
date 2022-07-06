import 'package:flutter/material.dart';
import 'package:ribn/constants/assets.dart';
import 'package:ribn/constants/routes.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/presentation/onboarding/utils.dart';
import 'package:ribn/presentation/onboarding/widgets/accordion2.dart';
import 'package:ribn/presentation/onboarding/widgets/confirmation_button.dart';
import 'package:ribn/presentation/onboarding/widgets/mobile_onboarding_progress_bar.dart';
import 'package:ribn/presentation/onboarding/widgets/onboarding_container.dart';
import 'package:ribn/presentation/onboarding/widgets/web_onboarding_app_bar.dart';
import 'package:ribn/utils.dart';
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn_toolkit/constants/styles.dart';

/// This page is displayed when user successfully creates their wallet.
class WalletCreatedPage extends StatefulWidget {
  const WalletCreatedPage({Key? key}) : super(key: key);

  @override
  State<WalletCreatedPage> createState() => _WalletCreatedPageState();
}

class _WalletCreatedPageState extends State<WalletCreatedPage> {
  /// FAQs and their corresponding answeres
  final Map<String, String> faqs = {
    Strings.howCanIKeepMySeedPhraseSecure: Strings.howCanIKeepMySeedPhraseSecureAns,
    Strings.howIsASeedPhraseDifferent: Strings.howIsASeedPhraseDifferentAns,
    Strings.howIsMySeedPhraseUnrecoverable: Strings.howIsMySeedPhraseUnrecoverableAns,
  };
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OnboardingContainer(
        child: SingleChildScrollView(
          clipBehavior: Clip.none,
          child: Column(
            children: [
              renderIfWeb(const WebOnboardingAppBar(currStep: 3)),
              Text(
                Strings.walletCreated,
                style: onboardingH1,
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Image.asset(
                  RibnAssets.successPng,
                  width: 100,
                ),
              ),
              SizedBox(
                width: 730,
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        Strings.walletCreatedDesc,
                        style: onboardingH3,
                      ),
                    ),
                    SizedBox(height: adaptHeight(0.05)),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        Strings.frequentlyAskedQuestions,
                        style: RibnToolkitTextStyles.h3.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: adaptHeight(0.01)),
                    ...faqs.keys
                        .map(
                          (q) => AccordionMobile(
                            header: Text(
                              q,
                              style: RibnToolkitTextStyles.h3.copyWith(color: Colors.white),
                            ),
                            description: Text(
                              faqs[q]!,
                              style: RibnToolkitTextStyles.h4.copyWith(color: Colors.white),
                            ),
                            width: double.infinity,
                            backgroundColor: RibnColors.primary,
                            collapsedBackgroundColor: RibnColors.primary,
                            // textColor: Colors.white,
                            iconColor: Colors.white,
                          ),
                        )
                        .toList(),
                  ],
                ),
              ),
              SizedBox(height: adaptHeight(0.01)),
              renderIfMobile(const MobileOnboardingProgressBar(currStep: 3)),
              ConfirmationButton(
                text: Strings.done,
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(Routes.home, (_) => false);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
