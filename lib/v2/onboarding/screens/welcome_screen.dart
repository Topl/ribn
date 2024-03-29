// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ribn/v2/onboarding/widgets/modals/onboarding_modal.dart';
import 'package:ribn/v2/recovery/widgets/modals/restore_access.dart';
// Project imports:
import 'package:ribn/v2/shared/constants/assets.dart';
import 'package:ribn/v2/shared/constants/colors.dart';
import 'package:ribn/v2/shared/constants/ribn_text_style.dart';
import 'package:ribn/v2/shared/constants/strings.dart';
import 'package:ribn/v2/shared/extensions/screen_hook_widget.dart';
import 'package:ribn/v2/shared/extensions/widget_extensions.dart';
import 'package:ribn/v2/shared/widgets/ribn_button.dart';

class WelcomePage extends ScreenConsumerWidget {
  static const welcomePageKey = Key('welcomePageKey');
  static const welcomePageCreateButtonKey = Key('welcomePageCreateButtonKey');
  static const welcomePageImportButtonKey = Key('welcomePageImportButtonKey');

  const WelcomePage({
    Key? key,
  }) : super(key: key, route: '/welcome');

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
              },
            ),
            SizedBox(height: 10),
            Align(
              alignment: Alignment.center,
              child: TextButton(
                key: welcomePageImportButtonKey,
                onPressed: () => {
                  RestoreAccess().showAsModal(context),
                },
                child: Text(
                  Strings.importWallet,
                  style: RibnTextStyle.buttonMedium.copyWith(
                    color: RibnColors.defaultText,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
