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

/// The initial welcome page displayed during onboarding.
class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);
  final SizedBox padding = const SizedBox(height: 40);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                Strings.welcomeToRibn,
                style: RibnTextStyles.h1,
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
                    style: RibnTextStyles.body1,
                    textAlign: TextAlign.center,
                    textHeightBehavior: TextHeightBehavior(applyHeightToFirstAscent: false),
                  ),
                ),
              ),
              padding,
              ContinueButton(
                Strings.getStarted,
                () => StoreProvider.of<AppState>(context).dispatch(NavigateToRoute(Routes.selectAction)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
