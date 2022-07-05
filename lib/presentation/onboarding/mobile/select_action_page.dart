import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:ribn/constants/assets.dart';
import 'package:ribn/constants/routes.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/presentation/onboarding/mobile/widgets/onboarding_container.dart';
import 'package:ribn/presentation/onboarding/mobile/widgets/onboarding_page_padding.dart';
import 'package:ribn/utils.dart';
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn_toolkit/constants/styles.dart';
import 'package:ribn_toolkit/widgets/molecules/onboarding_action_button.dart';

/// This page allows the user to select between creating a new wallet or importing an existing wallet.
class SelectActionPageMobile extends StatelessWidget {
  const SelectActionPageMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Widget> actionButtons = [
      OnboardingActionButton(
        containerHeight: adaptHeight(0.25),
        backgroundColor: RibnColors.primary,
        icon: Image.asset(RibnAssets.createWalletPng),
        title: Strings.createWallet,
        description: Strings.firstTimeWallet,
        lineHeight: 4,
        onPressed: () => navigateToRoute(context, Routes.gettingStarted),
      ),
      kIsWeb ? const SizedBox(width: 100, height: 50) : const SizedBox(height: 50),
      OnboardingActionButton(
        containerHeight: adaptHeight(0.25),
        backgroundColor: RibnColors.primary,
        icon: Image.asset(RibnAssets.importWalletPng),
        description: Strings.importWalletUsingSeedPhrase,
        title: Strings.importWallet,
        onPressed: () {},
      )
    ];

    return Scaffold(
      body: OnboardingContainer(
        child: OnboardingPagePadding(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: kIsWeb ? double.infinity : 245,
                  child: Text(
                    Strings.whatWouldYouLikeToDo,
                    textAlign: TextAlign.center,
                    style: RibnToolkitTextStyles.h1.copyWith(
                      color: RibnColors.lightGreyTitle,
                      fontSize: 28,
                    ),
                  ),
                ),
                SizedBox(height: adaptHeight(0.1)),
                // display actionbuttons in row or column depending on platform
                kIsWeb
                    ? Row(mainAxisAlignment: MainAxisAlignment.center, children: actionButtons)
                    : Column(children: actionButtons)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
