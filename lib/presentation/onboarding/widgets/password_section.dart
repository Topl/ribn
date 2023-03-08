// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn_toolkit/constants/styles.dart';
import 'package:ribn_toolkit/widgets/molecules/checkbox_wrappable_text.dart';
import 'package:ribn_toolkit/widgets/molecules/password_text_field.dart';

// Project imports:
import 'package:ribn/constants/strings.dart';
import 'package:ribn/providers/password_provider.dart';
import 'package:ribn/utils.dart';
import 'package:ribn/utils/url_utils.dart';

class PasswordSection extends HookConsumerWidget {
  static const passwordSectionKey = Key('passwordSectionKey');
  static const newPasswordTextFieldKey = Key('newPasswordTextFieldKey');
  static const confirmPasswordTextFieldKey = Key('confirmPasswordTextFieldKey');
  static const termsOfAgreementCheckboxKey = Key('termsOfAgreementCheckboxKey');
  const PasswordSection({
    Key key = passwordSectionKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final passwordNotifier = ref.watch(passwordProvider.notifier);
    final passwordState = ref.watch(passwordProvider);

    final TextEditingController _newPasswordController = useTextEditingController();
    final TextEditingController _confirmPasswordController = useTextEditingController();

    /// Adds listeners to update provider
    /// You have to read inside useEffect, otherwise it will have a cached value of all inputs at widget load
    useEffect(() {
      _newPasswordController.addListener(
        () {
          final _passwordState = ref.read(passwordProvider);
          passwordNotifier.state = _passwordState.copyWith(password: _newPasswordController.text);
        },
      );
      _confirmPasswordController.addListener(
        () {
          final _passwordState = ref.read(passwordProvider);
          passwordNotifier.state = _passwordState.copyWith(confirmPassword: _confirmPasswordController.text);
        },
      );

      return () {};
    }, []);

    return Column(
      children: [
        _NewPasswordSection(
          textEditingController: _newPasswordController,
          atLeast8Chars: passwordState.atLeast8Chars,
          textFieldKey: newPasswordTextFieldKey,
        ),
        SizedBox(height: adaptHeight(0.02)),
        _ConfirmPasswordSection(
          textEditingController: _confirmPasswordController,
          passwordsMatch: passwordState.passwordsMatch,
          textFieldKey: confirmPasswordTextFieldKey,
        ),
        SizedBox(height: adaptHeight(0.02)),
        _TermsOfAgreementSection(
          termsOfUseChecked: passwordState.termsOfUseChecked,
          checkboxKey: termsOfAgreementCheckboxKey,
          updateTermsOfUseChecked: (val) {
            passwordNotifier.state = passwordState.copyWith(termsOfUseChecked: val);
          },
        ),
      ],
    );
  }
}

class _NewPasswordSection extends StatelessWidget {
  final TextEditingController textEditingController;
  final bool atLeast8Chars;
  final Key textFieldKey;
  const _NewPasswordSection({
    required this.textEditingController,
    required this.atLeast8Chars,
    required this.textFieldKey,
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
            key: textFieldKey,
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
              color: !atLeast8Chars && textEditingController.text.isNotEmpty ? Colors.red : Colors.white,
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
  final Key textFieldKey;

  const _ConfirmPasswordSection({
    required this.textEditingController,
    required this.passwordsMatch,
    required this.textFieldKey,
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
            key: textFieldKey,
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
              color: !passwordsMatch && textEditingController.value.text.isNotEmpty ? Colors.red : Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}

class _TermsOfAgreementSection extends HookConsumerWidget {
  final bool termsOfUseChecked;
  final Function(bool) updateTermsOfUseChecked;
  final Key checkboxKey;
  const _TermsOfAgreementSection({
    required this.termsOfUseChecked,
    required this.updateTermsOfUseChecked,
    required this.checkboxKey,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CheckboxWrappableText(
      checkboxKey: checkboxKey,
      wrapText: false,
      borderColor: termsOfUseChecked ? const Color(0xff80FF00) : RibnColors.lightGreyTitle,
      value: termsOfUseChecked,
      onChanged: (bool? checked) {
        updateTermsOfUseChecked(checked ?? false);
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
                  await launchTermsOfUse(ref);
                },
            ),
          ],
        ),
      ),
      activeText: true,
    );
  }
}
