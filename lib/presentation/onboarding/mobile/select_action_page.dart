import 'package:flutter/material.dart';

import 'package:ribn/constants/assets.dart';
import 'package:ribn/constants/routes.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/presentation/onboarding/mobile/widgets/onboarding_container.dart';
import 'package:ribn/presentation/onboarding/mobile/widgets/onboarding_page_padding.dart';
import 'package:ribn/presentation/onboarding/mobile/widgets/square_button.dart';
import 'package:ribn/utils.dart';
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn_toolkit/constants/styles.dart';

/// This page allows the user to select between creating a new wallet or importing an existing wallet.
class SelectActionPageMobile extends StatelessWidget {
  const SelectActionPageMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OnboardingContainer(
        child: OnboardingPagePadding(
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  width: 245,
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
                SquareButtonWithIcon(
                  containerHeight: adaptHeight(0.25),
                  backgroundColor: RibnColors.primary,
                  icon: Image.asset(RibnAssets.createWalletPng),
                  title: Strings.createWallet,
                  description: Strings.firstTimeWallet,
                  lineHeight: 4,
                  onPressed: () => navigateToRoute(context, Routes.gettingStarted),
                ),
                const SizedBox(height: 40),
                SquareButtonWithIcon(
                  containerHeight: adaptHeight(0.25),
                  backgroundColor: RibnColors.primary,
                  icon: Image.asset(RibnAssets.importWalletPng),
                  description: Strings.importWalletUsingSeedPhrase,
                  title: Strings.importWallet,
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
