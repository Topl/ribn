// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:ribn/v2/onboarding/widgets/pages/confirm_pin_page.dart';
import 'package:ribn/v2/onboarding/widgets/pages/confirm_recovery_phrase_page.dart';
import 'package:ribn/v2/onboarding/widgets/pages/create_pin_page.dart';
import 'package:ribn/v2/onboarding/widgets/pages/ready_recovery_phrase_page.dart';
import 'package:ribn/v2/onboarding/widgets/pages/recovery_phrase_page.dart';
import 'package:ribn/v2/shared/extensions/screen_hook_widget.dart';
import 'package:ribn/v2/shared/widgets/stepper_screen.dart';
import 'package:vrouter/vrouter.dart';

class OnboardingFlowPage extends ScreenConsumerWidget {
  OnboardingFlowPage({
    Key? key,
  }) : super(key: key, route: '/onboarding');

  final _pages = [
    CreatePinPage(),
    ConfirmPinPage(),
    RecoveryPhraseInstructionsPage(),
    RecoveryPhrasePage(),
    ConfirmRecoveryPhrasePage()
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return StepperScreen(
      pages: _pages,
      onDone: () {
        print("clicked done");
        context.vRouter.to('/seed-congratulation');
      },
    );
  }
}
