// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:ribn/v2/core/constants/assets.dart';
import 'package:ribn/v2/core/constants/colors.dart';
import 'package:ribn/v2/core/constants/ribn_text_style.dart';
import 'package:ribn/v2/core/constants/strings.dart';
import 'package:ribn/v2/core/extensions/widget_extensions.dart';
import 'package:ribn/v2/view/onboarding/modals/onboarding_modal.dart';
import 'package:ribn/v2/view/widgets/ribn_button.dart';

class WelcomePage extends HookConsumerWidget {
  static const welcomePageKey = Key('welcomePageKey');
  static const welcomePageCreateButtonKey = Key('welcomePageCreateButtonKey');
  static const welcomePageImportButtonKey = Key('welcomePageImportButtonKey');

  const WelcomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            Image.asset(Assets.ribnLogoIcon, height: 120),
            Spacer(),
            Text(Strings.welcomeToRibn, textAlign: TextAlign.left, style: RibnTextStyle.h1),
            SizedBox(height: 20),
            Text(
              Strings.welcomeToRibnSubheader,
              textAlign: TextAlign.left,
              style: RibnTextStyle.h3Grey,
            ),
            SizedBox(height: 30),
            RibnButton(
              key: welcomePageCreateButtonKey,
              text: Strings.createWallet,
              onPressed: () {
                OnboardingModal().showAsModal(context);
                // Keys.navigatorKey.currentState?.pushNamed(Routes.optIn);
              },
            ),
            Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                    key: welcomePageImportButtonKey,
                    onPressed: () => {},
                    child: Text("Import Wallet",
                        style: RibnTextStyle.buttonMedium.copyWith(
                          color: RibnColors.defaultText,
                          fontWeight: FontWeight.w500,
                        )))),
          ],
        ),
      ),
    );
  }
}
