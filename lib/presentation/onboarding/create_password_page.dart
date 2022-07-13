import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/constants/ui_constants.dart';
import 'package:ribn/containers/create_password_container.dart';
import 'package:ribn_toolkit/constants/assets.dart';
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn_toolkit/constants/styles.dart';
import 'package:ribn_toolkit/widgets/atoms/custom_checkbox.dart';
import 'package:ribn_toolkit/widgets/atoms/large_button.dart';
import 'package:ribn_toolkit/widgets/molecules/password_text_field.dart';
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
  final FocusNode _newPasswordFocus = FocusNode();
  final FocusNode _confirmPasswordFocus = FocusNode();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  bool _readTermsOfAgreement = false;
  bool _hasAtLeast8Chars = false;
  bool _passwordsMatch = false;
  // ignore: prefer_final_fields
  bool _obscurePassword = true;

  @override
  void initState() {
    _newPasswordController.addListener(validatePassword);
    _confirmPasswordController.addListener(validatePassword);
    _newPasswordFocus.addListener(validatePassword);
    _confirmPasswordFocus.addListener(validatePassword);
    super.initState();
  }

  void validatePassword() {
    setState(() {
      _hasAtLeast8Chars = _newPasswordController.text.length >= 8;
      _passwordsMatch =
          _confirmPasswordController.text.isNotEmpty && _newPasswordController.text == _confirmPasswordController.text;
    });
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
                  style: RibnToolkitTextStyles.h1,
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: SvgPicture.asset(RibnAssets.walletPasswordIcon),
              ),
              const Text(
                Strings.createWalletPasswordDesc,
                style: RibnToolkitTextStyles.body1,
                textAlign: TextAlign.left,
                textHeightBehavior: TextHeightBehavior(applyHeightToFirstAscent: false),
              ),
              _buildPasswordField(_newPasswordController, Strings.newPassword, _newPasswordFocus),
              _buildEnterPasswordValidations(),
              _buildPasswordField(_confirmPasswordController, Strings.confirmPassword, _confirmPasswordFocus),
              _buildConfirmPasswordValidation(),
              const SizedBox(height: 30),
              _buildTermsOfAgreementCheck(),
              LargeButton(
                buttonChild: Text(
                  Strings.createPassword,
                  style: !_passwordsMatch || !_readTermsOfAgreement
                      ? RibnToolkitTextStyles.btnLarge.copyWith(
                          color: RibnColors.inactive,
                        )
                      : RibnToolkitTextStyles.btnLarge.copyWith(
                          color: Colors.white,
                        ),
                ),
                backgroundColor: RibnColors.primary,
                hoverColor: RibnColors.primaryButtonHover,
                dropShadowColor: RibnColors.primaryButtonShadow,
                onPressed: () => vm.attemptCreatePassword(_confirmPasswordController.text),
                disabled: !_passwordsMatch || !_readTermsOfAgreement,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPasswordField(TextEditingController textEditingController, String label, FocusNode focusNode) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: RibnToolkitTextStyles.body1Bold,
          ),
          PasswordTextField(
            focusNode: focusNode,
            controller: textEditingController,
            hintText: Strings.newWalletPasswordHint,
            width: UIConstants.loginTextFieldWidth,
            height: UIConstants.loginTextFieldHeight,
            obscurePassword: _obscurePassword,
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
            Strings.atLeast8Chars,
            style: TextStyle(
              color: _hasAtLeast8Chars
                  ? Colors.green
                  : !_newPasswordFocus.hasPrimaryFocus && _newPasswordController.text.isNotEmpty
                      ? Colors.red
                      : Colors.grey,
              fontFamily: 'DM Sans',
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
              color: _passwordsMatch
                  ? Colors.green
                  : !_confirmPasswordFocus.hasPrimaryFocus && _confirmPasswordController.text.isNotEmpty
                      ? Colors.red
                      : Colors.grey,
              fontFamily: 'DM Sans',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTermsOfAgreementCheck() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 40),
      child: CustomCheckbox(
        fillColor: MaterialStateProperty.all(Colors.transparent),
        checkColor: RibnColors.active,
        borderColor: _readTermsOfAgreement ? RibnColors.active : RibnColors.inactive,
        value: _readTermsOfAgreement,
        onChanged: (val) => setState(() {
          _readTermsOfAgreement = val ?? false;
        }),
        label: RichText(
          text: TextSpan(
            style: RibnToolkitTextStyles.body1
                .copyWith(color: _readTermsOfAgreement ? RibnColors.defaultText : RibnColors.inactive),
            children: [
              const TextSpan(
                text: Strings.readAndAgreedToU,
              ),
              TextSpan(
                text: 'Terms of Use',
                style: RibnToolkitTextStyles.body1
                    .copyWith(color: _readTermsOfAgreement ? RibnColors.primary : RibnColors.inactive),
                recognizer: TapGestureRecognizer()
                  ..onTap = () async {
                    final Uri url = Uri.parse(Strings.termsOfUseUrl);

                    await launchUrl(url);
                  },
              )
            ],
          ),
        ),
      ),
    );
  }
}
