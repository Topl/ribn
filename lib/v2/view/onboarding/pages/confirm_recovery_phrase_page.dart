// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:ribn/v2/core/constants/colors.dart';
import 'package:ribn/v2/core/constants/ribn_text_style.dart';
import 'package:ribn/v2/core/constants/strings.dart';
import 'package:ribn/v2/view/onboarding/widgets/confirmation_segemented_button.dart';

class ConfirmRecoveryPhrasePage extends HookConsumerWidget {
  const ConfirmRecoveryPhrasePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
            ConfirmationSegmentedButton(
              selected: "Paint",
              words: ["Sea", "Ultra", "Paint"],
              index: 11,
            ),
            ConfirmationSegmentedButton(
              selected: "Charge",
              words: ["Charge", "Pacific", "Sky"],
              index: 2,
            ),
            ConfirmationSegmentedButton(
              selected: "Level",
              words: ["Traveling", "Level", "Display"],
              index: 0,
            ),
            ConfirmationSegmentedButton(
              selected: "Easy",
              words: ["Fall", "Ultra", "Easy"],
              index: 7,
            )
          ],
        ),
      ),
    );
  }
}
