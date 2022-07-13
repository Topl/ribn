// ignore_for_file: prefer_final_fields

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ribn/actions/restore_wallet_actions.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/models/app_state.dart';
import 'package:ribn/presentation/login/widgets/warning_section.dart';
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn_toolkit/constants/styles.dart';
import 'package:ribn_toolkit/widgets/atoms/custom_checkbox.dart';
import 'package:ribn_toolkit/widgets/atoms/custom_page_title.dart';
import 'package:ribn_toolkit/widgets/atoms/large_button.dart';
import 'package:ribn_toolkit/widgets/molecules/onboarding_progress_bar.dart';
import 'package:ribn_toolkit/widgets/molecules/password_text_field.dart';
import 'package:url_launcher/url_launcher.dart';

/// Page for creating a new wallet password, when restoring wallet with a [seedPhrase].
class NewWalletPasswordPage extends StatefulWidget {
  /// The seed phrase being used for wallet restoration.
  final String seedPhrase;

  const NewWalletPasswordPage({
    required this.seedPhrase,
    Key? key,
  }) : super(key: key);

  @override
  _NewWalletPasswordPageState createState() => _NewWalletPasswordPageState();
}

class _NewWalletPasswordPageState extends State<NewWalletPasswordPage> {
  /// Controllers for password textfields.
  final TextEditingController _newWalletPasswordController = TextEditingController();
  final TextEditingController _confirmWalletPasswordController = TextEditingController();

  /// True if the password entered is at least 12 characters.
  bool passwordAtLeast8Chars = false;

  /// True if both passwords match.
  bool passwordsMatch = false;

  /// Map to keep track of any textfield errors.
  Map<TextEditingController, bool> hasErrors = {};

  bool _obscurePassword = true;
  bool _readTermsOfAgreement = false;

  @override
  void initState() {
    // Initialize listeners for each controller.
    [_newWalletPasswordController, _confirmWalletPasswordController].toList().forEach((controller) {
      controller.addListener(() {
        setState(() {
          hasErrors[controller] = false;
          passwordAtLeast8Chars = _newWalletPasswordController.text.length >= 8;
          passwordsMatch = _newWalletPasswordController.text == _confirmWalletPasswordController.text;
        });
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    // Dispose listeners for each controller.
    [_newWalletPasswordController, _confirmWalletPasswordController].toList().forEach((controller) {
      controller.dispose();
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RibnColors.background,
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
          children: [
            // page title
            const CustomPageTitle(
              title: Strings.restoreWallet,
              hideCloseCross: true,
              hideWaveAnimation: true,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  // warning section
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 24.0),
                    child: WarningSection(),
                  ),
                  // new wallet password
                  SizedBox(
                    width: 309,
                    child: Text(
                      Strings.newWalletPassword,
                      style: RibnToolkitTextStyles.extH3.copyWith(color: Colors.white),
                    ),
                  ),
                  // enter new wallet password text field
                  PasswordTextField(
                    hintText: Strings.newWalletPasswordHint,
                    controller: _newWalletPasswordController,
                    hasError: hasErrors[_newWalletPasswordController] ?? false,
                    obscurePassword: _obscurePassword,
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 309,
                    child: Text(
                      Strings.confirmWalletPassword,
                      style: RibnToolkitTextStyles.extH3.copyWith(color: Colors.white),
                    ),
                  ),
                  // confirm wallet password text field
                  PasswordTextField(
                    hintText: Strings.confirmWalletPasswordHint,
                    controller: _confirmWalletPasswordController,
                    hasError: hasErrors[_confirmWalletPasswordController] ?? false,
                    obscurePassword: _obscurePassword,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                ],
              ),
            ),
            _buildTermsOfAgreementCheck(),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        child: SizedBox(
          height: 80,
          child: Column(
            children: [
              const OnboardingProgressBar(numSteps: 2, currStep: 1),
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
  /// Validates that the password entered is at least 8 characters and both passwords match
  /// before attempting to restore wallet.
  void onNextPressed() {
    setState(() {
      hasErrors[_newWalletPasswordController] = !passwordAtLeast8Chars;
      hasErrors[_confirmWalletPasswordController] = !passwordsMatch;
    });
    if (passwordAtLeast8Chars && passwordsMatch && _readTermsOfAgreement) {
      StoreProvider.of<AppState>(context).dispatch(
        RestoreWalletWithMnemonicAction(
          mnemonic: widget.seedPhrase,
          password: _confirmWalletPasswordController.text,
        ),
      );
    }
  }

  Widget _buildTermsOfAgreementCheck() {
    final url = Uri.parse(
      Strings.termsOfUseUrl,
    );

    return CustomCheckbox(
      fillColor: MaterialStateProperty.all(Colors.transparent),
      checkColor: RibnColors.active,
      borderColor: Colors.white,
      value: _readTermsOfAgreement,
      onChanged: (val) => setState(() {
        _readTermsOfAgreement = val ?? false;
      }),
      label: RichText(
        text: TextSpan(
          style: RibnToolkitTextStyles.body1.copyWith(color: Colors.white, height: 0),
          children: [
            const TextSpan(
              text: Strings.readAndAgreedToU,
            ),
            TextSpan(
              text: 'Terms of Use',
              style: RibnToolkitTextStyles.body1.copyWith(color: RibnColors.secondaryDark, height: 0),
              recognizer: TapGestureRecognizer()
                ..onTap = () async {
                  await launchUrl(url);
                },
            )
          ],
        ),
      ),
    );
  }
}
