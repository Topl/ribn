import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ribn/actions/restore_wallet_actions.dart';
import 'package:ribn/models/app_state.dart';
import 'package:ribn/models/ui_state.dart';
import 'package:ribn/presentation/login/widgets/next_button.dart';
import 'package:ribn/presentation/login/widgets/password_text_field.dart';
import 'package:ribn/presentation/login/widgets/restore_page_title.dart';
import 'package:ribn/presentation/login/widgets/warning_section.dart';

/// Allows the user to enter their 'old' password to decrypt the Topl Key in [toplKeyStoreJson].
class OldPasswordPage extends StatefulWidget {
  final String toplKeyStoreJson;

  const OldPasswordPage({
    required this.toplKeyStoreJson,
    Key? key,
  }) : super(key: key);

  @override
  _OldPasswordPageState createState() => _OldPasswordPageState();
}

class _OldPasswordPageState extends State<OldPasswordPage> {
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    _passwordController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, UiState>(
      converter: (store) => store.state.uiState,
      builder: (context, vm) => Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              // page title
              const RestoreWalletPageTitle(currPage: 2),
              // warning section
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 24.0),
                child: WarningSection(),
              ),
              const Text('Old password'),
              PasswordTextField(
                controller: _passwordController,
                hintText: 'Old wallet password',
              ),
              vm.failedToRestoreWallet
                  ? const Text(
                      'Failed to restore wallet.',
                      style: TextStyle(color: Colors.red),
                    )
                  : const SizedBox(),

              NextButton(
                onPressed: () {
                  StoreProvider.of<AppState>(context).dispatch(
                    RestoreWalletWithToplKeyAction(
                      toplKeyStoreJson: widget.toplKeyStoreJson,
                      password: _passwordController.text,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
