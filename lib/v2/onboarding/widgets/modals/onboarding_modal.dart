// Flutter imports:
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

// Project imports:
import 'package:ribn/v2/shared/constants/colors.dart';
import 'package:ribn/v2/shared/constants/ribn_text_style.dart';
import 'package:ribn/v2/shared/constants/strings.dart';
import 'package:ribn/v2/shared/widgets/ribn_button.dart';
import 'package:vrouter/vrouter.dart';

class OnboardingModal extends HookConsumerWidget {
  static const onboardingModalAgreeKey = Key('onboardingModalAgreeKey');
  static const onboardingModalDisagreeKey = Key('onboardingModalDisagreeKey');

  OnboardingModal({
    Key? key,
  }) : super(key: key);

  final subTextStyle = RibnTextStyle.h3.copyWith(color: RibnColors.greyText);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, mainAxisSize: MainAxisSize.max, children: [
            IconButton(
              alignment: Alignment.centerRight,
              icon: Icon(Icons.close, color: RibnColors.greyedOut),
              onPressed: () => Navigator.of(context).pop(),
            ),
            Text(Strings.helpUsImprove,
                textAlign: TextAlign.left,
                style: RibnTextStyle.h2.copyWith(
                    // color: RibnColors.lightGreyTitle,
                    fontWeight: FontWeight.w700)),
            SizedBox(height: 20),
            Text(
              Strings.dataDisclaimerHeader,
              textAlign: TextAlign.left,
              style: subTextStyle,
            ),
            SizedBox(height: 20),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: "${Strings.dataDisclaimerHeader}\n\n",
                    style: subTextStyle,
                  ),
                  TextSpan(
                    text: '• ${Strings.dataDisclaimerList1}\n\n',
                    style: subTextStyle,
                  ),
                  TextSpan(
                    text: '• ${Strings.dataDisclaimerList2}\n\n',
                    style: subTextStyle,
                  ),
                  TextSpan(
                    text: '• ${Strings.dataDisclaimerList3}\n\n',
                    style: subTextStyle,
                  ),
                  TextSpan(
                    text: '${Strings.dataDisclaimerFooter}',
                    style: subTextStyle,
                  ),
                  TextSpan(
                    text: Strings.dataDisclaimerFooterPrivacyPolicyText,
                    style: TextStyle(
                      fontSize: 16,
                      color: RibnColors.primary,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        launchUrl(
                            Uri(path: 'https://www.example.com/privacy-policy')); //TODO Add correct PRIVACY URL HERE
                      },
                  ),
                ],
              ),
            ),
            SizedBox(height: 80),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                      key: onboardingModalDisagreeKey,
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text(Strings.noThanks,
                          style: RibnTextStyle.buttonLarge.copyWith(
                            color: RibnColors.defaultText,
                            fontWeight: FontWeight.w400,
                          ))),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: RibnButton(
                    text: Strings.iAgree,
                    key: onboardingModalAgreeKey,
                    onPressed: () {
                      //TODO: Add Navigation
                         context.vRouter.to('/onboarding_flow');
                    },
                  ),
                ),
              ],
            ),
          ]),
        ),
      ],
    );
  }
}
