// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:ribn/v2/shared/constants/colors.dart';
import 'package:ribn/v2/shared/constants/ribn_text_style.dart';
import 'package:ribn/v2/shared/constants/strings.dart';
import 'package:ribn/v2/onboarding/providers/onboarding_provider.dart';
import 'package:ribn/v2/onboarding/widgets/recovery_phrase_display_widget.dart';
import 'package:ribn/v2/shared/widgets/ribn_button.dart';

class RecoveryPhrasePage extends HookConsumerWidget {
  const RecoveryPhrasePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final onboarding = ref.watch(onboardingProvider);
    final notifier = ref.watch(onboardingProvider.notifier);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(Strings.recoveryPhrase, textAlign: TextAlign.left, style: RibnTextStyle.h1),
            SizedBox(height: 20),
            Text(
              Strings.recoveryPhraseSub,
              textAlign: TextAlign.left,
              style: RibnTextStyle.h3.copyWith(color: RibnColors.greyText),
            ),
            SizedBox(height: 10),
            RecoveryPhraseDisplayWidget(onboarding.recoveryPhrase),
            SizedBox(height: 10),
            Center(
              child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 40),
                  child: RibnButton(
                      text: Strings.setRecoveryPhraseButton,
                      onPressed: () {
                        notifier.navigate(context);
                      })),
            )
          ],
        ),
      ),
    );
  }
}
