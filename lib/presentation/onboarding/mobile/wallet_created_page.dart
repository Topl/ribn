import 'package:flutter/material.dart';
import 'package:ribn/constants/assets.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/presentation/onboarding/mobile/helpers.dart';
import 'package:ribn/presentation/onboarding/mobile/widgets/accordion2.dart';
import 'package:ribn/presentation/onboarding/mobile/widgets/confirmation_button.dart';
import 'package:ribn/presentation/onboarding/mobile/widgets/onboarding_container.dart';
import 'package:ribn/presentation/onboarding/mobile/widgets/onboarding_page_padding.dart';
import 'package:ribn/utils.dart';
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn_toolkit/constants/styles.dart';

/// This page is displayed when user successfully creates their wallet.
class WalletCreatedPageMobile extends StatefulWidget {
  const WalletCreatedPageMobile({Key? key}) : super(key: key);

  @override
  State<WalletCreatedPageMobile> createState() => _WalletCreatedPageMobileState();
}

class _WalletCreatedPageMobileState extends State<WalletCreatedPageMobile> {
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
        child: OnboardingPagePadding(
          child: SingleChildScrollView(
            clipBehavior: Clip.none,
            child: Column(
              children: [
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
                Text(
                  Strings.walletCreatedDesc,
                  style: onboardingH3,
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
                        width: 350,
                        backgroundColor: RibnColors.primary,
                        collapsedBackgroundColor: RibnColors.primary,
                        // textColor: Colors.white,
                        iconColor: Colors.white,
                      ),
                    )
                    .toList(),
                SizedBox(height: adaptHeight(0.01)),
                ConfirmationButton(
                  text: Strings.done,
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
