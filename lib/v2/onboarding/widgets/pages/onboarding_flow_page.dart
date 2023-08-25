// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ribn/v2/onboarding/providers/onboarding_provider.dart';

// Project imports:
import 'package:ribn/v2/onboarding/widgets/pages/confirm_pin_page.dart';
import 'package:ribn/v2/onboarding/widgets/pages/confirm_recovery_phrase_page.dart';
import 'package:ribn/v2/onboarding/widgets/pages/create_pin_page.dart';
import 'package:ribn/v2/onboarding/widgets/pages/ready_recovery_phrase_page.dart';
import 'package:ribn/v2/onboarding/widgets/pages/recovery_phrase_page.dart';
import 'package:ribn/v2/shared/extensions/screen_hook_widget.dart';
import 'package:ribn/v2/shared/providers/stepper_screen_provider.dart';
import 'package:ribn/v2/shared/widgets/stepper_screen.dart';
import 'package:vrouter/vrouter.dart';

/// QQQQ move to screens widget and rename to OnboardingScreen

class OnboardingFlowPage extends ScreenConsumerWidget {
  OnboardingFlowPage({
    Key? key,
  }) : super(key: key, route: '/onboarding');

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final onboardingState = ref.watch(onboardingProvider);
    final onboardingNotifier = ref.watch(onboardingProvider.notifier);
    final stepperNotifier = ref.watch(stepperScreenProvider.notifier);
    return StepperScreen(
      pages: [
        CreatePinPage(
          pin: onboardingState.pin,
          pinController: onboardingNotifier.createPinController,
          onCompleted: (pin) {
            ref.read(onboardingProvider.notifier).setPin(pin);
            stepperNotifier.navigateToPage(context);
          },
        ),
        ConfirmPinPage(
          createPin: onboardingState.pin,
          createPinController: onboardingNotifier.createPinController,
          confirmPinController: onboardingNotifier.confirmPinController,
          onCompleted: (pin) {
            ref.read(onboardingProvider.notifier).setPin(pin);
            stepperNotifier.navigateToPage(context);
          },
        ),
        RecoveryPhraseInstructionsPage(),
        RecoveryPhrasePage(),
        ConfirmRecoveryPhrasePage()
      ],
      onDone: () {
        if (ref.read(onboardingProvider.notifier).verifyConfirmationWords()) {
          ref.read(onboardingProvider.notifier).saveWallet();
          context.vRouter.to('/seed-congratulation');
        }
        print("clicked done");
      },
    );
  }
}
