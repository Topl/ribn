import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ribn/actions/misc_actions.dart';
import 'package:ribn_toolkit/constants/assets.dart';
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn/constants/routes.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn_toolkit/constants/styles.dart';
import 'package:ribn/models/app_state.dart';
import 'package:ribn_toolkit/widgets/atoms/large_button.dart';
import 'package:ribn_toolkit/widgets/molecules/accordion.dart';

/// Wallet created success page.
/// Displays several FAQs to the user.
class WalletCreatedPage extends StatelessWidget {
  const WalletCreatedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              width: 315,
              height: 100,
              child: Text(
                Strings.walletCreated,
                style: RibnToolkitTextStyles.h1,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 40),
            SvgPicture.asset(RibnAssets.logoCardIcon),
            const SizedBox(
              height: 95,
              width: 680,
              child: Text(
                Strings.walletCreatedDesc,
                style: RibnToolkitTextStyles.body1,
                textHeightBehavior: TextHeightBehavior(applyHeightToFirstAscent: false),
              ),
            ),
            const SizedBox(height: 30),
            LargeButton(
              buttonChild: Text(
                Strings.cont,
                style: RibnToolkitTextStyles.btnLarge.copyWith(
                  color: Colors.white,
                ),
              ),
              backgroundColor: RibnColors.primary,
              hoverColor: RibnColors.primaryButtonHover,
              dropShadowColor: RibnColors.primaryButtonShadow,
              onPressed: () => StoreProvider.of<AppState>(context).dispatch(
                NavigateToRoute(Routes.extensionInfo),
              ),
            ),
            const SizedBox(height: 60),
            SizedBox(
              width: 660,
              child: Row(
                children: [
                  Text(
                    Strings.frequentlyAskedQuestions,
                    style: RibnToolkitTextStyles.body1Bold.copyWith(fontSize: 25),
                    textAlign: TextAlign.left,
                  ),
                  const Spacer(),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Accordion(
              header: Strings.howCanIKeepMySeedPhraseSecure,
              description: Strings.howCanIKeepMySeedPhraseSecureAns,
              width: 660,
              backgroundColor: Colors.white,
              collapsedBackgroundColor: Colors.white,
              textColor: RibnColors.defaultText,
              iconColor: RibnColors.defaultText,
            ),
            const Accordion(
              header: Strings.howIsASeedPhraseDifferent,
              description: Strings.howIsASeedPhraseDifferentAns,
              width: 660,
              backgroundColor: Colors.white,
              collapsedBackgroundColor: Colors.white,
              textColor: RibnColors.defaultText,
              iconColor: RibnColors.defaultText,
            ),
            const Accordion(
              header: Strings.howIsMySeedPhraseUnrecoverable,
              description: Strings.howIsMySeedPhraseUnrecoverableAns,
              width: 660,
              backgroundColor: Colors.white,
              collapsedBackgroundColor: Colors.white,
              textColor: RibnColors.defaultText,
              iconColor: RibnColors.defaultText,
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
