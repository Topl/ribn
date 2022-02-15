import 'package:bip_topl/bip_topl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ribn/actions/onboarding_actions.dart';
import 'package:ribn/constants/colors.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/constants/styles.dart';
import 'package:ribn/models/app_state.dart';
import 'package:ribn/presentation/login/widgets/password_text_field.dart';
import 'package:ribn/widgets/custom_text_field.dart';
import 'package:ribn/widgets/onboarding_app_bar.dart';

/// Restore wallet using seed phrase during onboarding.
///
/// Allows entering a known seed phrase and a new wallet password to restore their wallet.
class OnboardingRestoreWithSeedPhrasePage extends StatefulWidget {
  const OnboardingRestoreWithSeedPhrasePage({Key? key}) : super(key: key);

  @override
  _OnboardingRestoreWithSeedPhrasePageState createState() => _OnboardingRestoreWithSeedPhrasePageState();
}

class _OnboardingRestoreWithSeedPhrasePageState extends State<OnboardingRestoreWithSeedPhrasePage> {
  final TextEditingController _seedPhraseTextController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  late List<TextEditingController> controllers;

  /// Map to keep track of any textfield errors.
  Map<TextEditingController, bool> hasErrors = {};

  /// True if password entered is at least 8 characters.
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
            const SizedBox(
              width: 734,
              child: Text(
                'First, enter your 15-word Seed Phrase that you wrote down when you first created your wallet',
                style: descriptionStyle,
              ),
            ),
            const SizedBox(height: 20),
            _buildSeedPhraseTextField(),
            const Padding(
              padding: EdgeInsets.only(top: 34, bottom: 16),
              child: SizedBox(
                width: 734,
                child: Text(
                  'Next, let’s make a new Wallet Password.',
                  style: descriptionStyle,
                ),
              ),
            ),
            _buildNewPasswordTextField(),
            const SizedBox(height: 15),
            _buildConfirmPasswordTextField(),
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

  /// TextField for entering the known seed phrase.
  Widget _buildSeedPhraseTextField() {
    return SizedBox(
      width: 734,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(Strings.enterSeedPhrase, style: RibnTextStyles.extH3),
          CustomTextField(
            width: 734,
            height: 36,
            hasError: hasErrors[_seedPhraseTextController] ?? false,
            controller: _seedPhraseTextController,
            hintText: Strings.hintSeedPhrase,
            textAlignVertical: TextAlignVertical.center,
          ),
        ],
      ),
    );
  }

  /// TextField for allowing user to enter a new wallet password.
  Widget _buildNewPasswordTextField() {
    return SizedBox(
      width: 734,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(Strings.newWalletPassword, style: RibnTextStyles.extH3),
          PasswordTextField(
            width: 352,
            height: 36,
            controller: _newPasswordController,
            hintText: Strings.newWalletPasswordHint,
            hasError: hasErrors[_newPasswordController] ?? false,
          ),
        ],
      ),
    );
  }

  /// Textfield to enter the wallet password a second time for confirmation.
  Widget _buildConfirmPasswordTextField() {
    return SizedBox(
      width: 734,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(Strings.confirmWalletPassword, style: RibnTextStyles.extH3),
          PasswordTextField(
            width: 352,
            height: 36,
            controller: _confirmPasswordController,
            hintText: Strings.confirmWalletPasswordHint,
            hasError: hasErrors[_confirmPasswordController] ?? false,
          ),
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
  /// Otherwise, dispatches [RestoreWalletAction].
  void validateSeedPhraseAndPassword() {
    final bool isSeedPhraseValid = validateMnemonic(_seedPhraseTextController.text, 'english');
    if (!isSeedPhraseValid) {
      setState(() {
        hasErrors[_seedPhraseTextController] = true;
      });
    } else if (!passwordAtLeast8Chars) {
      setState(() {
        hasErrors[_newPasswordController] = true;
      });
    } else if (!passwordsMatch) {
      setState(() {
        hasErrors[_confirmPasswordController] = true;
      });
    } else {
      StoreProvider.of<AppState>(context).dispatch(
        RestoreWalletAction(
          mnemonic: _seedPhraseTextController.text,
          password: _confirmPasswordController.text,
        ),
      );
    }
  }
}
