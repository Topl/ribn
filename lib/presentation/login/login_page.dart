import 'package:bip_topl/bip_topl.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:local_auth/local_auth.dart';
import 'package:ribn/actions/keychain_actions.dart';
import 'package:ribn/constants/assets.dart';
import 'package:ribn/constants/keys.dart';
import 'package:ribn/constants/routes.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/containers/login_container.dart';
import 'package:ribn/models/app_state.dart';
import 'package:ribn/platform/platform.dart';
import 'package:ribn/presentation/onboarding/utils.dart';
import 'package:ribn/utils.dart';
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
  const LoginPage({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final double _baseWidth = 310;
  final TextEditingController _textEditingController = TextEditingController();
  final LocalAuthentication _localAuthentication = LocalAuthentication();

  /// True if login was attempted with an incorrect password.
  bool _incorrectPasswordEntered = false;

  /// True if authentication through biometrics produces an error
  bool _biometricsError = false;

  /// True if biometrics authentication is completed successfully
  bool _authorized = false;

  Future<void> _biometricsLogin() async {
    bool authenticated = false;
    try {
      authenticated = await authenticateWithBiometrics(_localAuthentication);
      final String toplKey = (await PlatformLocalStorage.instance.getKeyFromSecureStorage())!;
      if (authenticated) {
        StoreProvider.of<AppState>(context).dispatch(
          InitializeHDWalletAction(
            toplExtendedPrivateKey: Base58Encoder.instance.decode(toplKey),
          ),
        );
      }
    } catch (e) {
      setState(() {
        _biometricsError = true;
      });
      return;
    }
    if (!mounted) {
      return;
    }

    setState(() {
      _authorized = authenticated;
    });
  }

  void _checkBiometrics(LoginViewModel vm) {
    if (vm.isBiometricsEnabled) {
      _biometricsLogin().then(
        (value) => {if (_authorized) Keys.navigatorKey.currentState?.pushReplacementNamed(Routes.home)},
      );
    }
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LoginContainer(
      onInitialBuild: _checkBiometrics,
      builder: (context, vm) {
        void attemptLogin() {
          context.loaderOverlay.show();
          vm.attemptLogin(
            password: _textEditingController.text,
            onIncorrectPasswordEntered: () {
              setState(() {
                _incorrectPasswordEntered = true;
              });
              context.loaderOverlay.hide();
            },
          );
        }

        return Listener(
          onPointerDown: (_) {
            if (mounted) setState(() {});
          },
          child: LoaderOverlay(
            child: Scaffold(
              body: SingleChildScrollView(
                child: WaveContainer(
                  containerHeight: adaptHeight(1),
                  containerWidth: adaptWidth(1),
                  waveAmplitude: 30,
                  containerChild: Column(
                    mainAxisAlignment: kIsWeb ? MainAxisAlignment.start : MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          SizedBox(height: deviceTopPadding()),
                          renderIfWeb(const SizedBox(height: 40)),
                          Image.asset(RibnAssets.newRibnLogo, width: kIsWeb ? 102 : 138),
                          Text(
                            Strings.ribnWallet,
                            style: RibnToolkitTextStyles.h1.copyWith(
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Center(
                            child: SizedBox(
                              width: kIsWeb ? _baseWidth - 110 : _baseWidth,
                              child: Center(
                                child: Text(
                                  Strings.intro,
                                  style: RibnToolkitTextStyles.h3.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w300,
                                    height: 2,
                                    fontSize: kIsWeb ? 12 : 16,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      renderIfWeb(const SizedBox(height: 40)),
                      Column(
                        children: [
                          _buildTextFieldLabel(),
                          const SizedBox(height: 8),
                          PasswordTextField(
                            onSubmitted: attemptLogin,
                            hintText: Strings.typeSomething,
                            controller: _textEditingController,
                          ),
                        ],
                      ),
                      kIsWeb ? const SizedBox(height: 40) : const SizedBox(height: 25),
                      LargeButton(
                        backgroundColor: RibnColors.primary,
                        dropShadowColor: RibnColors.whiteButtonShadow,
                        buttonChild: Text(
                          Strings.unlock,
                          style: RibnToolkitTextStyles.btnLarge.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: kIsWeb ? 15 : 19.6,
                          ),
                        ),
                        onPressed: attemptLogin,
                      ),
                      renderIfWeb(const SizedBox(height: 20)),
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
                                    ).copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: kIsWeb ? 12 : 16,
                                    ),
                                  )
                                : const SizedBox(),
                            _biometricsError
                                ? Text(
                                    'There was an issue with Face ID, please try again',
                                    style: const TextStyle(
                                      color: Colors.red,
                                    ).copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: kIsWeb ? 12 : 16,
                                    ),
                                  )
                                : const SizedBox()
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
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
              fontSize: kIsWeb ? 12 : 16,
            ),
          ),
          // ignore: prefer_const_constructors
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: CustomToolTip(
              offsetPositionLeftValue: 160,
              toolTipIcon: Image.asset(
                RibnAssets.greyHelpBubble,
                width: 18,
                color: Colors.white,
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
              fontSize: kIsWeb ? 12 : 16,
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
              fontSize: kIsWeb ? 12 : 16,
            ),
            children: [
              const TextSpan(
                text: Strings.needHelp,
              ),
              TextSpan(
                text: Strings.ribnSupport,
                style: RibnToolkitTextStyles.h3.copyWith(
                  color: RibnColors.secondary,
                  fontSize: kIsWeb ? 12 : 16,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () async {
                    final Uri url = Uri.parse(Strings.supportEmailLink);

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
