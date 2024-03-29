// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn_toolkit/constants/styles.dart';
import 'package:ribn_toolkit/widgets/molecules/accordion.dart';

// Project imports:
import 'package:ribn/v1/constants/assets.dart';
import 'package:ribn/v1/constants/keys.dart';
import 'package:ribn/v1/constants/routes.dart';
import 'package:ribn/v1/constants/strings.dart';
import 'package:ribn/v1/presentation/onboarding/utils.dart';
import 'package:ribn/v1/presentation/onboarding/widgets/confirmation_button.dart';
import 'package:ribn/v1/presentation/onboarding/widgets/mobile_onboarding_progress_bar.dart';
import 'package:ribn/v1/presentation/onboarding/widgets/onboarding_container.dart';
import 'package:ribn/v1/presentation/onboarding/widgets/web_onboarding_app_bar.dart';
import 'package:ribn/v1/utils/navigation_utils.dart';
import 'package:ribn/v1/utils/utils.dart';

/// This page is displayed when user successfully creates their wallet.
class WalletCreatedPage extends HookWidget {
  static const Key walletCreatedPageKey = Key('walletCreatedPageKey');
  static const Key walletCreatedConfirmationButtonKey = Key('walletCreatedConfirmationButtonKey');
  const WalletCreatedPage({Key key = walletCreatedPageKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// FAQs and their corresponding answeres
    final ValueNotifier<Map<String, String>> faqs = useState({
      Strings.howCanIKeepMySeedPhraseSecure: Strings.howCanIKeepMySeedPhraseSecureAns,
      Strings.howIsASeedPhraseDifferent: Strings.howIsASeedPhraseDifferentAns,
      Strings.howIsMySeedPhraseUnrecoverable: Strings.howIsMySeedPhraseUnrecoverableAns,
    });
    return Scaffold(
      body: OnboardingContainer(
        child: SingleChildScrollView(
          clipBehavior: Clip.none,
          child: Column(
            children: [
              renderIfWeb(const WebOnboardingAppBar(currStep: 3)),
              const Text(
                Strings.walletCreated,
                style: RibnToolkitTextStyles.onboardingH1,
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        Strings.walletCreatedDesc,
                        style: RibnToolkitTextStyles.onboardingH3,
                      ),
                    ),
                    SizedBox(height: adaptHeight(0.05)),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        Strings.frequentlyAskedQuestions,
                        style: RibnToolkitTextStyles.h3.copyWith(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: adaptHeight(0.01)),
                    ...faqs.value.keys
                        .map(
                          (q) => Accordion(
                            header: Text(
                              q,
                              style: RibnToolkitTextStyles.h3.copyWith(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                            description: Text(
                              faqs.value[q]!,
                              style: RibnToolkitTextStyles.h4.copyWith(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
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
                key: walletCreatedConfirmationButtonKey,
                text: Strings.done,
                onPressed: () {
                  if (kIsWeb) {
                    navigateToRoute(route: Routes.extensionInfo);
                  } else {
                    Keys.navigatorKey.currentState?.pushNamedAndRemoveUntil(Routes.home, (_) => false);
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
