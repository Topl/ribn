import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ribn/actions/misc_actions.dart';
import 'package:ribn/constants/assets.dart';
import 'package:ribn/constants/keys.dart';
import 'package:ribn/constants/routes.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/models/app_state.dart';
import 'package:ribn/widgets/onboarding_app_bar.dart';
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn_toolkit/constants/styles.dart';
import 'package:ribn_toolkit/widgets/atoms/square_button_with_icon.dart';

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
                  style: RibnToolkitTextStyles.h1,
                  textAlign: TextAlign.center,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 80),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildOptionContainer(Strings.createWallet, Strings.createWalletDescription, context),
                      const SizedBox(width: 65),
                      _buildOptionContainer(Strings.restoreWalletNewline, Strings.restoreWalletDescription, context),
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

  Widget _buildOptionContainer(String title, String description, BuildContext context) {
    final String iconToDisplay = title == Strings.createWallet ? RibnAssets.plusBlue : RibnAssets.importWalletIcon;
    final String navigateToRoute =
        title == Strings.createWallet ? Routes.gettingStarted : Routes.onboardingRestoreWalletWithMnemonic;

    return Column(
      children: [
        SquareButtonWithIcon(
          backgroundColor: RibnColors.primary,
          icon: Image.asset(iconToDisplay, width: 30),
          text: Text(title, style: RibnToolkitTextStyles.btnLarge),
          onPressed: () => StoreProvider.of<AppState>(context).dispatch(
            NavigateToRoute(navigateToRoute),
          ),
        ),
        const SizedBox(height: 40),
        Text(
          description,
          style: RibnToolkitTextStyles.body1,
        ),
      ],
    );
  }
}
