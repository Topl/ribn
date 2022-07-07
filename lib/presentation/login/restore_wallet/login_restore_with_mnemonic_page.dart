import 'package:bip_topl/bip_topl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ribn/actions/misc_actions.dart';
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn/constants/routes.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn_toolkit/constants/styles.dart';
import 'package:ribn/models/app_state.dart';
import 'package:ribn_toolkit/widgets/atoms/custom_page_title.dart';
import 'package:ribn_toolkit/widgets/atoms/custom_text_field.dart';
import 'package:ribn_toolkit/widgets/atoms/large_button.dart';
import 'package:ribn_toolkit/widgets/molecules/onboarding_progress_bar.dart';

/// This page allows the user to enter a known mnemonic / seed phrase in order to restore a wallet.
///
/// This page is used in the 'restore wallet' flow when initiated from the login page,
/// hence the widget name is prefixed with 'Login'.
class LoginRestoreWithMnemonicPage extends StatefulWidget {
  const LoginRestoreWithMnemonicPage({Key? key}) : super(key: key);

  @override
  _LoginRestoreWithMnemonicPageState createState() => _LoginRestoreWithMnemonicPageState();
}

class _LoginRestoreWithMnemonicPageState extends State<LoginRestoreWithMnemonicPage> {
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
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: <Color>[RibnColors.tertiary, RibnColors.primaryOffColor],
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CustomPageTitle(
              title: Strings.restoreWallet,
              hideWaveAnimation: true,
              hideCloseCross: true,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  SizedBox(
                    width: maxWidth,
                    height: 80,
                    child: Center(
                      child: Text(
                        Strings.restoreWalletSeedPhraseDesc,
                        style: RibnToolkitTextStyles.smallBody.copyWith(fontSize: 15, color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: maxWidth,
                    child: Text(
                      Strings.enterSeedPhrase,
                      style: RibnToolkitTextStyles.extH3.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  // seed phrase text field
                  CustomTextField(
                    controller: controller,
                    hintText: Strings.hintSeedPhrase,
                    height: 57,
                    hasError: invalidSeedPhraseEntered,
                  ),
                ],
              ),
            ),
            // const OnboardingProgressBar(numSteps: 2, currStep: 0),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        child: SizedBox(
          height: 80,
          child: Column(
            children: [
              const OnboardingProgressBar(numSteps: 2, currStep: 0),
              const SizedBox(
                height: 20,
              ),
              LargeButton(
                dropShadowColor: RibnColors.whiteButtonShadow,
                buttonChild: Text(
                  Strings.next,
                  style: RibnToolkitTextStyles.btnLarge.copyWith(
                    color: Colors.white,
                  ),
                ),
                onPressed: onNextPressed,
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Handler for when [LargeButton] is pressed.
  ///
  /// Validates the seedphrase entered and if valid, navigates to the next page, i.e. [Routes.loginRestoreWalletnewPassword].
  void onNextPressed() {
    final bool isSeedPhraseValid = validateMnemonic(seedPhrase, 'english');
    if (isSeedPhraseValid) {
      StoreProvider.of<AppState>(context).dispatch(
        NavigateToRoute(
          Routes.loginRestoreWalletnewPassword,
          arguments: seedPhrase,
        ),
      );
    } else {
      setState(() {
        invalidSeedPhraseEntered = true;
      });
    }
  }
}
