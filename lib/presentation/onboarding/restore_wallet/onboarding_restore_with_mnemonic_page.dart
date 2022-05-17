import 'package:bip_topl/bip_topl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ribn/actions/restore_wallet_actions.dart';
import 'package:ribn/constants/colors.dart';
import 'package:ribn/constants/routes.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/constants/styles.dart';
import 'package:ribn/models/app_state.dart';
import 'package:ribn/presentation/login/widgets/advanced_option_button.dart';
import 'package:ribn/presentation/login/widgets/password_text_field.dart';
import 'package:ribn/widgets/custom_text_field.dart';
import 'package:ribn/widgets/onboarding_app_bar.dart';

/// Restore wallet using mnemonic / seed phrase during onboarding.
///
/// Allows entering a known seed phrase and a new wallet password to restore a wallet.
///
/// This page is used in the 'restore wallet' flow when initiated during onboarding,
/// hence the widget name is prefixed with 'Onboarding'.
class OnboardingRestoreWithMnemonicPage extends StatefulWidget {
  const OnboardingRestoreWithMnemonicPage({Key? key}) : super(key: key);

  @override
  _OnboardingRestoreWithMnemonicPageState createState() => _OnboardingRestoreWithMnemonicPageState();
}

class _OnboardingRestoreWithMnemonicPageState extends State<OnboardingRestoreWithMnemonicPage> {
  final double maxWidth = 734;
  final TextEditingController _seedPhraseTextController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  late List<TextEditingController> controllers;

  /// Map to keep track of any textfield errors.
  Map<TextEditingController, bool> hasErrors = {};

  /// True if paTextEditingControllerssword entered is at least 12 characters.
  bool passwordAtLeast8Chars = false;

  /// True if both passwords match.
  bool passwordsMatch = false;

  @override
  void initState() {
    controllers = [_seedPhraseTextController, _newPasswordController, _confirmPasswordController];
    controllers.toList().forEach((controller) {
      controller.addListener(() {
        setState(() {
          hasErrors[controller] = false;
          passwordAtLeast8Chars = _newPasswordController.text.length >= 8;
          passwordsMatch = _newPasswordController.text == _confirmPasswordController.text;
        });
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    controllers.toList().forEach((controller) {
      controller.dispose();
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /// Style used for descriptive text on the page.
    const TextStyle descriptionStyle = TextStyle(
      fontFamily: 'Nunito',
      fontSize: 15,
    );

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            OnboardingAppBar(onBackPressed: () => Navigator.of(context).pop()),
            _buildTitle(),
            SizedBox(
              width: maxWidth,
              child: const Text(
                Strings.restoreWalletSeedPhraseDesc,
                style: descriptionStyle,
              ),
            ),
            const SizedBox(height: 20),
            _buildSeedPhraseTextField(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: SizedBox(
                width: maxWidth,
                child: const AdvancedOptionButton(restoreWithToplKeyRoute: Routes.onboardingRestoreWalletWithToplKey),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15, bottom: 16),
              child: SizedBox(
                width: maxWidth,
                child: const Text(
                  'Next, let’s make a new Wallet Password.',
                  style: descriptionStyle,
                ),
              ),
            ),
            _buildPasswordTextField(_newPasswordController),
            const SizedBox(height: 15),
            _buildPasswordTextField(_confirmPasswordController),
            const SizedBox(height: 65),
            _buildRestoreButton(),
          ],
        ),
      ),
    );
  }

  /// Builds the page title.
  Widget _buildTitle() {
    return const Padding(
      padding: EdgeInsets.only(top: 22, bottom: 76),
      child: Text(
        Strings.restoreWallet,
        style: RibnTextStyles.h1,
        textAlign: TextAlign.center,
      ),
    );
  }

  /// TextField for entering the seed phrase.
  Widget _buildSeedPhraseTextField() {
    return SizedBox(
      width: maxWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(Strings.enterSeedPhrase, style: RibnTextStyles.extH3),
          CustomTextField(
            width: maxWidth,
            height: 36,
            hasError: hasErrors[_seedPhraseTextController] ?? false,
            controller: _seedPhraseTextController,
            hintText: Strings.hintSeedPhrase,
            textAlignVertical: TextAlignVertical.center,
          ),
          hasErrors[_seedPhraseTextController] ?? false
              ? const Text(
                  'Invalid seed phrase.',
                  style: TextStyle(color: Colors.red),
                )
              : const SizedBox(),
        ],
      ),
    );
  }

  /// Builds the password text field for entering and confirming new wallet password.
  Widget _buildPasswordTextField(TextEditingController controller) {
    final String labelText =
        controller == _newPasswordController ? Strings.newWalletPassword : Strings.confirmWalletPassword;
    final String hintText =
        controller == _newPasswordController ? Strings.newWalletPasswordHint : Strings.confirmWalletPasswordHint;
    final String errorText = controller == _newPasswordController ? Strings.atLeast8Chars : Strings.passwordsMustMatch;
    return SizedBox(
      width: maxWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(labelText, style: RibnTextStyles.extH3),
          PasswordTextField(
            width: 352,
            height: 36,
            controller: controller,
            hintText: hintText,
            hasError: hasErrors[controller] ?? false,
          ),
          hasErrors[controller] ?? false
              ? Text(
                  errorText,
                  style: const TextStyle(color: Colors.red),
                )
              : const SizedBox(),
        ],
      ),
    );
  }

  /// Builds the 'Restore' button to confirm the entered information.
  ///
  /// Upon press, [validateSeedPhraseAndPassword] is called to validate the user's input.
  Widget _buildRestoreButton() {
    return MaterialButton(
      padding: EdgeInsets.zero,
      minWidth: 0,
      onPressed: validateSeedPhraseAndPassword,
      color: RibnColors.primary,
      child: const SizedBox(
        width: 234,
        height: 45,
        child: Center(
          child: Text(
            'Restore',
            style: TextStyle(
              fontFamily: 'Nunito',
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  /// Validates the seedPhrase and password entered.
  ///
  /// Updates [hasErrors] in case any validation errors are found.
  /// Otherwise, dispatches [RestoreWalletWithMnemonicAction].
  void validateSeedPhraseAndPassword() {
    final bool isSeedPhraseValid = validateMnemonic(_seedPhraseTextController.text, 'english');
    if (!isSeedPhraseValid) {
      setState(() {
        hasErrors[_seedPhraseTextController] = true;
      });
    }
    if (!passwordAtLeast8Chars) {
      setState(() {
        hasErrors[_newPasswordController] = true;
      });
    }
    if (!passwordsMatch) {
      setState(() {
        hasErrors[_confirmPasswordController] = true;
      });
    }
    if (isSeedPhraseValid && passwordAtLeast8Chars && passwordsMatch) {
      StoreProvider.of<AppState>(context).dispatch(
        RestoreWalletWithMnemonicAction(
          mnemonic: _seedPhraseTextController.text,
          password: _confirmPasswordController.text,
        ),
      );
    }
  }
}
