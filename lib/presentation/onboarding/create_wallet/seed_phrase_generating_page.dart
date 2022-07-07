import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ribn/actions/onboarding_actions.dart';
import 'package:ribn/constants/assets.dart';
import 'package:ribn/constants/routes.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/models/app_state.dart';
import 'package:ribn/presentation/onboarding/utils.dart';
import 'package:ribn/presentation/onboarding/widgets/confirmation_button.dart';
import 'package:ribn/presentation/onboarding/widgets/onboarding_container.dart';
import 'package:ribn/presentation/onboarding/widgets/web_onboarding_app_bar.dart';
import 'package:ribn/utils.dart';
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn_toolkit/constants/styles.dart';

/// This page shows a loading animation to indicate seed phrase generation.
class SeedPhraseGeneratingPage extends StatefulWidget {
  const SeedPhraseGeneratingPage({Key? key}) : super(key: key);

  @override
  _SeedPhraseGeneratingPageState createState() => _SeedPhraseGeneratingPageState();
}

class _SeedPhraseGeneratingPageState extends State<SeedPhraseGeneratingPage> {
  /// Timer for the animation, initialized in [initState].
  late final Timer timer;

  /// Duration for animating circles.
  final Duration duration = const Duration(seconds: 2);

  /// Number of circles in the loading animation.
  final int numCircles = 5;

  /// True if animated loader needs to be shown.
  bool seedPhraseGenerating = true;

  /// Current active circle position.
  int currCircle = 0;

  final List<int> circlePositions = List.generate(5, (idx) => idx).toList();
  final double smallRadius = 4.5;
  final double bigRadius = 8;

  final double descriptionBoxWidth = kIsWeb ? 640 : 350;

  @override
  void initState() {
    timer = Timer.periodic(duration, (timer) {
      if (timer.tick == numCircles) {
        seedPhraseGenerating = false;
        timer.cancel();
      }
      currCircle = (currCircle + 1) % numCircles;
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      onInit: (store) => store.dispatch(GenerateMnemonicAction()),
      builder: (context, vm) {
        return Scaffold(
          body: OnboardingContainer(
            child: Center(
              child: Column(
                children: seedPhraseGenerating ? seedPhraseGeneratingSection() : seedPhraseGeneratedSection(),
              ),
            ),
          ),
        );
      },
    );
  }

  /// List of widgets displayed when seed phrase is being generated.
  List<Widget> seedPhraseGeneratingSection() {
    return [
      SizedBox(
        width: kIsWeb ? double.infinity : 312,
        child: _buildTitle(currCircle),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 50.0, bottom: 70),
        child: SizedBox(
          height: 30,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: circlePositions.map(_buildAnimatedContainer).toList(),
          ),
        ),
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
      adaptableSpacer(),
      ConfirmationButton(
        text: Strings.cont,
        onPressed: () => navigateToRoute(
          context,
          Routes.displaySeedphrase,
        ),
      ),
    ];
  }

  /// Builds title based on active circle [position].
  Widget _buildTitle(int position) {
    switch (position) {
      case 0:
      case 3:
      case 4:
        {
          return const Text(
            Strings.seedPhraseGenerating,
            style: RibnToolkitTextStyles.onboardingH1,
            textAlign: TextAlign.center,
          );
        }
      case 1:
        {
          return const Text(
            Strings.goGrabAPenAndPaper,
            style: RibnToolkitTextStyles.onboardingH1,
            textAlign: TextAlign.center,
          );
        }
      case 2:
        {
          return const Text(
            Strings.seriouslyGetAPenAndPaper,
            style: RibnToolkitTextStyles.onboardingH1,
            textAlign: TextAlign.center,
          );
        }
    }
    return const Text('');
  }

  /// Animate color and radius of the active circles.
  Widget _buildAnimatedContainer(int position) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: AnimatedContainer(
        duration: duration,
        child: CircleAvatar(
          backgroundColor: position <= currCircle ? RibnColors.primary : RibnColors.inactive,
          radius: currCircle == position ? bigRadius : smallRadius,
        ),
      ),
    );
  }
}
