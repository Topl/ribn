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
      appBar: OnboardingAppBar(onBackPressed: onBackPressed),
      body: Padding(
        padding: const EdgeInsets.only(top: 40),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildOptionContainer(Strings.createWallet, Strings.createWalletDescription, context),
            const SizedBox(width: 65),
            _buildOptionContainer(Strings.importWallet, Strings.importWalletDescription, context),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionContainer(String title, String description, BuildContext context) {
    final String iconToDisplay = title == Strings.createWallet ? RibnAssets.plusIcon : RibnAssets.importWalletIcon;
    return Container(
      height: 455,
      width: 385,
      decoration: BoxDecoration(
        color: RibnColors.accent,
        borderRadius: BorderRadius.circular(11),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(50, 54, 50, 40),
            child: OutlinedButton(
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(const Size(285, 165)),
                backgroundColor: MaterialStateProperty.all(RibnColors.primary),
              ),
              onPressed: () => StoreProvider.of<AppState>(context).dispatch(NavigateToRoute(Routes.gettingStarted)),
              child: SvgPicture.asset(iconToDisplay),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 50, bottom: 10),
            child: Text(
              title,
              style: RibnTextStyles.h2,
              textAlign: TextAlign.start,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 50.0),
            child: SizedBox(
              width: 285,
              height: 80,
              child: Text(
                description,
                style: RibnTextStyles.body1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
