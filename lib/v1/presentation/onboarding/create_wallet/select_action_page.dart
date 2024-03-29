// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn_toolkit/constants/styles.dart';
import 'package:ribn_toolkit/widgets/molecules/onboarding_action_button.dart';

// Project imports:
import 'package:ribn/v1/constants/assets.dart';
import 'package:ribn/v1/constants/keys.dart';
import 'package:ribn/v1/constants/routes.dart';
import 'package:ribn/v1/constants/strings.dart';
import 'package:ribn/v1/presentation/onboarding/utils.dart';
import 'package:ribn/v1/presentation/onboarding/widgets/onboarding_container.dart';
import 'package:ribn/v1/presentation/onboarding/widgets/web_onboarding_app_bar.dart';
import 'package:ribn/v1/utils/utils.dart';

/// This page allows the user to select between creating a new wallet or importing an existing wallet.
class SelectActionPage extends StatelessWidget {
  static const selectActionPageKey = Key('selectActionPageKey');
  static const createWalletActionButtonKey = Key('createWalletActionButtonKey');
  static const importWalletActionButtonKey = Key('importWalletActionButtonKey');
  const SelectActionPage({Key key = selectActionPageKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Widget> actionButtons = [
      Expanded(
        child: OnboardingActionButton(
          key: createWalletActionButtonKey,
          backgroundColor: RibnColors.primary,
          icon: Image.asset(RibnAssets.createWalletPng),
          title: Strings.createWallet,
          description: Strings.firstTimeWallet,
          onPressed: () {
            Keys.navigatorKey.currentState?.pushNamed(Routes.gettingStarted);
          },
        ),
      ),
      kIsWeb ? const SizedBox(width: 100, height: 50) : const SizedBox(height: 25),
      Expanded(
        child: OnboardingActionButton(
          key: importWalletActionButtonKey,
          backgroundColor: RibnColors.primary,
          icon: Image.asset(RibnAssets.importWalletPng),
          description: Strings.importWalletUsingSeedPhrase,
          title: Strings.importWallet,
          onPressed: () {
            Keys.navigatorKey.currentState?.pushNamed(Routes.restoreWallet);
          },
        ),
      )
    ];

    return Scaffold(
      body: OnboardingContainer(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              renderIfWeb(const WebOnboardingAppBar()),
              const SizedBox(
                width: kIsWeb ? double.infinity : 245,
                child: Text(
                  Strings.whatWouldYouLikeToDo,
                  textAlign: TextAlign.center,
                  style: RibnToolkitTextStyles.onboardingH1,
                ),
              ),
              SizedBox(height: adaptHeight(0.05)),
              // display actionbuttons in row or column depending on platform
              kIsWeb
                  ? Container(
                      constraints: BoxConstraints(
                        maxHeight: 263,
                        maxWidth: 800,
                      ),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: actionButtons,
                      ),
                    )
                  : Expanded(
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: actionButtons,
                      ),
                    ),
              SizedBox(height: adaptHeight(0.05)),
            ],
          ),
        ),
      ),
    );
  }
}
