// Flutter imports:

// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:bip_topl/bip_topl.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:ribn/utils/utils.dart';
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn_toolkit/constants/styles.dart';
import 'package:ribn_toolkit/widgets/atoms/large_button.dart';
import 'package:ribn_toolkit/widgets/molecules/wave_container.dart';

// Project imports:
import 'package:ribn/actions/keychain_actions.dart';
import 'package:ribn/constants/assets.dart';
import 'package:ribn/constants/keys.dart';
import 'package:ribn/constants/routes.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/platform/platform.dart';
import 'package:ribn/presentation/login/widgets/forget_password_link_section.dart';
import 'package:ribn/presentation/login/widgets/password_section.dart';
import 'package:ribn/presentation/login/widgets/support_link_section.dart';
import 'package:ribn/presentation/onboarding/utils.dart';

import 'package:ribn/providers/biometrics_provider.dart';
import 'package:ribn/providers/logger_provider.dart';
import 'package:ribn/providers/login_provider.dart';
import 'package:ribn/providers/packages/flutter_secure_storage_provider.dart';
import 'package:ribn/providers/store_provider.dart';
import 'package:ribn/utils/extensions.dart';
import 'package:ribn/utils/input_utils.dart';

/// Builds the login page.
///
/// Prompts the user to unlock their wallet by entering their wallet-locking password.
class LoginPage extends HookConsumerWidget {
  const LoginPage({
    Key? key,
  }) : super(key: key);
  final double _baseWidth = 310;

  Future<bool> _biometricsLogin(WidgetRef ref, ValueNotifier<bool> biometricsError) async {
    bool authenticated = false;
    try {
      authenticated = await ref.read(biometricsProvider.notifier).authenticateWithBiometrics();

      final String toplKey = (await PlatformLocalStorage.instance
          .getKeyFromSecureStorage(override: ref.read(flutterSecureStorageProvider)()))!;
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

  void _checkBiometrics(WidgetRef ref, ValueNotifier<bool> biometricsError) async {
    ref.read(biometricsProvider).whenData((value) {
      if (value.isEnabled)
        _biometricsLogin(ref, biometricsError).then(
          (authorized) => {if (authorized) Keys.navigatorKey.currentState?.pushReplacementNamed(Routes.home)},
        );
    });
  }

  void attemptLogin(
      WidgetRef ref, BuildContext context, TextEditingController controller, ValueNotifier<bool> PasswordEntered) {
    context.loaderOverlay.show();
    dismissKeyboard(context);

    ref.read(loginProvider.notifier).attemptLogin(
          context: context,
          password: controller.text,
          onIncorrectPasswordEntered: () {
            PasswordEntered.value = true;
            context.loaderOverlay.hide();
          },
        );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /// True if login was attempted with an incorrect password.
    final _incorrectPasswordEntered = useState(false);

    /// True if authentication through biometrics produces an error
    final _biometricsError = useState(false);

    final _textEditingController = useTextEditingController();

    final biometrics = ref.watch(biometricsProvider);

    final notifier = ref.read(loginProvider.notifier);

    useEffect(() {
      Future.delayed(Duration.zero, () {
        _checkBiometrics(ref, _biometricsError);
      });
      return null;
    }, [biometrics]);

    return Listener(
        onPointerDown: (_) {},
        child: LoaderOverlay(
          child: Scaffold(
            body: SingleChildScrollView(
              child: WaveContainer(
                containerHeight: context.clientHeight,
                containerWidth: context.clientWidth,
                waveAmplitude: 30,
                containerChild: Column(
                  mainAxisAlignment: kIsWeb ? MainAxisAlignment.start : MainAxisAlignment.spaceAround,
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
                    PasswordSection(
                      baseWidth: _baseWidth,
                      controller: _textEditingController,
                      onSubmitted: () => attemptLogin(ref, context, _textEditingController, _incorrectPasswordEntered),
                    ),
                    kIsWeb ? const SizedBox(height: 40) : const SizedBox(height: 25),
                    LargeButton(
                      backgroundColor: RibnColors.primary,
                      dropShadowColor: RibnColors.whiteButtonShadow,
                      buttonChild: Text(
                        Strings.unlock,
                        style: RibnToolkitTextStyles.btnLarge.copyWith(
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () => attemptLogin(ref, context, _textEditingController, _incorrectPasswordEntered),
                    ),
                    renderIfWeb(const SizedBox(height: 20)),
                    ForgetPasswordLinkSection(baseWidth: _baseWidth, onButtonPress: notifier.restoreWallet),
                    const SizedBox(height: 40),
                    SizedBox(
                      height: 50,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SupportLinkSection(baseWidth: _baseWidth),
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
        ));
  }
}
