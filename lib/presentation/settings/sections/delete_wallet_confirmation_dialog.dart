import 'package:flutter/material.dart';
import 'package:ribn/constants/colors.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/constants/styles.dart';
import 'package:ribn/presentation/login/widgets/password_text_field.dart';
import 'package:ribn/widgets/custom_close_button.dart';
import 'package:ribn_toolkit/widgets/atoms/large_button.dart';

/// The confimation dialog that is displayed before deleting the wallet.
///
/// The user is prompted to enter their wallet password before confirming deletion.
class DeleteWalletConfirmationDialog extends StatefulWidget {
  /// Handler for when user confirms wallet deletion.
  final void Function(
    String password,
    VoidCallback onIncorrectPasswordEntered,
  ) onConfirmDeletePressed;

  const DeleteWalletConfirmationDialog({required this.onConfirmDeletePressed, Key? key}) : super(key: key);

  @override
  _DeleteWalletConfirmationDialogState createState() => _DeleteWalletConfirmationDialogState();
}

class _DeleteWalletConfirmationDialogState extends State<DeleteWalletConfirmationDialog> {
  final TextEditingController _passwordController = TextEditingController();

  /// True if incorrect password was entered.
  bool _incorrectPasswordError = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 65),
      backgroundColor: RibnColors.accent,
      titlePadding: EdgeInsets.zero,
      scrollable: true,
      title: Stack(
        children: [
          // top-right close button
          const Positioned(
            top: 18,
            right: 14,
            child: CustomCloseButton(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Column(
              children: [
                const SizedBox(height: 30),
                // dialog title
                const SizedBox(
                  width: 228,
                  height: 26,
                  child: Text(
                    Strings.deleteRibnWallet,
                    style: RibnTextStyles.extH2,
                  ),
                ),
                const SizedBox(height: 25),
                // description
                SizedBox(
                  width: 228,
                  height: 125,
                  child: Text(
                    Strings.deleteRibnWalletDesc,
                    style: RibnTextStyles.smallBody.copyWith(fontSize: 15),
                  ),
                ),
                const SizedBox(height: 15),
                // enter password
                SizedBox(
                  width: 285,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        Strings.enterWalletPassword,
                        style: TextStyle(
                          fontFamily: 'Spectral',
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      PasswordTextField(
                        controller: _passwordController,
                        hintText: Strings.typeSomething,
                      ),
                      _incorrectPasswordError
                          ? const Text('Incorrect Password', style: TextStyle(color: Colors.red))
                          : const SizedBox()
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                // cancel delete
                LargeButton(
                  label: Strings.noIChangedMyMind,
                  backgroundColor: RibnColors.primary.withOpacity(0.19),
                  textColor: RibnColors.primary,
                  onPressed: () => Navigator.of(context).pop(),
                  buttonWidth: 285,
                ),
                const SizedBox(height: 10),
                // confirm delete
                LargeButton(
                  label: Strings.yesIWantToDelete,
                  onPressed: () {
                    widget.onConfirmDeletePressed(
                      _passwordController.text,
                      () {
                        setState(() {
                          _incorrectPasswordError = true;
                        });
                      },
                    );
                  },
                  buttonWidth: 285,
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
