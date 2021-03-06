import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ribn/constants/assets.dart';
import 'package:ribn/constants/colors.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/constants/styles.dart';
import 'package:ribn/constants/ui_constants.dart';
import 'package:ribn/containers/create_password_container.dart';
import 'package:ribn/presentation/login/widgets/password_text_field.dart';
import 'package:ribn/widgets/continue_button.dart';
import 'package:url_launcher/url_launcher.dart';

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
  bool _hasAtLeast12Chars = false;
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
    _hasAtLeast12Chars = false;
    if (password.length >= 12) _hasAtLeast12Chars = true;
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
              _buildPasswordField(_newPasswordController, Strings.newPassword),
              _buildEnterPasswordValidations(),
              _buildPasswordField(_confirmPasswordController, Strings.confirmPassword),
              _buildConfirmPasswordValidation(),
              const SizedBox(height: 30),
              _buildTermsOfAgreementCheck(),
              ContinueButton(
                Strings.createPassword,
                () => vm.attemptCreatePassword(_confirmPasswordController.text),
                disabled: !_passwordsMatch || !_readTermsOfAgreement,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPasswordField(TextEditingController textEditingController, String label) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: RibnTextStyles.body1Bold,
          ),
          PasswordTextField(
            controller: textEditingController,
            hintText: Strings.newWalletPasswordHint,
            width: UIConstants.loginTextFieldWidth,
            height: UIConstants.loginTextFieldHeight,
          ),
        ],
      ),
    );
  }

  Widget _buildEnterPasswordValidations() {
    return SizedBox(
      width: 420,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            Strings.atLeast12Chars,
            style: TextStyle(
              color: _hasAtLeast12Chars ? Colors.green : Colors.grey,
              fontFamily: 'Roboto',
              fontSize: 20,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConfirmPasswordValidation() {
    return SizedBox(
      width: 420,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            Strings.passwordsMustMatch,
            style: TextStyle(
              color: _passwordsMatch ? Colors.green : Colors.grey,
              fontFamily: 'Roboto',
              fontSize: 20,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTermsOfAgreementCheck() {
    return SizedBox(
      width: 700,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
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
            child: RichText(
              text: TextSpan(
                style: RibnTextStyles.body1
                    .copyWith(color: _readTermsOfAgreement ? RibnColors.defaultText : RibnColors.inactive),
                children: [
                  const TextSpan(
                    text: Strings.readAndAgreedToU,
                  ),
                  TextSpan(
                    text: 'Terms of Use',
                    style: RibnTextStyles.body1
                        .copyWith(color: _readTermsOfAgreement ? RibnColors.primary : RibnColors.inactive),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () async {
                        await launch(Strings.termsOfUseUrl);
                      },
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
