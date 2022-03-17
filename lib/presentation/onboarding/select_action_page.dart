import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ribn/actions/misc_actions.dart';
import 'package:ribn/constants/assets.dart';
import 'package:ribn/constants/colors.dart';
import 'package:ribn/constants/keys.dart';
import 'package:ribn/constants/routes.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/constants/styles.dart';
import 'package:ribn/models/app_state.dart';
import 'package:ribn/widgets/onboarding_app_bar.dart';

/// Allow the user to select from 'create wallet' or 'import wallet'.
class SelectActionPage extends StatelessWidget {
  const SelectActionPage({Key? key}) : super(key: key);
  void onBackPressed() => Keys.navigatorKey.currentState!.pop();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          OnboardingAppBar(onBackPressed: onBackPressed),
          Padding(
            padding: const EdgeInsets.only(top: 40),
            child: Column(
              children: [
                const Text(
                  'What would you like to do?',
                  style: RibnTextStyles.h1,
                  textAlign: TextAlign.center,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 80),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildOptionContainer(Strings.createWallet,
                          Strings.createWalletDescription, context),
                      const SizedBox(width: 65),
                      _buildOptionContainer(Strings.restoreWallet,
                          Strings.restoreWalletDescription, context),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOptionContainer(
      String title, String description, BuildContext context) {
    final String iconToDisplay = title == Strings.createWallet
        ? RibnAssets.plusIcon
        : RibnAssets.importWalletIcon;
    final String navigateToRoute = title == Strings.createWallet
        ? Routes.gettingStarted
        : Routes.onboardingRestoreWalletWithMnemonic;

    return Column(
      children: [
        SizedBox(
          height: 220,
          width: 320,
          child: OutlinedButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(11),
                ),
              ),
              minimumSize: MaterialStateProperty.all(
                const Size(285, 165),
              ),
              padding: MaterialStateProperty.all<EdgeInsets>(
                const EdgeInsets.all(0),
              ),
              backgroundColor: MaterialStateProperty.all(RibnColors.primary),
            ),
            onPressed: () => StoreProvider.of<AppState>(context).dispatch(
              NavigateToRoute(navigateToRoute),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 30, right: 30),
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: const BoxDecoration(
                        color: RibnColors.accent,
                        borderRadius: BorderRadius.all(
                          Radius.circular(50),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(18),
                        child: SvgPicture.asset(
                          iconToDisplay,
                          width: 30,
                          color: RibnColors.primary,
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30, bottom: 30),
                    child: Text(title, style: RibnTextStyles.btnLarge),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 40),
        Text(
          description,
          style: RibnTextStyles.body1,
        ),
      ],
    );
  }
}
