import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ribn/constants/assets.dart';
import 'package:ribn/constants/routes.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/containers/create_password_container.dart';
import 'package:ribn/presentation/onboarding/mobile/helpers.dart';
import 'package:ribn/presentation/onboarding/mobile/widgets/check_box.dart';
import 'package:ribn/presentation/onboarding/mobile/widgets/confirmation_button.dart';
import 'package:ribn/presentation/onboarding/mobile/widgets/onboarding_container.dart';
import 'package:ribn/presentation/onboarding/mobile/widgets/onboarding_page_padding.dart';
import 'package:ribn/presentation/onboarding/mobile/widgets/password_text_field.dart';
import 'package:ribn/utils.dart';
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn_toolkit/constants/styles.dart';
import 'package:url_launcher/url_launcher.dart';

class CreatePasswordPageMobile extends StatefulWidget {
  const CreatePasswordPageMobile({Key? key}) : super(key: key);

  @override
  _CreatePasswordPageMobileState createState() => _CreatePasswordPageMobileState();
}

class _CreatePasswordPageMobileState extends State<CreatePasswordPageMobile> {
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  bool termsOfUseChecked = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CreatePasswordContainer(
      onDidChange: (_, vm) {
        if (vm.passwordSuccessfullyCreated) navigateToRoute(context, Routes.walletInfoChecklist);
      },
      builder: (context, vm) => Scaffold(
        resizeToAvoidBottomInset: true,
        body: OnboardingContainer(
          child: OnboardingPagePadding(
            child: SingleChildScrollView(
              clipBehavior: Clip.none,
              child: Column(
                children: [
                  Text(
                    Strings.createWalletPassword,
                    style: onboardingH1,
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: adaptHeight(0.01)),
                    child: Image.asset(
                      RibnAssets.createWalletPng,
                      width: 100,
                    ),
                  ),
                  SizedBox(
                    width: adaptWidth(0.9),
                    child: Text(
                      Strings.createWalletPasswordDesc,
                      style: onboardingH3,
                    ),
                  ),
                  SizedBox(height: adaptHeight(0.02)),
                  _buildNewPasswordSection(),
                  SizedBox(height: adaptHeight(0.02)),
                  _buildConfirmPasswordSection(),
                  SizedBox(height: adaptHeight(0.02)),
                  CheckboxWrappableText(
                    wrapText: false,
                    borderColor: termsOfUseChecked ? const Color(0xff80FF00) : RibnColors.lightGreyTitle,
                    value: termsOfUseChecked,
                    onChanged: (bool? checked) {
                      setState(() {
                        termsOfUseChecked = checked ?? false;
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
                                await launch(Strings.termsOfUseUrl);
                              },
                          ),
                        ],
                      ),
                    ),
                    activeText: true,
                  ),
                  const SizedBox(height: 40),
                  ConfirmationButton(
                    text: Strings.done,
                    disabled: false,
                    onPressed: () {
                      vm.attemptCreatePassword(_confirmPasswordController.text);
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

  Widget _buildNewPasswordSection() {
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
        PasswordTextField2(
          width: adaptWidth(0.9),
          fillColor: RibnColors.whiteButtonShadow,
          controller: _newPasswordController,
          hintText: '',
          icon: SvgPicture.asset(RibnAssets.addIcon),
          obscurePassword: true,
        ),
        const SizedBox(height: 8),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            Strings.atLeast8Chars,
            textAlign: TextAlign.left,
            style: RibnToolkitTextStyles.h3.copyWith(
              color: Colors.white,
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
        PasswordTextField2(
          width: adaptWidth(0.9),
          fillColor: RibnColors.whiteButtonShadow,
          controller: _confirmPasswordController,
          hintText: '',
          icon: SvgPicture.asset(RibnAssets.addIcon),
          obscurePassword: true,
        ),
        const SizedBox(height: 8),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            Strings.passwordsMustMatch,
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
