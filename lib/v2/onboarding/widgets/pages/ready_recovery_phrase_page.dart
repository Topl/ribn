// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:ribn/v2/shared/constants/ribn_text_style.dart';
import 'package:ribn/v2/shared/constants/strings.dart';
import 'package:ribn/v2/shared/extensions/widget_extensions.dart';
import 'package:ribn/v2/onboarding/widgets/modals/recovery_phrase_disclaimer_modal.dart';
import 'package:ribn/v2/shared/theme.dart';
import 'package:ribn/v2/shared/widgets/ribn_button.dart';

class RecoveryPhraseInstructionsPage extends HookConsumerWidget {
  RecoveryPhraseInstructionsPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            Strings.readyRecoveryPhrase,
            textAlign: TextAlign.left,
            style: headlineLarge(context),
          ),
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
              text: Strings.next,
              onPressed: () {
                RecoveryPhraseDisclaimerModal().showAsModal(context);
              },
            ),
          )
        ],
      ),
    );
  }
}
