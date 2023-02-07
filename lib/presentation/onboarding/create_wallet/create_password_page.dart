// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Package imports:
import 'package:loader_overlay/loader_overlay.dart';
import 'package:ribn/constants/routes.dart';
import 'package:ribn/providers/onboarding_provider.dart';
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn_toolkit/constants/styles.dart';
import 'package:ribn_toolkit/widgets/molecules/checkbox_wrappable_text.dart';
import 'package:ribn_toolkit/widgets/molecules/password_text_field.dart';
import 'package:url_launcher/url_launcher.dart';

// Project imports:
import 'package:ribn/constants/assets.dart';
// import 'package:ribn/constants/routes.dart';
import 'package:ribn/constants/strings.dart';
// import 'package:ribn/containers/create_password_container.dart';
import 'package:ribn/presentation/onboarding/utils.dart';
import 'package:ribn/presentation/onboarding/widgets/confirmation_button.dart';
import 'package:ribn/presentation/onboarding/widgets/mobile_onboarding_progress_bar.dart';
import 'package:ribn/presentation/onboarding/widgets/onboarding_container.dart';
import 'package:ribn/presentation/onboarding/widgets/web_onboarding_app_bar.dart';
import 'package:ribn/utils.dart';

class CreatePasswordPage extends HookConsumerWidget {
  CreatePasswordPage({Key? key}) : super(key: key);

  // QQQQ delete
  // @override
  // void initState() {
  //   [_newPasswordFocus, _newPasswordController].toList().forEach((elem) {
  //     elem.addListener(() {
  //       if (!_newPasswordFocus.hasPrimaryFocus || _newPasswordController.text.length >= 8) {
  //         _atLeast8Chars =
  //             _newPasswordController.text.isNotEmpty && _newPasswordController.text.length >= 8;
  //         setState(() {});
  //       }
  //     });
  //   });
  //   [_confirmPasswordFocus, _confirmPasswordController].toList().forEach((elem) {
  //     elem.addListener(() {
  //       if (!_confirmPasswordFocus.hasPrimaryFocus ||
  //           _confirmPasswordController.text == _newPasswordController.text) {
  //         _passwordsMatch = _confirmPasswordController.text.isNotEmpty &&
  //             _confirmPasswordController.text == _newPasswordController.text;
  //         setState(() {});
  //       }
  //     });
  //   });
  //   super.initState();
  // }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(() {
      return () {
        _formKey.currentState?.dispose();
      };
    }, []);

    // final FocusNode _newPasswordFocus = useFocusNode();
    // final FocusNode _confirmPasswordFocus = useFocusNode();
    final TextEditingController _newPasswordController = useTextEditingController();
    final TextEditingController _confirmPasswordController = useTextEditingController();

    final _termsOfUseChecked = useState(false);
    final _atLeast8Chars = useState(false);
    final _passwordsMatch = useState(false);

    final onboardingNotifier = ref.read(onboardingProvider.notifier);

    useEffect(() {
      void _passwordCheck() {
        // If the new password is greater then 7 set [_atLeast8Chars] to true
        if (_newPasswordController.text.length > 7) {
          _atLeast8Chars.value = true;
        }
        // Else if it is true and not greater then 7, then set to false
        else if (_atLeast8Chars.value) {
          _atLeast8Chars.value = false;
        }

        // If both passwords match, then set [_passwordsMatch] to true
        if (_newPasswordController.text == _confirmPasswordController.text) {
          _passwordsMatch.value = true;
        }
        // Else if they dont match and [_passwordsMatch] is true set it to false
        else if (_passwordsMatch.value) {
          _passwordsMatch.value = false;
        }
      }

      _newPasswordController.addListener(
        () {
          _passwordCheck();
        },
      );
      _confirmPasswordController.addListener(
        () {
          _passwordCheck();
        },
      );
    }, []);

    return LoaderOverlay(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: OnboardingContainer(
          child: SingleChildScrollView(
            clipBehavior: Clip.none,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  renderIfWeb(const WebOnboardingAppBar(currStep: 2)),
                  SizedBox(
                    width: 200,
                    child: const Text(
                      Strings.createWalletPassword,
                      style: RibnToolkitTextStyles.onboardingH1,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: adaptHeight(0.01)),
                    child: Image.asset(
                      RibnAssets.createWalletPngWithShadow,
                      width: 100,
                    ),
                  ),
                  SizedBox(
                    width: 730,
                    child: Column(
                      children: [
                        SizedBox(
                          width: adaptWidth(0.9),
                          child: const Text(
                            Strings.createWalletPasswordDesc,
                            style: RibnToolkitTextStyles.onboardingH3,
                          ),
                        ),
                        SizedBox(height: adaptHeight(0.02)),
                        _NewPasswordSection(
                          textEditingController: _newPasswordController,
                          atLeast8Chars: _atLeast8Chars.value,
                        ),
                        SizedBox(height: adaptHeight(0.02)),
                        _ConfirmPasswordSection(
                          textEditingController: _confirmPasswordController,
                          passwordsMatch: _passwordsMatch.value,
                        ),
                        SizedBox(height: adaptHeight(0.02)),
                        CheckboxWrappableText(
                          wrapText: false,
                          borderColor: _termsOfUseChecked.value
                              ? const Color(0xff80FF00)
                              : RibnColors.lightGreyTitle,
                          value: _termsOfUseChecked.value,
                          onChanged: (bool? checked) {
                            _termsOfUseChecked.value = checked ?? false;
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
                                      final Uri url = Uri.parse(Strings.termsOfUseUrl);

                                      await launchUrl(url);
                                    },
                                ),
                              ],
                            ),
                          ),
                          activeText: true,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  renderIfMobile(
                    const MobileOnboardingProgressBar(currStep: 2),
                  ),
                  ConfirmationButton(
                    text: Strings.done,
                    disabled: !_atLeast8Chars.value ||
                        !_passwordsMatch.value ||
                        !_termsOfUseChecked.value,
                    onPressed: () async {
                      context.loaderOverlay.show();
                      await onboardingNotifier.createPassword(
                          password: _newPasswordController.value.text);
                      context.loaderOverlay.hide();
                      navigateToRoute(context, Routes.walletInfoChecklist);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NewPasswordSection extends StatelessWidget {
  final TextEditingController textEditingController;
  final bool atLeast8Chars;
  const _NewPasswordSection({
    required this.textEditingController,
    required this.atLeast8Chars,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
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
            // focusNode: _newPasswordFocus,
            width: kIsWeb ? 350 : adaptWidth(0.9),
            fillColor: RibnColors.whiteButtonShadow,
            controller: textEditingController,
            hintText: '',
            obscurePassword: true,
            textInputAction: TextInputAction.next,
          ),
        ),
        const SizedBox(height: 8),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            Strings.atLeast8Chars,
            textAlign: TextAlign.left,
            style: RibnToolkitTextStyles.h3.copyWith(
              color: !atLeast8Chars && textEditingController.text.isNotEmpty
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
}

class _ConfirmPasswordSection extends StatelessWidget {
  final TextEditingController textEditingController;
  final bool passwordsMatch;

  const _ConfirmPasswordSection({
    required this.textEditingController,
    required this.passwordsMatch,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            // focusNode: _confirmPasswordFocus,
            width: kIsWeb ? 350 : adaptWidth(0.9),
            fillColor: RibnColors.whiteButtonShadow,
            controller: textEditingController,
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
              color: !passwordsMatch && textEditingController.value.text.isNotEmpty
                  ? Colors.red
                  : Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
