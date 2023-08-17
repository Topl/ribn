// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:ribn/v2/shared/constants/colors.dart';
import 'package:ribn/v2/shared/constants/ribn_text_style.dart';
import 'package:ribn/v2/shared/constants/strings.dart';
import 'package:ribn/v2/shared/extensions/build_context_extensions.dart';
import 'package:ribn/v2/onboarding/providers/onboarding_provider.dart';
import 'package:ribn/v2/shared/providers/stepper_screen_provider.dart';
import 'package:ribn/v2/shared/widgets/ribn_button.dart';

class RecoveryPhraseDisclaimerModal extends HookConsumerWidget {
  static const imReadyModalAgreeKey = Key('imReadyModalAgreeKey');

  RecoveryPhraseDisclaimerModal({
    Key? key,
  }) : super(key: key);

  final subTextStyle = RibnTextStyle.h3.copyWith(color: RibnColors.greyText);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(onboardingProvider.notifier);
    final stepperNotifier = ref.read(stepperScreenProvider.notifier);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, mainAxisSize: MainAxisSize.max, children: [
        IconButton(
          alignment: Alignment.centerRight,
          icon: Icon(Icons.close, color: RibnColors.greyedOut),
          onPressed: () => Navigator.of(context).pop(),
        ),
        SizedBox(height: 20),
        Text(Strings.beforeYouStart,
            textAlign: TextAlign.left,
            style: RibnTextStyle.h2.copyWith(
                // color: RibnColors.lightGreyTitle,
                fontWeight: FontWeight.w700)),
        SizedBox(height: 20),
        Text(
          Strings.beforeYouStartDisclaimer,
          textAlign: TextAlign.left,
          style: subTextStyle,
        ),
        SizedBox(height: 20),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: RibnColors.somewhatPurple,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: "${Strings.beforeYouStartListHead}\n\n",
                    style: subTextStyle,
                  ),
                  TextSpan(
                    text: '• ${Strings.beforeYouStartList1}\n\n',
                    style: subTextStyle,
                  ),
                  TextSpan(
                    text: '• ${Strings.beforeYouStartList2}',
                    style: subTextStyle,
                  ),
                ],
              ),
            ),
          ),
        ),
        Spacer(),
        RibnButton(
          text: Strings.imReady,
          key: imReadyModalAgreeKey,
          onPressed: () {
            context.close();
            print("clicked");
            stepperNotifier.navigateToPage(context);
          },
        ),
      ]),
    );
  }
}
