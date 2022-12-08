import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ribn/actions/restore_wallet_actions.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/models/app_state.dart';
import 'package:ribn/presentation/onboarding/utils.dart';
import 'package:ribn/presentation/onboarding/widgets/confirmation_button.dart';
import 'package:ribn/presentation/onboarding/widgets/onboarding_container.dart';
import 'package:ribn/presentation/onboarding/widgets/warning_section.dart';
import 'package:ribn/presentation/onboarding/widgets/web_onboarding_app_bar.dart';
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn_toolkit/widgets/atoms/text/ribn_font12_text_widget.dart';
import 'package:ribn_toolkit/widgets/atoms/text/ribn_h3_text_widget.dart';
import 'package:ribn_toolkit/widgets/atoms/text/ribn_onboarding_h1_text_widget.dart';
import 'package:ribn_toolkit/widgets/molecules/password_text_field.dart';

/// Allows the user to enter their wallet password to decrypt the Topl Key in [toplKeyStoreJson].
class EnterWalletPasswordPage extends StatefulWidget {
  final String toplKeyStoreJson;

  const EnterWalletPasswordPage({
    required this.toplKeyStoreJson,
    Key? key,
  }) : super(key: key);

  @override
  _EnterWalletPasswordPageState createState() =>
      _EnterWalletPasswordPageState();
}

class _EnterWalletPasswordPageState extends State<EnterWalletPasswordPage> {
  final double maxWidth = 734;
  final TextEditingController _passwordController = TextEditingController();
  bool _failedToRestoreWallet = false;

  @override
  void initState() {
    _passwordController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OnboardingContainer(
        child: SingleChildScrollView(
          child: Column(
            children: [
              renderIfWeb(const WebOnboardingAppBar(currStep: 1, numSteps: 2)),
              const RibnOnboardingH1TextWidget(
                text: Strings.restoreWallet,
                textAlignment: TextAlign.center,
                textColor: RibnColors.lightGreyTitle,
              ),
              // warning section
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 24.0),
                child: WarningSection(),
              ),
              _buildEnterWalletPassword(),

              const SizedBox(height: 50),
              ConfirmationButton(
                text: Strings.next,
                onPressed: () async {
                  final Completer<bool> actionCompleter = Completer();
                  StoreProvider.of<AppState>(context).dispatch(
                    RestoreWalletWithToplKeyAction(
                      toplKeyStoreJson: widget.toplKeyStoreJson,
                      password: _passwordController.text,
                      completer: actionCompleter,
                    ),
                  );
                  await actionCompleter.future.then((value) {
                    setState(() {
                      _failedToRestoreWallet = !value;
                    });
                  });
                },
              ),
              const SizedBox(height: 10),
              _failedToRestoreWallet
                  ? const RibnFont12TextWidget(
                      text: Strings.failedToRestoreWallet,
                      textAlignment: TextAlign.justify,
                      textColor: RibnColors.redColor,
                      fontWeight: FontWeight.normal,
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEnterWalletPassword() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const RibnH3TextWidget(
          text: Strings.enterWalletPassword,
          textAlignment: TextAlign.justify,
          textColor: RibnColors.lightGreyTitle,
          fontWeight: FontWeight.bold,
        ),
        PasswordTextField(
          controller: _passwordController,
          hintText: Strings.newWalletPassword,
          fillColor: RibnColors.whiteButtonShadow,
          width: 509,
          obscurePassword: true,
        ),
      ],
    );
  }
}
