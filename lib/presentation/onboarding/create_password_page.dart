import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ribn/constants/assets.dart';
import 'package:ribn/constants/colors.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/constants/styles.dart';
import 'package:ribn/constants/ui_constants.dart';
import 'package:ribn/containers/create_password_container.dart';
import 'package:ribn/widgets/continue_button.dart';

/// Builds the form for creating a wallet password.
/// Allows creation of password once all validation steps are satisfied.
class CreatePasswordPage extends StatefulWidget {
  final Function goToNextPage;
  const CreatePasswordPage(this.goToNextPage, {Key? key}) : super(key: key);

  @override
  State<CreatePasswordPage> createState() => _CreatePasswordPageState();
}

class _CreatePasswordPageState extends State<CreatePasswordPage> {
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  bool _readTermsOfAgreement = false;
  bool _hasAtLeast8Chars = false;
  bool _hasOneOrMoreNumbers = false;
  bool _hasOneUpperCaseLetter = false;
  bool _hasOneOrMoreLowerCaseLetters = false;
  bool _hasSpace = false;
  bool _validPassword = false;
  bool _passwordsMatch = false;

  @override
  void initState() {
    _newPasswordController.addListener(() {
      validatePassword(_newPasswordController.text);
    });
    _confirmPasswordController.addListener(() {
      setState(() {
        _passwordsMatch = _newPasswordController.text == _confirmPasswordController.text;
      });
    });
    super.initState();
  }

  void validatePassword(String password) {
    _hasAtLeast8Chars = false;
    _hasOneOrMoreNumbers = false;
    _hasOneUpperCaseLetter = false;
    _hasOneOrMoreLowerCaseLetters = false;
    _hasSpace = false;
    _validPassword = false;
    if (password.length >= 8) _hasAtLeast8Chars = true;
    if (password.contains(RegExp(r'[0-9]'))) _hasOneOrMoreNumbers = true;
    if (password.contains(RegExp(r'[a-z]'))) _hasOneOrMoreLowerCaseLetters = true;
    if (RegExp(r'[A-Z]').allMatches(password).length == 1) _hasOneUpperCaseLetter = true;
    if (password.contains(' ') && password.length >= 8) _hasSpace = true;
    _validPassword = _hasAtLeast8Chars &&
        _hasOneOrMoreNumbers &&
        _hasOneOrMoreLowerCaseLetters & _hasOneUpperCaseLetter &&
        !_hasSpace;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return CreatePasswordContainer(
      onDidChange: (_, vm) {
        if (vm.passwordSuccessfullyCreated) widget.goToNextPage();
      },
      builder: (context, vm) {
        return Padding(
          padding: const EdgeInsets.only(top: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                width: 315,
                height: 100,
                child: Text(
                  Strings.createWalletPassword,
                  style: RibnTextStyles.h1,
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: SvgPicture.asset(RibnAssets.walletPasswordIcon),
              ),
              const Text(
                Strings.createWalletPasswordDesc,
                style: RibnTextStyles.body1,
                textAlign: TextAlign.left,
                textHeightBehavior: TextHeightBehavior(applyHeightToFirstAscent: false),
              ),
              _buildTextField(_newPasswordController, Strings.newPassword),
              _buildEnterPasswordValidations(),
              _buildTextField(_confirmPasswordController, Strings.confirmPassword),
              _buildConfirmPasswordValidation(),
              const SizedBox(height: 30),
              _buildTermsOfAgreementCheck(),
              ContinueButton(
                Strings.createPassword,
                () => vm.attemptCreatePassword(_confirmPasswordController.text),
                disabled: !_validPassword || !_passwordsMatch || !_readTermsOfAgreement,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTextField(TextEditingController textEditingController, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Text(label),
          SizedBox(
            width: UIConstants.loginTextFieldWidth,
            child: TextField(
              controller: textEditingController,
              decoration: const InputDecoration(
                isDense: true,
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.all(10),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEnterPasswordValidations() {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: Column(
        children: [
          Text(
            Strings.atLeast8Chars,
            style: TextStyle(color: _hasAtLeast8Chars ? Colors.green : Colors.grey),
          ),
          Text(
            Strings.oneOrMoreNumbers,
            style: TextStyle(color: _hasOneOrMoreNumbers ? Colors.green : Colors.grey),
          ),
          Text(
            Strings.oneUpperCaseLetter,
            style: TextStyle(color: _hasOneUpperCaseLetter ? Colors.green : Colors.grey),
          ),
          Text(
            Strings.oneOrMoreLowerCaseLetters,
            style: TextStyle(color: _hasOneOrMoreLowerCaseLetters ? Colors.green : Colors.grey),
          ),
          Text(
            Strings.spacesAreNotAllowed,
            style: TextStyle(color: _hasSpace ? Colors.grey : Colors.green),
          ),
        ],
      ),
    );
  }

  Widget _buildConfirmPasswordValidation() {
    return Text(
      Strings.passwordsMustMatch,
      style: TextStyle(color: _passwordsMatch ? Colors.green : Colors.grey),
    );
  }

  Widget _buildTermsOfAgreementCheck() {
    return SizedBox(
      width: 700,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 16),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                border: Border.all(color: _readTermsOfAgreement ? RibnColors.active : RibnColors.inactive),
              ),
              constraints: const BoxConstraints(maxHeight: 20, maxWidth: 20),
              child: Checkbox(
                fillColor: MaterialStateProperty.all(Colors.transparent),
                checkColor: RibnColors.active,
                value: _readTermsOfAgreement,
                onChanged: (val) => setState(() {
                  _readTermsOfAgreement = val ?? false;
                }),
              ),
            ),
          ),
          SizedBox(
            height: 50,
            child: Text(
              Strings.readAndAgreedToU,
              style: RibnTextStyles.body1
                  .copyWith(color: _readTermsOfAgreement ? RibnColors.defaultText : RibnColors.inactive),
              textAlign: TextAlign.start,
              textHeightBehavior: const TextHeightBehavior(applyHeightToFirstAscent: false),
            ),
          ),
        ],
      ),
    );
  }
}
