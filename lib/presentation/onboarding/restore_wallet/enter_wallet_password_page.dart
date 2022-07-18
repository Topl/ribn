import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ribn/actions/restore_wallet_actions.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/models/app_state.dart';
import 'package:ribn/presentation/onboarding/widgets/confirmation_button.dart';
import 'package:ribn/presentation/onboarding/widgets/onboarding_container.dart';
import 'package:ribn/presentation/onboarding/widgets/warning_section.dart';
import 'package:ribn/presentation/onboarding/widgets/web_onboarding_app_bar.dart';
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn_toolkit/constants/styles.dart';
import 'package:ribn_toolkit/widgets/molecules/password_text_field.dart';

/// Allows the user to enter their wallet password to decrypt the Topl Key in [toplKeyStoreJson].
class EnterWalletPasswordPage extends StatefulWidget {
  final String toplKeyStoreJson;

  const EnterWalletPasswordPage({
    required this.toplKeyStoreJson,
    Key? key,
  }) : super(key: key);

  @override
  _EnterWalletPasswordPageState createState() => _EnterWalletPasswordPageState();
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
              const WebOnboardingAppBar(),
              const Text(
                Strings.restoreWallet,
                style: RibnToolkitTextStyles.onboardingH1,
                textAlign: TextAlign.center,
              ),
              // warning section
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 24.0),
                child: WarningSection(),
              ),
              SizedBox(
                width: 370,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildEnterWalletPassword(),
                  ],
                ),
              ),

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
                  ? const Text(
                      'Failed to restore wallet.',
                      style: TextStyle(color: Colors.red),
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEnterWalletPassword() {
    return SizedBox(
      width: maxWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            Strings.enterWalletPassword,
            style: RibnToolkitTextStyles.h3.copyWith(
              fontWeight: FontWeight.bold,
              color: RibnColors.lightGreyTitle,
            ),
          ),
          PasswordTextField(
            controller: _passwordController,
            hintText: Strings.newWalletPasswordHint,
            fillColor: RibnColors.whiteButtonShadow,
            width: 352,
            obscurePassword: true,
          ),
        ],
      ),
    );
  }
}
