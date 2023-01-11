import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:ribn/actions/restore_wallet_actions.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/models/app_state.dart';
import 'package:ribn/presentation/onboarding/utils.dart';
import 'package:ribn/presentation/onboarding/widgets/confirmation_button.dart';
import 'package:ribn/presentation/onboarding/widgets/onboarding_container.dart';
import 'package:ribn/presentation/onboarding/widgets/warning_section.dart';
import 'package:ribn/presentation/onboarding/widgets/web_onboarding_app_bar.dart';
import 'package:ribn/utils.dart';
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn_toolkit/constants/styles.dart';
import 'package:ribn_toolkit/widgets/molecules/checkbox_wrappable_text.dart';
import 'package:ribn_toolkit/widgets/molecules/password_text_field.dart';
import 'package:ribn_toolkit/widgets/organisms/onboarding_progress_bar.dart';
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
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  /// True if the password entered is at least 8 characters.
  bool _atLeast8Chars = false;

  /// True if both passwords match.
  bool _passwordsMatch = false;

  /// Map to keep track of any textfield errors.
  Map<TextEditingController, bool> hasErrors = {};

  bool _termsOfUseChecked = false;

  @override
  void initState() {
    // Initialize listeners for each controller.
    [_newPasswordController, _confirmPasswordController]
        .toList()
        .forEach((controller) {
      controller.addListener(() {
        setState(() {
          hasErrors[controller] = false;
          _atLeast8Chars = _newPasswordController.text.length >= 8;
          _passwordsMatch =
              _newPasswordController.text == _confirmPasswordController.text;
        });
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    // Dispose listeners for each controller.
    [_newPasswordController, _confirmPasswordController]
        .toList()
        .forEach((controller) {
      controller.dispose();
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      child: Scaffold(
        extendBody: true,
        body: OnboardingContainer(
          child: SingleChildScrollView(
            clipBehavior: Clip.none,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                renderIfWeb(
                    const WebOnboardingAppBar(currStep: 1, numSteps: 2)),
                const Text(
                  Strings.restoreWallet,
                  style: RibnToolkitTextStyles.onboardingH1,
                  textAlign: TextAlign.center,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 24.0),
                  child: WarningSection(),
                ),
                SizedBox(
                  width: kIsWeb ? 370 : double.infinity,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildNewPasswordSection(),
                      SizedBox(height: adaptHeight(0.02)),
                      _buildConfirmPasswordSection(),
                      SizedBox(height: adaptHeight(0.02)),
                      _buildTermsOfAgreementCheck(),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                renderIfMobile(
                    const OnboardingProgressBar(numSteps: 2, currStep: 0)),
                const SizedBox(height: 20),
                ConfirmationButton(
                  text: Strings.done,
                  disabled: !_atLeast8Chars ||
                      !_passwordsMatch ||
                      !_termsOfUseChecked,
                  onPressed: () {
                    context.loaderOverlay.show();
                    StoreProvider.of<AppState>(context).dispatch(
                      RestoreWalletWithMnemonicAction(
                        mnemonic: widget.seedPhrase,
                        password: _confirmPasswordController.text,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNewPasswordSection() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            Strings.newWalletPassword,
            textAlign: TextAlign.left,
            style: RibnToolkitTextStyles.h3.copyWith(
              fontWeight: FontWeight.bold,
              color: RibnColors.lightGreyTitle,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Align(
          alignment: Alignment.centerLeft,
          child: PasswordTextField(
            width: kIsWeb ? 350 : adaptWidth(0.9),
            fillColor: RibnColors.whiteButtonShadow,
            controller: _newPasswordController,
            hintText: '',
            obscurePassword: true,
          ),
        ),
        const SizedBox(height: 8),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            Strings.atLeast8Chars,
            textAlign: TextAlign.left,
            style: RibnToolkitTextStyles.h3.copyWith(
              color: !_atLeast8Chars && _newPasswordController.text.isNotEmpty
                  ? Colors.red
                  : Colors.white,
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            Strings.passwordExample,
            textAlign: TextAlign.left,
            style: RibnToolkitTextStyles.h3.copyWith(
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  _buildConfirmPasswordSection() {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            Strings.confirmWalletPassword,
            textAlign: TextAlign.left,
            style: RibnToolkitTextStyles.h3.copyWith(
              fontWeight: FontWeight.bold,
              color: RibnColors.lightGreyTitle,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Align(
          alignment: Alignment.centerLeft,
          child: PasswordTextField(
            width: kIsWeb ? 350 : adaptWidth(0.9),
            fillColor: RibnColors.whiteButtonShadow,
            controller: _confirmPasswordController,
            hintText: '',
            obscurePassword: true,
          ),
        ),
        const SizedBox(height: 8),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            Strings.passwordsMustMatch,
            textAlign: TextAlign.left,
            style: RibnToolkitTextStyles.h3.copyWith(
              color:
                  !_passwordsMatch && _confirmPasswordController.text.isNotEmpty
                      ? Colors.red
                      : Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTermsOfAgreementCheck() {
    final url = Uri.parse(Strings.termsOfUseUrl);
    return CheckboxWrappableText(
      wrapText: false,
      borderColor: _termsOfUseChecked
          ? const Color(0xff80FF00)
          : RibnColors.lightGreyTitle,
      value: _termsOfUseChecked,
      onChanged: (bool? checked) {
        setState(() {
          _termsOfUseChecked = checked ?? false;
        });
      },
      label: RichText(
        maxLines: 2,
        key: GlobalKey(),
        text: TextSpan(
          children: [
            TextSpan(
              text: Strings.readAndAgreedToU,
              style: RibnToolkitTextStyles.h3.copyWith(
                color: RibnColors.lightGreyTitle,
                fontSize: 15,
              ),
            ),
            TextSpan(
              text: Strings.termsOfUse,
              style: RibnToolkitTextStyles.h3.copyWith(
                color: const Color(0xff00FFC5),
                fontSize: 15,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () async {
                  await launchUrl(url);
                },
            ),
          ],
        ),
      ),
      activeText: true,
    );
  }
}
