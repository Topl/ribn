import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ribn/actions/misc_actions.dart';
import 'package:ribn/constants/assets.dart';
import 'package:ribn/constants/keys.dart';
import 'package:ribn/constants/routes.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/constants/styles.dart';
import 'package:ribn/models/app_state.dart';
import 'package:ribn/widgets/continue_button.dart';
import 'package:ribn/widgets/onboarding_app_bar.dart';

class GettingStartedPage extends StatelessWidget {
  const GettingStartedPage({Key? key}) : super(key: key);
  void onBackPressed() => Keys.navigatorKey.currentState!.pop();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: OnboardingAppBar(onBackPressed: onBackPressed),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 40.0, bottom: 40),
            child: Center(
              child: SizedBox(
                height: 67,
                width: 702,
                child: Center(
                  child: Text(
                    Strings.gettingStarted,
                    style: RibnTextStyles.h1,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
          SvgPicture.asset(RibnAssets.logoCardIcon),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 40.0),
            child: SizedBox(
              width: 704,
              height: 92,
              child: Text(
                Strings.gettingStartedDescription,
                style: RibnTextStyles.body1.copyWith(height: 2.36),
                textAlign: TextAlign.start,
                textHeightBehavior: const TextHeightBehavior(applyHeightToFirstAscent: false),
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
