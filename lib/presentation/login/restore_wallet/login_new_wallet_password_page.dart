import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ribn/actions/restore_wallet_actions.dart';
import 'package:ribn/constants/colors.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/constants/styles.dart';
import 'package:ribn/models/app_state.dart';
import 'package:ribn/presentation/login/widgets/next_button.dart';
import 'package:ribn/presentation/login/widgets/password_text_field.dart';
import 'package:ribn/presentation/login/widgets/restore_page_title.dart';
import 'package:ribn/presentation/login/widgets/warning_section.dart';

/// Page for creating a new wallet password, when restoring wallet with a [seedPhrase].
class NewWalletPasswordPage extends StatefulWidget {
  /// The seed phrase being used for wallet restoration.
  final String seedPhrase;

  const NewWalletPasswordPage({
    required this.seedPhrase,
    Key? key,
  }) : super(key: key);

  @override
  _NewWalletPasswordPageState createState() => _NewWalletPasswordPageState();
}

class _NewWalletPasswordPageState extends State<NewWalletPasswordPage> {
  /// Controllers for password textfields.
  final TextEditingController _newWalletPasswordController = TextEditingController();
  final TextEditingController _confirmWalletPasswordController = TextEditingController();

  /// True if the password entered is at least 8 characters.
  bool passwordAtLeast8Chars = false;

  /// True if both passwords match.
  bool passwordsMatch = false;

  /// Map to keep track of any textfield errors.
  Map<TextEditingController, bool> hasErrors = {};

  @override
  void initState() {
    // Initialize listeners for each controller.
    [_newWalletPasswordController, _confirmWalletPasswordController].toList().forEach((controller) {
      hasErrors[controller] = false;
      controller.addListener(() {
        setState(() {
          passwordAtLeast8Chars = _newWalletPasswordController.text.length >= 8;
          passwordsMatch = _newWalletPasswordController.text == _confirmWalletPasswordController.text;
        });
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    // Dispose listeners for each controller.
    [_newWalletPasswordController, _confirmWalletPasswordController].toList().forEach((controller) {
      controller.dispose();
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RibnColors.accent,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            // page title
            const RestoreWalletPageTitle(),
            // warning section
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 24.0),
              child: WarningSection(),
            ),
            // new wallet password
            SizedBox(
              width: 309,
              child: Text(Strings.newWalletPassword, style: RibnTextStyles.extH3.copyWith()),
            ),
            // enter new wallet password text field
            PasswordTextField(
              hintText: Strings.newWalletPasswordHint,
              controller: _newWalletPasswordController,
              hasError: hasErrors[_newWalletPasswordController] ?? false,
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 309,
              child: Text(Strings.confirmWalletPassword, style: RibnTextStyles.extH3.copyWith()),
            ),
            // confirm wallet password text field
            PasswordTextField(
              hintText: Strings.confirmWalletPasswordHint,
              controller: _confirmWalletPasswordController,
              hasError: hasErrors[_confirmWalletPasswordController] ?? false,
            ),
            const Spacer(),
            // Confirmation button
            NextButton(onPressed: onNextPressed),
          ],
        ),
      ),
    );
  }

  /// Handler for when [NextButton] is pressed.
  ///
  /// Validates that the password entered is at least 8 characters and both passwords match
  /// before attempting to restore wallet.
  void onNextPressed() {
    if (!passwordAtLeast8Chars) {
      hasErrors[_newWalletPasswordController] = true;
    } else if (!passwordsMatch) {
      hasErrors[_confirmWalletPasswordController] = true;
    } else {
      StoreProvider.of<AppState>(context).dispatch(
        RestoreWalletWithMnemonicAction(
          mnemonic: widget.seedPhrase,
          password: _confirmWalletPasswordController.text,
        ),
      );
    }
    setState(() {});
  }
}
