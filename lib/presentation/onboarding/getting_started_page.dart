import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ribn/actions/misc_actions.dart';
import 'package:ribn/constants/assets.dart';
import 'package:ribn/constants/keys.dart';
import 'package:ribn/constants/routes.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn_toolkit/constants/styles.dart';
import 'package:ribn/models/app_state.dart';
import 'package:ribn/widgets/continue_button.dart';
import 'package:ribn/widgets/onboarding_app_bar.dart';

class GettingStartedPage extends StatelessWidget {
  const GettingStartedPage({Key? key}) : super(key: key);
  void onBackPressed() => Keys.navigatorKey.currentState!.pop();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const OnboardingAppBar(),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 40),
            child: Center(
              child: SizedBox(
                height: 70,
                width: 700,
                child: Center(
                  child: Text(
                    Strings.gettingStarted,
                    style: RibnToolkitTextStyles.h1,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
          SvgPicture.asset(RibnAssets.logoCardIcon),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 40.0),
            child: SizedBox(
              width: 785,
              height: 100,
              child: Text(
                Strings.gettingStartedDescription,
                style: RibnToolkitTextStyles.body1,
                textAlign: TextAlign.start,
                textHeightBehavior: TextHeightBehavior(applyHeightToFirstAscent: false),
              ),
            ),
          ),
          ContinueButton(
            Strings.ok,
            () => StoreProvider.of<AppState>(context).dispatch(NavigateToRoute(Routes.readCarefully)),
          ),
        ],
      ),
    );
  }
}
