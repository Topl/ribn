import 'dart:io' show Platform;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:local_auth/local_auth.dart';
import 'package:ribn/actions/user_details_actions.dart';
import 'package:ribn/constants/assets.dart';
import 'package:ribn/constants/keys.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/models/app_state.dart';
// import 'package:ribn/models/user_details_state.dart';
import 'package:ribn/presentation/onboarding/create_wallet/wallet_created_page.dart';
// import 'package:ribn/presentation/onboarding/widgets/confirmation_button.dart';
import 'package:ribn/presentation/onboarding/widgets/onboarding_container.dart';
import 'package:ribn/presentation/transfers/bottom_review_action.dart';
import 'package:ribn/utils.dart';
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn_toolkit/constants/styles.dart';
import 'package:ribn_toolkit/widgets/atoms/custom_icon_button.dart';
import 'package:ribn_toolkit/widgets/atoms/large_button.dart';
// import 'package:ribn_toolkit/constants/colors.dart';
// import 'package:ribn_toolkit/constants/styles.dart';
// import 'package:ribn_toolkit/widgets/atoms/custom_page_title.dart';

class EnableBiometrics extends StatefulWidget {
  const EnableBiometrics({Key? key}) : super(key: key);

  @override
  State<EnableBiometrics> createState() => _EnableBiometricsState();
}

class _EnableBiometricsState extends State<EnableBiometrics> {
  @override
  Widget build(BuildContext context) {
    runBiometrics(auth) async {
      final bool isBioSupported = await isBiometricsAuthenticationSupported(auth);

      if (!isBioSupported) return;

      StoreProvider.of<AppState>(context).dispatch(
        UpdateBiometricsAction(
          isBiometricsEnabled: true,
        ),
      );
    }

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
                        ?.push(MaterialPageRoute(builder: (context) => const WalletCreatedPage()));
                  },
                  icon: const Icon(
                    Icons.close,
                    color: RibnColors.lightGreyTitle,
                  ),
                ),
              ],
            ),
            Text(
              Strings.enableFaceId,
              style: RibnToolkitTextStyles.h1.copyWith(
                color: RibnColors.lightGreyTitle,
                fontSize: 28,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30.0, bottom: 45),
              child: Image.asset(Platform.isIOS ? RibnAssets.iosFaceID : RibnAssets.andriodFaceID, width: 76),
            ),
            const SizedBox(
              width: kIsWeb ? 730 : 340,
              child: Text(
                Strings.enableFaceIdDescription,
                style: RibnToolkitTextStyles.onboardingH3,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomReviewAction(
        transparentBackground: true,
        children: Column(
          children: [
            LargeButton(
              buttonHeight: 50,
              buttonWidth: double.infinity,
              buttonChild: Text(
                Strings.enableFaceId,
                style: RibnToolkitTextStyles.btnLarge.copyWith(
                  color: RibnColors.lightGreyTitle,
                ),
              ),
              onPressed: () {
                final LocalAuthentication _localAuthentication = LocalAuthentication();

                runBiometrics(_localAuthentication).then(
                  (value) => Keys.navigatorKey.currentState?.push(
                    MaterialPageRoute(
                      builder: (context) => const WalletCreatedPage(),
                    ),
                  ),
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
                Keys.navigatorKey.currentState?.push(
                  MaterialPageRoute(
                    builder: (context) => const WalletCreatedPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
