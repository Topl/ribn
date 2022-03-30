import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ribn/constants/assets.dart';
import 'package:ribn/constants/colors.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/constants/styles.dart';
import 'package:ribn/constants/ui_constants.dart';
import 'package:ribn/containers/login_container.dart';
import 'package:ribn/widgets/custom_icon_button.dart';
import 'package:ribn/widgets/custom_tooltip.dart';
import 'package:ribn/widgets/large_button.dart';
import 'package:url_launcher/url_launcher.dart';

/// Builds the login page.
///
/// Prompts the user to unlock their wallet by entering their wallet-locking password.
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final double _baseWidth = 310;
  final TextEditingController _textEditingController = TextEditingController();

  /// True if password being entered is obscured.
  bool _obscurePassword = true;

  /// True if login was attempted with an incorrect password.
  bool _incorrectPasswordEntered = false;

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LoginContainer(
      builder: (context, vm) {
        return Scaffold(
          backgroundColor: RibnColors.accent,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 65),
              const Text(
                Strings.ribnWallet,
                style: TextStyle(
                  fontFamily: 'Spectral',
                  fontWeight: FontWeight.bold,
                  fontSize: 32,
                ),
              ),
              const SizedBox(height: 15),
              SvgPicture.asset(RibnAssets.menuIcon, width: 77),
              const SizedBox(height: 20),
              const Center(
                child: SizedBox(
                  width: 245,
                  height: 50,
                  child: Center(
                    child: Text(
                      Strings.intro,
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        height: 1.6,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 25),
              _buildTextFieldLabel(),
              const SizedBox(height: 8),
              _buildTextField(),
              const SizedBox(height: 35),
              LargeButton(
                label: Strings.unlock,
                onPressed: () => vm.attemptLogin(
                  password: _textEditingController.text,
                  onIncorrectPasswordEntered: () {
                    setState(() {
                      _incorrectPasswordEntered = true;
                    });
                  },
                ),
                backgroundColor: RibnColors.primary,
                textColor: Colors.white,
              ),
              const SizedBox(height: 12),
              LargeButton(
                label: Strings.restoreWallet,
                onPressed: vm.restoreWallet,
                backgroundColor: RibnColors.primary.withOpacity(0.19),
                textColor: RibnColors.primary,
              ),
              const SizedBox(height: 18),
              _buildSupportLink(),
              UIConstants.sizedBox,
              _incorrectPasswordEntered
                  ? const Text(
                      'Incorrect Password',
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    )
                  : const SizedBox()
            ],
          ),
        );
      },
    );
  }

  Widget _buildTextFieldLabel() {
    return SizedBox(
      width: _baseWidth,
      child: Row(
        children: const [
          Text(
            Strings.enterWalletPassword,
            style: RibnTextStyles.extH3,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.0),
            child: CustomToolTip(
              toolTipChild: Text(
                Strings.loginPasswordInfo,
                style: RibnTextStyles.toolTipTextStyle,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Builds the text field for the wallet password.
  /// Allows showing/hiding the text input.
  Widget _buildTextField() {
    final OutlineInputBorder textFieldBorder = OutlineInputBorder(
      borderSide: const BorderSide(color: RibnColors.primary),
      borderRadius: BorderRadius.circular(4.7),
    );
    return SizedBox(
      width: _baseWidth,
      height: 35,
      child: TextField(
        obscureText: _obscurePassword,
        controller: _textEditingController,
        decoration: InputDecoration(
          suffixIcon: CustomIconButton(
            icon: SvgPicture.asset(
              _obscurePassword ? RibnAssets.passwordVisibleIon : RibnAssets.passwordHiddenIcon,
              width: 12,
            ),
            onPressed: () {
              setState(() {
                _obscurePassword = !_obscurePassword;
              });
            },
          ),
          labelText: Strings.typeSomething,
          labelStyle: RibnTextStyles.hintStyle,
          isDense: true,
          fillColor: Colors.white,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          filled: true,
          contentPadding: const EdgeInsets.all(10),
          enabledBorder: textFieldBorder,
          focusedBorder: textFieldBorder,
        ),
      ),
    );
  }

  /// Builds a link to redirect user to the support email.
  Widget _buildSupportLink() {
    return SizedBox(
      width: _baseWidth,
      child: Center(
        child: RichText(
          text: TextSpan(
            style: const TextStyle(
              color: RibnColors.defaultText,
              fontFamily: 'Nunito',
              fontSize: 15,
            ),
            children: [
              const TextSpan(
                text: Strings.needHelp,
              ),
              TextSpan(
                text: Strings.ribnSupport,
                style: const TextStyle(
                  color: RibnColors.primary,
                  fontWeight: FontWeight.w600,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () async {
                    await launch(Strings.supportEmailLink);
                  },
              )
            ],
          ),
        ),
      ),
    );
  }
}
