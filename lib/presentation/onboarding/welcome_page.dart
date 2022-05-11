import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ribn/actions/misc_actions.dart';
import 'package:ribn_toolkit/constants/assets.dart';

import 'package:ribn/constants/routes.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn_toolkit/constants/styles.dart';
import 'package:ribn/models/app_state.dart';
import 'package:ribn_toolkit/widgets/atoms/large_button.dart';

/// The initial welcome page displayed during onboarding.
class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);
  final SizedBox padding = const SizedBox(height: 40);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              Strings.welcomeToRibn,
              style: RibnToolkitTextStyles.h1,
              textAlign: TextAlign.center,
            ),
            padding,
            SvgPicture.asset(RibnAssets.logoIcon),
            padding,
            const SizedBox(
              width: 640,
              height: 50,
              child: Center(
                child: Text(
                  Strings.intro,
                  style: RibnToolkitTextStyles.body1,
                  textAlign: TextAlign.center,
                  textHeightBehavior: TextHeightBehavior(applyHeightToFirstAscent: false),
                ),
              ),
            ),
            padding,
            LargeButton(
              buttonChild: Text(
                Strings.getStarted,
                style: RibnToolkitTextStyles.btnLarge.copyWith(
                  color: Colors.white,
                ),
              ),
              backgroundColor: RibnColors.primary,
              hoverColor: RibnColors.primaryButtonHover,
              dropShadowColor: RibnColors.primaryButtonShadow,
              onPressed: () => StoreProvider.of<AppState>(context).dispatch(NavigateToRoute(Routes.selectAction)),
            ),
          ],
        ),
      ),
    );
  }
}
