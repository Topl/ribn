// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ribn/v2/onboarding/providers/onboarding_provider.dart';
// Project imports:
import 'package:ribn/v2/onboarding/widgets/pages/confirm_pin_page.dart';
import 'package:ribn/v2/onboarding/widgets/pages/confirm_recovery_phrase_page.dart';
import 'package:ribn/v2/onboarding/widgets/pages/congratulations.dart';
import 'package:ribn/v2/onboarding/widgets/pages/create_pin_page.dart';
import 'package:ribn/v2/onboarding/widgets/pages/ready_recovery_phrase_page.dart';
import 'package:ribn/v2/onboarding/widgets/pages/recovery_phrase_page.dart';
import 'package:ribn/v2/shared/extensions/screen_hook_widget.dart';
import 'package:ribn/v2/shared/providers/stepper_screen_provider.dart';
import 'package:ribn/v2/shared/widgets/custom_loading_dialog.dart';
import 'package:ribn/v2/shared/widgets/stepper_screen.dart';
import 'package:vrouter/vrouter.dart';

class OnboardingFlowPage extends ScreenConsumerWidget {
  OnboardingFlowPage({
    Key? key,
  }) : super(key: key, route: '/onboarding');

  Future<void> showCustomDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) => CustomLoadingDialog(), // Use the custom dialog widget
    );
  }

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
      onDone: () async {
        if (ref.read(onboardingProvider.notifier).verifyConfirmationWords()) {
          showCustomDialog(context);
          await Future.delayed(Duration(seconds: 3));
          context.vRouter.to(CongratulationSeedPhrase().route);
        }
      },
    );
  }
}
