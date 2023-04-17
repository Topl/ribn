// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:ribn/v2/core/constants/ribn_text_style.dart';
import 'package:ribn/v2/core/constants/strings.dart';
import 'package:ribn/v2/core/extensions/widget_extensions.dart';
import 'package:ribn/v2/view/onboarding/modals/recovery_phrase_disclaimer_modal.dart';
import 'package:ribn/v2/view/widgets/ribn_button.dart';

// import 'package:ribn/v2/core/providers/onboarding_provider.dart';

class RecoveryPhraseInstructionsPage extends HookConsumerWidget {
  RecoveryPhraseInstructionsPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final notifier = ref.watch(onboardingProvider.notifier);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(Strings.readyRecoveryPhrase,
              textAlign: TextAlign.left,
              style: RibnTextStyle.h2.copyWith(
                  // color: RibnColors.lightGreyTitle,
                  fontWeight: FontWeight.w700)),
          SizedBox(height: 20),
          Text(
            Strings.readyRecoveryPhraseHead,
            textAlign: TextAlign.left,
            style: RibnTextStyle.h3Grey,
          ),
          SizedBox(height: 40),
          Text(
            Strings.readyRecoveryPhraseListHead,
            textAlign: TextAlign.left,
            style: RibnTextStyle.h3Grey,
          ),
          SizedBox(height: 20),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: "•  ${Strings.readyRecoveryPhraseList1}\n\n",
                  style: RibnTextStyle.h3Grey,
                ),
                TextSpan(
                  text: '•  ${Strings.readyRecoveryPhraseList2}\n\n',
                  style: RibnTextStyle.h3Grey,
                ),
                TextSpan(
                  text: '•  ${Strings.readyRecoveryPhraseList3}\n\n',
                  style: RibnTextStyle.h3Grey,
                ),
              ],
            ),
          ),
          Spacer(),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: RibnButton(
                  text: Strings.setRecoveryPhrase,
                  onPressed: () {
                    RecoveryPhraseDisclaimerModal().showAsModal(context);
                  }))
        ],
      ),
    );
  }
}
