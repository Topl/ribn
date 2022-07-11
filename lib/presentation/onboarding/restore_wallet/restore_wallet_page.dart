import 'package:bip_topl/bip_topl.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ribn/actions/misc_actions.dart';
import 'package:ribn/constants/routes.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/models/app_state.dart';
import 'package:ribn/presentation/onboarding/utils.dart';
import 'package:ribn/presentation/onboarding/widgets/confirmation_button.dart';
import 'package:ribn/presentation/onboarding/widgets/onboarding_container.dart';
import 'package:ribn/presentation/onboarding/widgets/web_onboarding_app_bar.dart';
import 'package:ribn/utils.dart';
import 'package:ribn_toolkit/constants/styles.dart';
import 'package:ribn_toolkit/widgets/atoms/custom_text_field.dart';
import 'package:ribn_toolkit/widgets/atoms/large_button.dart';
import 'package:ribn_toolkit/widgets/atoms/peekaboo_button.dart';
import 'package:ribn_toolkit/widgets/molecules/onboarding_progress_bar.dart';

/// This page allows the user to enter a known mnemonic / seed phrase in order to restore a wallet.
///
/// This page is used in the 'restore wallet' flow when initiated from the login page,
/// hence the widget name is prefixed with 'Login'.
class RestoreWalletPage extends StatefulWidget {
  const RestoreWalletPage({Key? key}) : super(key: key);

  @override
  _RestoreWalletPageState createState() => _RestoreWalletPageState();
}

class _RestoreWalletPageState extends State<RestoreWalletPage> {
  final double maxWidth = 309;

  /// Controller for the seed phrase text field.
  final TextEditingController controller = TextEditingController();

  /// Seed phrase entered by the user.
  String seedPhrase = '';

  /// True if an invalid seed phrase is entered.
  bool invalidSeedPhraseEntered = false;

  @override
  void initState() {
    controller.addListener(() {
      setState(() {
        seedPhrase = controller.text;
        invalidSeedPhraseEntered = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: OnboardingContainer(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            renderIfWeb(const WebOnboardingAppBar(currStep: 0, numSteps: 2)),
            const Text(
              Strings.restoreWallet,
              style: RibnToolkitTextStyles.onboardingH1,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              width: 700,
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  const Text(
                    Strings.restoreWalletSeedPhraseDesc,
                    style: RibnToolkitTextStyles.onboardingH3,
                  ),
                  const SizedBox(height: 30),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      Strings.enterSeedPhrase,
                      style: RibnToolkitTextStyles.extH3.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  // seed phrase text field
                  Align(
                    alignment: Alignment.centerLeft,
                    child: CustomTextField(
                      width: 500,
                      height: 70,
                      controller: controller,
                      hintText: Strings.hintSeedPhrase,
                      hasError: invalidSeedPhraseEntered,
                    ),
                  ),
                  kIsWeb ? Align(alignment: Alignment.centerLeft, child: _buildAdvancedOption()) : const SizedBox(),
                ],
              ),
            ),
            adaptableSpacer(),
            renderIfMobile(const OnboardingProgressBar(numSteps: 2, currStep: 0)),
            const SizedBox(height: 20),
            ConfirmationButton(
              text: Strings.next,
              onPressed: onNextPressed,
            ),
          ],
        ),
      ),
    );
  }

  /// Handler for when [LargeButton] is pressed.
  ///
  /// Validates the seedphrase entered and if valid, navigates to the next page, i.e. [Routes.restoreWalletNewPassword].
  void onNextPressed() {
    final bool isSeedPhraseValid = validateMnemonic(seedPhrase, 'english');
    if (isSeedPhraseValid) {
      StoreProvider.of<AppState>(context).dispatch(
        NavigateToRoute(
          Routes.restoreWalletNewPassword,
          arguments: seedPhrase,
        ),
      );
    } else {
      setState(() {
        invalidSeedPhraseEntered = true;
      });
    }
  }

  Widget _buildAdvancedOption() {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0),
      child: SizedBox(
        width: maxWidth,
        child: PeekabooButton(
          buttonText: Text(
            Strings.advancedOption,
            style: RibnToolkitTextStyles.smallBody.copyWith(fontSize: 15),
          ),
          buttonChild: SizedBox(
            width: 137,
            height: 22,
            child: LargeButton(
              buttonChild: Text(
                Strings.useToplMainKey,
                style: RibnToolkitTextStyles.onboardingH3.copyWith(fontSize: 11),
              ),
              onPressed: () => navigateToRoute(context, Routes.restoreWithToplKey),
            ),
          ),
        ),
      ),
    );
  }
}
