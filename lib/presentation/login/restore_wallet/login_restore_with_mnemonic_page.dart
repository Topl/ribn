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
import 'package:ribn_toolkit/widgets/atoms/peekaboo_button.dart';

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
      backgroundColor: RibnColors.background,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CustomPageTitle(title: Strings.restoreWallet),
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
                      style: RibnToolkitTextStyles.smallBody.copyWith(fontSize: 15),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: maxWidth,
                  child: const Text(
                    Strings.enterSeedPhrase,
                    style: RibnToolkitTextStyles.extH3,
                  ),
                ),
                // seed phrase text field
                CustomTextField(
                  controller: controller,
                  hintText: Strings.hintSeedPhrase,
                  height: 57,
                  hasError: invalidSeedPhraseEntered,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
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
                            style: RibnToolkitTextStyles.dropdownButtonStyle
                                .copyWith(fontSize: 11, color: RibnColors.ghostButtonText),
                          ),
                          backgroundColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          dropShadowColor: Colors.transparent,
                          borderColor: RibnColors.ghostButtonText,
                          onPressed: () {
                            StoreProvider.of<AppState>(context).dispatch(
                              NavigateToRoute(
                                Routes.loginRestoreWalletWithToplKey,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 100,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 17.0),
                  child: LargeButton(
                    buttonChild: Text(
                      Strings.next,
                      style: RibnToolkitTextStyles.btnMedium.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: onNextPressed,
                  ),
                ),
              ],
            ),
          ),
        ],
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
