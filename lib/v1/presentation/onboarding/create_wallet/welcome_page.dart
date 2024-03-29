// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn_toolkit/constants/styles.dart';
import 'package:ribn_toolkit/widgets/molecules/wave_container.dart';

// Project imports:
import 'package:ribn/v1/constants/assets.dart';
import 'package:ribn/v1/constants/keys.dart';
import 'package:ribn/v1/constants/routes.dart';
import 'package:ribn/v1/constants/strings.dart';
import 'package:ribn/v1/presentation/onboarding/utils.dart';
import 'package:ribn/v1/presentation/onboarding/widgets/confirmation_button.dart';

/// The initial welcome page displayed during onboarding on mobile.
class WelcomePage extends StatelessWidget {
  static const welcomePageKey = Key('welcomePageKey');
  static const welcomePageConfirmationButtonKey = Key('welcomePageConfirmationButtonKey');
  const WelcomePage({
    Key key = welcomePageKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WaveContainer(
        containerChild: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                kIsWeb ? const SizedBox() : const Spacer(),
                Image.asset(RibnAssets.ribnLogoPng, width: 138),
                Text(
                  Strings.ribnWallet,
                  textAlign: TextAlign.center,
                  style: RibnToolkitTextStyles.h1.copyWith(
                    color: RibnColors.lightGreyTitle,
                    fontWeight: FontWeight.w700,
                    fontSize: 34,
                  ),
                ),
                const SizedBox(height: 20),
                ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: kIsWeb ? double.infinity : 310,
                  ),
                  child: Text(
                    Strings.intro,
                    textAlign: TextAlign.center,
                    style: RibnToolkitTextStyles.h3.copyWith(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
                adaptableSpacer(),
                Padding(
                  padding: EdgeInsets.only(bottom: 50),
                  child: ConfirmationButton(
                    key: welcomePageConfirmationButtonKey,
                    text: Strings.getStarted,
                    onPressed: () {
                      Keys.navigatorKey.currentState?.pushNamed(Routes.optIn);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
