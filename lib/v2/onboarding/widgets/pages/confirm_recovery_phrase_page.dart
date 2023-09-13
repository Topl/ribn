// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ribn/v2/onboarding/providers/onboarding_provider.dart';

// Project imports:
import 'package:ribn/v2/shared/constants/colors.dart';
import 'package:ribn/v2/shared/constants/ribn_text_style.dart';
import 'package:ribn/v2/shared/constants/strings.dart';
import 'package:ribn/v2/onboarding/widgets/confirmation_segemented_button.dart';

import '../../../shared/providers/stepper_navigation_control_prover.dart';

class ConfirmRecoveryPhrasePage extends HookConsumerWidget {
  const ConfirmRecoveryPhrasePage({
    Key? key,
  }) : super(key: key);

  // TODO: Should follow to CongratulationSeedPhrase when complete

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final checkItWords = ref.watch(onboardingProvider).confirmationWords;
    final isCorrectConfirmationWords = ref.watch(onboardingProvider).isCorrectConfirmationWords;
    final nextButtonNotifier = ref.watch(stepperNavigationControlProvider.notifier);

    useEffect(() {
      Future.delayed(Duration.zero, () {
        if (isCorrectConfirmationWords) {
          nextButtonNotifier.setNextButton(true);
        } else {
          nextButtonNotifier.setNextButton(false);
        }
      });
      return () {
        null;
      };
    }, [isCorrectConfirmationWords]);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(Strings.letsCheckIt, textAlign: TextAlign.left, style: RibnTextStyle.h1),
            SizedBox(height: 20),
            Text(
              Strings.letsCheckItSub,
              style: RibnTextStyle.h3.copyWith(color: RibnColors.greyText),
            ),
            SizedBox(height: 40),

            // Generate a list of ConfirmationSegmentedButton from the map of words
            ...checkItWords.entries
                .map((entry) => ConfirmationSegmentedButton(
                      words: entry.value,
                      index: entry.key,
                      onSelected: (word) {
                        ref.read(onboardingProvider.notifier).selectConfirmationWord(index: entry.key, word: word);
                      },
                      selected: ref.watch(onboardingProvider).selectedConfirmationWords[entry.key]!,
                    ))
                .toList(),

            if (!isCorrectConfirmationWords)
              Text(
                Strings.letsCheckItError,
                style: RibnTextStyle.h3.copyWith(color: RibnColors.error),
              ),
          ],
        ),
      ),
    );
  }
}
