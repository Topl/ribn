import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ribn/constants/assets.dart';
import 'package:ribn/constants/keys.dart';
import 'package:ribn/constants/routes.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/presentation/onboarding/utils.dart';
import 'package:ribn/presentation/onboarding/widgets/confirmation_button.dart';
import 'package:ribn/presentation/onboarding/widgets/mobile_onboarding_progress_bar.dart';
import 'package:ribn/presentation/onboarding/widgets/onboarding_container.dart';
import 'package:ribn/presentation/onboarding/widgets/web_onboarding_app_bar.dart';
import 'package:ribn/utils.dart';
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn_toolkit/widgets/atoms/text/ribn_font18_text_widget.dart';
import 'package:ribn_toolkit/widgets/atoms/text/ribn_onboarding_h1_text_widget.dart';
import 'package:ribn_toolkit/widgets/atoms/text/ribn_onboarding_h3_text_widget.dart';
import 'package:ribn_toolkit/widgets/molecules/accordion.dart';

/// This page is displayed when user successfully creates their wallet.
class WalletCreatedPage extends StatefulWidget {
  const WalletCreatedPage({Key? key}) : super(key: key);

  @override
  State<WalletCreatedPage> createState() => _WalletCreatedPageState();
}

class _WalletCreatedPageState extends State<WalletCreatedPage> {
  /// FAQs and their corresponding answeres
  final Map<String, String> faqs = {
    Strings.howCanIKeepMySeedPhraseSecure:
        Strings.howCanIKeepMySeedPhraseSecureAns,
    Strings.howIsASeedPhraseDifferent: Strings.howIsASeedPhraseDifferentAns,
    Strings.howIsMySeedPhraseUnrecoverable:
        Strings.howIsMySeedPhraseUnrecoverableAns,
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
              const RibnOnboardingH1TextWidget(
                text: Strings.walletCreated,
                textColor: RibnColors.lightGreyTitle,
                textAlignment: TextAlign.center,
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: RibnOnboardingH3TextWidget(
                        text: Strings.walletCreatedDesc,
                        textColor: RibnColors.lightGreyTitle,
                        textAlignment: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: adaptHeight(0.05)),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: RibnFont18TextWidget(
                          text: Strings.frequentlyAskedQuestions,
                          textAlignment: TextAlign.justify,
                          textColor: RibnColors.white,
                          fontWeight: FontWeight.w500,),
                    ),
                    SizedBox(height: adaptHeight(0.01)),
                    ...faqs.keys
                        .map(
                          (q) => Accordion(
                            header: RibnFont18TextWidget(
                                text: q,
                                textAlignment: TextAlign.justify,
                                textColor: RibnColors.white,
                                fontWeight: FontWeight.w500,),
                            description: RibnFont18TextWidget(
                                text: faqs[q]!,
                                textAlignment: TextAlign.justify,
                                textColor: RibnColors.white,
                                fontWeight: FontWeight.w500,),
                            width: 648,
                            backgroundColor: RibnColors.primary,
                            collapsedBackgroundColor: RibnColors.primary,
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
                  if (kIsWeb) {
                    navigateToRoute(context, Routes.extensionInfo);
                  } else {
                    Keys.navigatorKey.currentState
                        ?.pushNamedAndRemoveUntil(Routes.home, (_) => false);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
