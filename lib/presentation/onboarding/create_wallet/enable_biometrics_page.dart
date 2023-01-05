import 'dart:io' show Platform;

import 'package:app_settings/app_settings.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:local_auth/local_auth.dart';
import 'package:ribn/actions/user_details_actions.dart';
import 'package:ribn/constants/assets.dart';
import 'package:ribn/constants/keys.dart';
import 'package:ribn/constants/routes.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/models/app_state.dart';
import 'package:ribn/presentation/onboarding/widgets/onboarding_container.dart';
import 'package:ribn/presentation/transfers/bottom_review_action.dart';
import 'package:ribn/utils.dart';
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn_toolkit/constants/styles.dart';
import 'package:ribn_toolkit/widgets/atoms/custom_icon_button.dart';
import 'package:ribn_toolkit/widgets/atoms/large_button.dart';

class EnableBiometrics extends StatefulWidget {
  const EnableBiometrics({Key? key}) : super(key: key);

  @override
  State<EnableBiometrics> createState() => _EnableBiometricsState();
}

class _EnableBiometricsState extends State<EnableBiometrics> {
  final LocalAuthentication _localAuthentication = LocalAuthentication();
  bool _authorized = false;

  Future<void> runBiometrics(auth) async {
    bool authenticated = false;
    await isBiometricsAuthenticationEnrolled(auth);

    try {
      authenticated = await authenticateWithBiometrics(auth);
    } catch (e) {
      if (Platform.isAndroid) await _showMyDialog();
      return;
    }

    if (!mounted || !authenticated) {
      return;
    }

    setState(() {
      _authorized = authenticated ? true : false;
    });

    StoreProvider.of<AppState>(context).dispatch(
      UpdateBiometricsAction(
        isBiometricsEnabled: true,
      ),
    );
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text(
                  'Biometrics authentication is not set up on your device. Please enable biometrics in your device settings.',
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            const TextButton(
              onPressed: AppSettings.openSecuritySettings,
              child: Text('Go to settings'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: OnboardingContainer(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CustomIconButton(
                  onPressed: () {
                    Keys.navigatorKey.currentState
                        ?.pushNamed(Routes.walletCreated);
                  },
                  icon: const Icon(
                    Icons.close,
                    color: RibnColors.lightGreyTitle,
                  ),
                ),
              ],
            ),
            Text(
              Strings.enableBiometrics,
              style: RibnToolkitTextStyles.h1.copyWith(
                color: RibnColors.lightGreyTitle,
                fontSize: 28,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30.0, bottom: 45),
              child: Image.asset(
                Platform.isIOS
                    ? RibnAssets.iosBiometrics
                    : RibnAssets.andriodBiometrics,
                width: 111,
              ),
            ),
            const SizedBox(
              width: kIsWeb ? 730 : 340,
              child: Text(
                Strings.enableBiometricsDescription,
                style: RibnToolkitTextStyles.onboardingH3,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomReviewAction(
        maxHeight: 174,
        transparentBackground: true,
        children: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            LargeButton(
              buttonHeight: 50,
              buttonWidth: double.infinity,
              buttonChild: Text(
                Strings.enableBiometrics,
                style: RibnToolkitTextStyles.btnLarge.copyWith(
                  color: RibnColors.lightGreyTitle,
                ),
              ),
              onPressed: () {
                runBiometrics(_localAuthentication).then(
                  (value) => {
                    if (_authorized)
                      Keys.navigatorKey.currentState
                          ?.pushNamed(Routes.walletCreated)
                  },
                );
              },
              backgroundColor: RibnColors.primary,
              dropShadowColor: RibnColors.whiteButtonShadow,
            ),
            const SizedBox(
              height: 15,
            ),
            LargeButton(
              buttonWidth: double.infinity,
              buttonHeight: 50,
              buttonChild: Text(
                Strings.skipForNow,
                style: RibnToolkitTextStyles.btnLarge.copyWith(
                  color: RibnColors.lightGreyTitle,
                ),
              ),
              backgroundColor: Colors.transparent,
              hoverColor: Colors.transparent,
              dropShadowColor: Colors.transparent,
              borderColor: RibnColors.lightGreyTitle,
              onPressed: () {
                Keys.navigatorKey.currentState?.pushNamed(Routes.walletCreated);
              },
            ),
          ],
        ),
      ),
    );
  }
}
