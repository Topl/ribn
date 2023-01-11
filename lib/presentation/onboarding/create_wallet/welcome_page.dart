import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ribn/constants/assets.dart';
import 'package:ribn/constants/keys.dart';
import 'package:ribn/constants/routes.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/presentation/onboarding/utils.dart';
import 'package:ribn/presentation/onboarding/widgets/confirmation_button.dart';
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn_toolkit/constants/styles.dart';
import 'package:ribn_toolkit/widgets/molecules/wave_container.dart';

/// The initial welcome page displayed during onboarding on mobile.
class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

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
                      maxWidth: kIsWeb ? double.infinity : 310),
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
                ConfirmationButton(
                  text: Strings.getStarted,
                  onPressed: () {
                    Keys.navigatorKey.currentState
                        ?.pushNamed(Routes.selectAction);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
