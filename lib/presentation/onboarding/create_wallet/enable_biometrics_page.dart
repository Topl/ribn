// Dart imports:
import 'dart:io' show Platform;

// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:app_settings/app_settings.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn_toolkit/constants/styles.dart';
import 'package:ribn_toolkit/widgets/atoms/large_button.dart';

// Project imports:
import 'package:ribn/constants/assets.dart';
import 'package:ribn/constants/keys.dart';
import 'package:ribn/constants/routes.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/presentation/onboarding/widgets/onboarding_container.dart';
import 'package:ribn/presentation/transfers/bottom_review_action.dart';
import 'package:ribn/providers/biometrics_provider.dart';

class EnableBiometrics extends HookConsumerWidget {
  static const Key enableBiometricsKey = Key('enableBiometricsKey');

  const EnableBiometrics({Key key = enableBiometricsKey}) : super(key: key);

  Future<void> runBiometrics(WidgetRef ref, BuildContext context, ValueNotifier<bool> authorized) async {
    final notifier = ref.read(biometricsProvider.notifier);

    bool authenticated = false;
    await notifier.isBiometricsAuthenticationEnrolled();

    try {
      authenticated = await notifier.authenticateWithBiometrics();
    } catch (e) {
      if (Platform.isAndroid) await _showMyDialog(context);
      return;
    }

    if (authenticated) {
      authorized.value = authenticated;
      ref.read(biometricsProvider.notifier).toggleBiometrics(overrideValue: true);
    }
  }

  Future<void> _showMyDialog(context) async {
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
  Widget build(BuildContext context, WidgetRef ref) {
    final authorized = useState(false);

    return Scaffold(
      extendBody: true,
      body: OnboardingContainer(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  height: 50,
                )
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
                Platform.isIOS ? RibnAssets.iosBiometrics : RibnAssets.andriodBiometrics,
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
                runBiometrics(ref, context, authorized).then(
                  (value) => {if (authorized.value) Keys.navigatorKey.currentState?.pushNamed(Routes.walletCreated)},
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
