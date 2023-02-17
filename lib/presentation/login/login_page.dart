// Flutter imports:

// Package imports:
import 'package:bip_topl/bip_topl.dart';
// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loader_overlay/loader_overlay.dart';
// Project imports:
import 'package:ribn/actions/keychain_actions.dart';
import 'package:ribn/constants/assets.dart';
import 'package:ribn/constants/keys.dart';
import 'package:ribn/constants/routes.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/containers/login_container.dart';
import 'package:ribn/platform/platform.dart';
import 'package:ribn/presentation/onboarding/utils.dart';
import 'package:ribn/providers/biometrics_provider.dart';
import 'package:ribn/providers/logger_provider.dart';
import 'package:ribn/providers/store_provider.dart';
import 'package:ribn/utils.dart';
import 'package:ribn/utils/input_utils.dart';
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
class LoginPage extends HookConsumerWidget {
  final double _baseWidth = 310;

  Future<bool> _biometricsLogin(
      WidgetRef ref, ValueNotifier<bool> biometricsError) async {
    bool authenticated = false;
    try {
      authenticated = await ref
          .read(biometricsProvider.notifier)
          .authenticateWithBiometrics();

      final String toplKey =
          (await PlatformLocalStorage.instance.getKeyFromSecureStorage())!;
      if (authenticated) {
        ref.read(storeProvider).dispatch(
              InitializeHDWalletAction(
                toplExtendedPrivateKey: Base58Encoder.instance.decode(toplKey),
              ),
            );
      }
    } catch (e) {
      ref.read(loggerProvider).log(
          logLevel: LogLevel.Severe,
          loggerClass: LoggerClass.Authentication,
          message: 'Biometrics authentication failed',
          error: e,
          stackTrace: StackTrace.current);

      biometricsError.value = true;
      return false;
    }
    return authenticated;
  }

  void _checkBiometrics(
      WidgetRef ref, ValueNotifier<bool> biometricsError) async {
    ref.read(biometricsProvider).whenData((value) => {
          if (value.isEnabled)
            {
              _biometricsLogin(ref, biometricsError).then(
                (authorized) => {
                  if (authorized)
                    Keys.navigatorKey.currentState
                        ?.pushReplacementNamed(Routes.home)
                },
              )
            }
        });
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /// True if login was attempted with an incorrect password.
    final _incorrectPasswordEntered = useState(false);

    /// True if authentication through biometrics produces an error
    final _biometricsError = useState(false);

    final _textEditingController = useTextEditingController();

    useEffect(() {
      _checkBiometrics(ref, _biometricsError);
    }, []);

    return LoginContainer(
      onInitialBuild: (vm) => null,
      builder: (context, vm) {
        void attemptLogin() {
          context.loaderOverlay.show();
          dismissKeyboard(context);

          vm.attemptLogin(
            password: _textEditingController.text,
            onIncorrectPasswordEntered: () {
              _incorrectPasswordEntered.value = true;
              context.loaderOverlay.hide();
            },
          );
        }

        return Listener(
          onPointerDown: (_) {},
          child: LoaderOverlay(
            child: Scaffold(
              body: SingleChildScrollView(
                child: WaveContainer(
                  containerHeight: MediaQuery.of(context).size.height,
                  containerWidth: MediaQuery.of(context).size.width,
                  waveAmplitude: 30,
                  containerChild: Column(
                    mainAxisAlignment: kIsWeb
                        ? MainAxisAlignment.start
                        : MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          SizedBox(height: deviceTopPadding()),
                          renderIfWeb(const SizedBox(height: 40)),
                          Image.asset(
                            RibnAssets.newRibnLogo,
                            width: kIsWeb ? 102 : 138,
                          ),
                          Text(
                            Strings.ribnWallet,
                            style: RibnToolkitTextStyles.h1.copyWith(
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Center(
                            child: SizedBox(
                              width: kIsWeb ? _baseWidth - 70 : _baseWidth,
                              child: Center(
                                child: Text(
                                  Strings.intro,
                                  style: RibnToolkitTextStyles.h3.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w300,
                                    height: 1.7,
                                    fontSize: kIsWeb ? 13 : 14,
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
                      kIsWeb
                          ? const SizedBox(height: 40)
                          : const SizedBox(height: 25),
                      LargeButton(
                        backgroundColor: RibnColors.primary,
                        dropShadowColor: RibnColors.whiteButtonShadow,
                        buttonChild: Text(
                          Strings.unlock,
                          style: RibnToolkitTextStyles.btnLarge.copyWith(
                            color: Colors.white,
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
                            _incorrectPasswordEntered.value
                                ? Text(
                                    'Incorrect Password',
                                    style: const TextStyle(
                                      color: Colors.red,
                                    ).copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: kIsWeb ? 13 : 14,
                                    ),
                                  )
                                : const SizedBox(),
                            _biometricsError.value
                                ? Text(
                                    'There was an issue with Face ID, please try again',
                                    style: const TextStyle(
                                      color: Colors.red,
                                    ).copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: kIsWeb ? 13 : 14,
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
      child: Wrap(
        children: [
          Text(
            Strings.enterWalletPassword,
            style: RibnToolkitTextStyles.h3.copyWith(
              color: Colors.white,
              fontSize: kIsWeb ? 13 : 14,
            ),
          ),
          // ignore: prefer_const_constructors
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: CustomToolTip(
              borderColor: Border.all(color: const Color(0xffE9E9E9)),
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
              fontSize: kIsWeb ? 13 : 14,
            ),
            children: [
              TextSpan(
                text: Strings.forgotPassword,
                recognizer: TapGestureRecognizer()
                  ..onTap = () => onButtonPress(),
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
              fontSize: kIsWeb ? 13 : 14,
            ),
            children: [
              const TextSpan(
                text: Strings.needHelp,
              ),
              TextSpan(
                text: Strings.ribnSupport,
                style: RibnToolkitTextStyles.h3.copyWith(
                  color: RibnColors.secondary,
                  fontSize: kIsWeb ? 13 : 14,
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
