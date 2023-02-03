// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Package imports:
import 'package:loader_overlay/loader_overlay.dart';
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
  const CreatePasswordPage({Key? key}) : super(key: key);

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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _termsOfUseChecked = useState(false);
    final _atLeast8Chars = useState(false);
    final _passwordsMatch = useState(false);

    // final FocusNode _newPasswordFocus = useFocusNode();
    // final FocusNode _confirmPasswordFocus = useFocusNode();
    final TextEditingController _newPasswordController = useTextEditingController();
    final TextEditingController _confirmPasswordController = useTextEditingController();

    return LoaderOverlay(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: OnboardingContainer(
          child: SingleChildScrollView(
            clipBehavior: Clip.none,
            child: Form(
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
                        ),
                        SizedBox(height: adaptHeight(0.02)),
                        _ConfirmPasswordSection(
                          textEditingController: _confirmPasswordController,
                          newPasswordTextEditingController: _newPasswordController,
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
                    onPressed: () {
                      context.loaderOverlay.show();

                      // QQQQ reimplement
                      // vm.attemptCreatePassword(_confirmPasswordController.text);
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
  const _NewPasswordSection({
    required this.textEditingController,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool _atLeast8Chars = textEditingController.text.length > 7;
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
              color: !_atLeast8Chars && textEditingController.text.isNotEmpty
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
  final TextEditingController newPasswordTextEditingController;

  const _ConfirmPasswordSection({
    required this.textEditingController,
    required this.newPasswordTextEditingController,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool _passwordsMatch =
        textEditingController.text == newPasswordTextEditingController.text;
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
              color: !_passwordsMatch && textEditingController.text.isNotEmpty
                  ? Colors.red
                  : Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
