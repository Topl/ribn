import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ribn/constants/assets.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/containers/login_container.dart';
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn_toolkit/constants/styles.dart';
import 'package:ribn_toolkit/widgets/atoms/large_button.dart';
import 'package:ribn_toolkit/widgets/molecules/custom_tooltip.dart';
import 'package:ribn_toolkit/widgets/molecules/password_text_field.dart';
import 'package:ribn_toolkit/widgets/molecules/wave_container.dart';
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
          body: WaveContainer(
            containerHeight: double.infinity,
            containerWidth: double.infinity,
            waveAmplitude: 30,
            containerChild: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Image.asset(RibnAssets.newRibnLogo, width: 138),
                    Text(
                      Strings.ribnWallet,
                      style: RibnToolkitTextStyles.h1.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Center(
                      child: SizedBox(
                        width: _baseWidth,
                        child: Center(
                          child: Text(
                            Strings.intro,
                            style: RibnToolkitTextStyles.h3.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w300,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    _buildTextFieldLabel(),
                    const SizedBox(height: 8),
                    PasswordTextField(
                      hintText: Strings.typeSomething,
                      controller: _textEditingController,
                      icon: SvgPicture.asset(
                        _obscurePassword ? RibnAssets.passwordVisibleIon : RibnAssets.passwordHiddenIcon,
                        width: 12,
                      ),
                      obscurePassword: _obscurePassword,
                    ),
                    const SizedBox(height: 25),
                    LargeButton(
                      backgroundColor: RibnColors.primary,
                      dropShadowColor: RibnColors.whiteButtonShadow,
                      buttonChild: Text(
                        Strings.unlock,
                        style: RibnToolkitTextStyles.btnLarge.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      onPressed: () => vm.attemptLogin(
                        password: _textEditingController.text,
                        onIncorrectPasswordEntered: () {
                          setState(() {
                            _incorrectPasswordEntered = true;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 25),
                    _buildForgetPasswordLink(vm.restoreWallet),
                    const SizedBox(height: 40),
                    SizedBox(
                      height: 50,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          _buildSupportLink(),
                          const SizedBox(height: 10),
                          _incorrectPasswordEntered
                              ? Text(
                                  'Incorrect Password',
                                  style: const TextStyle(
                                    color: Colors.red,
                                  ).copyWith(fontWeight: FontWeight.bold),
                                )
                              : const SizedBox()
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTextFieldLabel() {
    return SizedBox(
      width: _baseWidth,
      child: Row(
        children: [
          Text(
            Strings.enterWalletPassword,
            style: RibnToolkitTextStyles.h3.copyWith(
              color: Colors.white,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: CustomToolTip(
              offsetPositionLeftValue: 160,
              toolTipIcon: Image.asset(
                RibnAssets.greyHelpBubble,
                width: 18,
              ),
              toolTipChild: const Text(
                Strings.loginPasswordInfo,
                style: RibnToolkitTextStyles.toolTipTextStyle,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Builds a link to redirect user to the restore wallet flow.
  Widget _buildForgetPasswordLink(onButtonPress) {
    return SizedBox(
      width: _baseWidth,
      child: Center(
        child: RichText(
          text: TextSpan(
            style: RibnToolkitTextStyles.h3.copyWith(
              color: RibnColors.secondary,
            ),
            children: [
              TextSpan(
                text: Strings.forgotPassword,
                recognizer: TapGestureRecognizer()..onTap = () => onButtonPress(),
              )
            ],
          ),
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
            style: RibnToolkitTextStyles.h3.copyWith(
              color: Colors.white,
            ),
            children: [
              const TextSpan(
                text: Strings.needHelp,
              ),
              TextSpan(
                text: Strings.ribnSupport,
                style: RibnToolkitTextStyles.h3.copyWith(
                  color: RibnColors.secondary,
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
