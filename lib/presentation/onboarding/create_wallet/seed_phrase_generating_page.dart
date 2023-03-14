// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn_toolkit/constants/styles.dart';
import 'package:ribn_toolkit/widgets/molecules/animated_circle_step_loader.dart';

// Project imports:
import 'package:ribn/constants/assets.dart';
import 'package:ribn/constants/keys.dart';
import 'package:ribn/constants/routes.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/presentation/onboarding/utils.dart';
import 'package:ribn/presentation/onboarding/widgets/confirmation_button.dart';
import 'package:ribn/presentation/onboarding/widgets/onboarding_container.dart';
import 'package:ribn/presentation/onboarding/widgets/web_onboarding_app_bar.dart';
import 'package:ribn/utils.dart';

/// This page shows a loading animation to indicate seed phrase generation.
class SeedPhraseGeneratingPage extends HookConsumerWidget {
  static const Key seedPhraseGeneratingPageKey = Key('seedPhraseGeneratingPageKey');
  static const Key seedPhraseGeneratingConfirmationButtonKey = Key('seedPhraseGeneratingConfirmationButtonKey');
  const SeedPhraseGeneratingPage({Key key = seedPhraseGeneratingPageKey}) : super(key: key);

  /// True if animated loader needs to be shown.

  final double descriptionBoxWidth = kIsWeb ? 640 : 350;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final seedPhraseGenerating = useState(true);

    return Scaffold(
      body: OnboardingContainer(
        showBackButton: seedPhraseGenerating.value ? false : true,
        child: SingleChildScrollView(
          clipBehavior: Clip.none,
          child: Center(
            child: Column(
              children: seedPhraseGenerating.value
                  ? seedPhraseGeneratingSection(() {
                      seedPhraseGenerating.value = false;
                    })
                  : seedPhraseGeneratedSection(),
            ),
          ),
        ),
      ),
    );
  }

  /// List of widgets displayed when seed phrase is being generated.
  List<Widget> seedPhraseGeneratingSection(Function showStepLoader) {
    return [
      AnimatedCircleStepLoader(
        stepLabels: const {
          0: Strings.seedPhraseGenerating,
          1: Strings.goGrabAPenAndPaper,
          2: Strings.seriouslyGetAPenAndPaper,
          3: Strings.seedPhraseGenerating,
          4: Strings.seedPhraseGenerating,
        },
        showStepLoader: () {
          showStepLoader();
        },
        activeCircleColor: RibnColors.primary,
        inactiveCircleColor: RibnColors.inactive,
        activeCircleRadius: 8,
        inactiveCircleRadius: 4.5,
        dotPadding: 8,
        renderCenterIcon: false,
      ),
      SizedBox(
        width: descriptionBoxWidth,
        child: const Text(
          Strings.aboutToShowSeedPhrase,
          style: RibnToolkitTextStyles.onboardingH3,
        ),
      ),
    ];
  }

  /// List of widgets displayed when seed phrase has been generated.
  List<Widget> seedPhraseGeneratedSection() {
    return [
      renderIfWeb(const WebOnboardingAppBar()),
      const SizedBox(
        width: kIsWeb ? double.infinity : 312,
        child: Text(
          Strings.seedPhraseGenerated,
          style: RibnToolkitTextStyles.onboardingH1,
          textAlign: TextAlign.center,
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 50.0),
        child: Image.asset(RibnAssets.walletLockPng, width: 65),
      ),
      SizedBox(
        width: descriptionBoxWidth,
        child: const Text(
          Strings.seedPhraseGeneratedDesc,
          style: RibnToolkitTextStyles.onboardingH3,
        ),
      ),
      SizedBox(height: adaptHeight(0.1)),
      ConfirmationButton(
        key: seedPhraseGeneratingConfirmationButtonKey,
        text: Strings.cont,
        onPressed: () {
          Keys.navigatorKey.currentState?.pushNamed(Routes.displaySeedphrase);
        },
      ),
    ];
  }
}
