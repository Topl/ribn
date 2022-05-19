import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ribn/actions/restore_wallet_actions.dart';
import 'package:ribn/constants/assets.dart';
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn_toolkit/constants/styles.dart';
import 'package:ribn/models/app_state.dart';
import 'package:ribn/presentation/login/widgets/restore_page_title.dart';
import 'package:ribn/presentation/login/widgets/warning_section.dart';
import 'package:ribn_toolkit/widgets/atoms/large_button.dart';
import 'package:ribn_toolkit/widgets/molecules/password_text_field.dart';

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

  /// True if the password entered is at least 12 characters.
  bool passwordAtLeast12Chars = false;

  /// True if both passwords match.
  bool passwordsMatch = false;

  /// Map to keep track of any textfield errors.
  Map<TextEditingController, bool> hasErrors = {};

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void initState() {
    // Initialize listeners for each controller.
    [_newWalletPasswordController, _confirmWalletPasswordController].toList().forEach((controller) {
      hasErrors[controller] = false;
      controller.addListener(() {
        setState(() {
          passwordAtLeast12Chars = _newWalletPasswordController.text.length >= 12;
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
              child: Text(Strings.newWalletPassword, style: RibnToolkitTextStyles.extH3.copyWith()),
            ),
            // enter new wallet password text field
            PasswordTextField(
              hintText: Strings.newWalletPasswordHint,
              controller: _newWalletPasswordController,
              hasError: hasErrors[_newWalletPasswordController] ?? false,
              icon: SvgPicture.asset(
                _obscurePassword ? RibnAssets.passwordVisibleIon : RibnAssets.passwordHiddenIcon,
                width: 20,
              ),
              obscurePassword: _obscurePassword,
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 309,
              child: Text(Strings.confirmWalletPassword, style: RibnToolkitTextStyles.extH3.copyWith()),
            ),
            // confirm wallet password text field
            PasswordTextField(
              hintText: Strings.confirmWalletPasswordHint,
              controller: _confirmWalletPasswordController,
              hasError: hasErrors[_confirmWalletPasswordController] ?? false,
              icon: SvgPicture.asset(
                _obscureConfirmPassword ? RibnAssets.passwordVisibleIon : RibnAssets.passwordHiddenIcon,
                width: 12,
              ),
              obscurePassword: _obscurePassword,
            ),
            const Spacer(),
            // Confirmation button
            LargeButton(
                buttonChild: Text(
                  Strings.next,
                  style: RibnToolkitTextStyles.btnMedium.copyWith(
                    color: Colors.white,
                  ),
                ),
                onPressed: onNextPressed),
          ],
        ),
      ),
    );
  }

  /// Handler for when [LargeButton] is pressed.
  ///
  /// Validates that the password entered is at least 8 characters and both passwords match
  /// before attempting to restore wallet.
  void onNextPressed() {
    if (!passwordAtLeast12Chars) {
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
