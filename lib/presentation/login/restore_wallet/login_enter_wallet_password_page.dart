import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ribn/actions/restore_wallet_actions.dart';
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/models/app_state.dart';
import 'package:ribn/presentation/login/widgets/next_button.dart';
import 'package:ribn/presentation/login/widgets/password_text_field.dart';
import 'package:ribn/presentation/login/widgets/restore_page_title.dart';
import 'package:ribn/presentation/login/widgets/warning_section.dart';

/// Allows the user to enter their wallet password to decrypt the Topl Key in [toplKeyStoreJson].
class LoginEnterWalletPasswordPage extends StatefulWidget {
  final String toplKeyStoreJson;

  const LoginEnterWalletPasswordPage({
    required this.toplKeyStoreJson,
    Key? key,
  }) : super(key: key);

  @override
  _LoginEnterWalletPasswordPageState createState() => _LoginEnterWalletPasswordPageState();
}

class _LoginEnterWalletPasswordPageState extends State<LoginEnterWalletPasswordPage> {
  final double maxWidth = 309;
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
      backgroundColor: RibnColors.accent,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              // page title
              const RestoreWalletPageTitle(),
              const SizedBox(height: 30),
              SizedBox(
                width: maxWidth,
                height: 50,
                child: const Text(
                  'Now, enter your Wallet Password to recover your Ribn wallet!',
                  style: TextStyle(
                    fontFamily: 'DM Sans',
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              // warning section
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 24.0),
                child: WarningSection(),
              ),
              SizedBox(
                width: maxWidth,
                child: const Text(
                  Strings.enterWalletPassword,
                  style: TextStyle(
                    fontFamily: 'DM Sans',
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              PasswordTextField(
                controller: _passwordController,
                hintText: Strings.newWalletPasswordHint,
              ),
              _failedToRestoreWallet
                  ? const Text(
                      'Failed to restore wallet.',
                      style: TextStyle(color: Colors.red),
                    )
                  : const SizedBox(),
              NextButton(
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
            ],
          ),
        ),
      ),
    );
  }
}
