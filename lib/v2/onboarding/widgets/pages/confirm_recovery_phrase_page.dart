// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ribn/v2/onboarding/providers/onboarding_provider.dart';

// Project imports:
import 'package:ribn/v2/shared/constants/colors.dart';
import 'package:ribn/v2/shared/constants/ribn_text_style.dart';
import 'package:ribn/v2/shared/constants/strings.dart';
import 'package:ribn/v2/onboarding/widgets/confirmation_segemented_button.dart';

class ConfirmRecoveryPhrasePage extends HookConsumerWidget {
  const ConfirmRecoveryPhrasePage({
    Key? key,
  }) : super(key: key);

  // TODO: Should follow to CongratulationSeedPhrase when complete

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final checkItWords = ref.watch(onboardingProvider.notifier).checkItWords();
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
                    ))
                .toList(),
          ],
        ),
      ),
    );
  }
}
