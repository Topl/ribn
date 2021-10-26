import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ribn/actions/misc_actions.dart';
import 'package:ribn/constants/assets.dart';

import 'package:ribn/constants/routes.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/constants/styles.dart';
import 'package:ribn/models/app_state.dart';
import 'package:ribn/widgets/continue_button.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              Strings.welcomeToRibn,
              style: RibnTextStyles.h1,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 42),
            SvgPicture.asset(
              RibnAssets.logoIcon,
              height: 128,
              width: 132,
            ),
            const SizedBox(height: 23),
            const SizedBox(
              width: 650,
              height: 85,
              child: Center(
                child: Text(
                  Strings.intro,
                  style: RibnTextStyles.body1,
                  textAlign: TextAlign.center,
                  textHeightBehavior: TextHeightBehavior(applyHeightToFirstAscent: false),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ContinueButton(
              Strings.getStarted,
              () => StoreProvider.of<AppState>(context).dispatch(NavigateToRoute(Routes.selectAction)),
            ),
          ],
        ),
      ),
    );
  }
}
