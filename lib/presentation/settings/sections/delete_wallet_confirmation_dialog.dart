// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn_toolkit/constants/styles.dart';
import 'package:ribn_toolkit/widgets/atoms/large_button.dart';
import 'package:ribn_toolkit/widgets/molecules/custom_modal.dart';
import 'package:ribn_toolkit/widgets/molecules/password_text_field.dart';

// Project imports:
import 'package:ribn/constants/strings.dart';

/// The confimation dialog that is displayed before deleting the wallet.
///
/// The user is prompted to enter their wallet password before confirming deletion.
class DeleteWalletConfirmationDialog extends StatefulWidget {
  /// Handler for when user confirms wallet deletion.
  final void Function(
    String password,
    VoidCallback onIncorrectPasswordEntered,
  ) onConfirmDeletePressed;

  const DeleteWalletConfirmationDialog(
      {required this.onConfirmDeletePressed, Key? key})
      : super(key: key);

  @override
  _DeleteWalletConfirmationDialogState createState() =>
      _DeleteWalletConfirmationDialogState();
}

class _DeleteWalletConfirmationDialogState
    extends State<DeleteWalletConfirmationDialog> {
  final TextEditingController _passwordController = TextEditingController();

  /// True if incorrect password was entered.
  bool _incorrectPasswordError = false;

  final bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return CustomModal.renderCustomModal(
      title: const Text(
        Strings.deleteRibnWallet,
        style: RibnToolkitTextStyles.extH2,
      ),
      context: context,
      body: Column(
        children: [
          SizedBox(
            width: 228,
            height: 125,
            child: Text(
              Strings.deleteRibnWalletDesc,
              style: RibnToolkitTextStyles.smallBody.copyWith(fontSize: 15),
            ),
          ),
          const SizedBox(height: 30),
          // enter password
          SizedBox(
            width: 285,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  Strings.enterWalletPassword,
                  style: TextStyle(
                    fontFamily: 'DM Sans',
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                PasswordTextField(
                  controller: _passwordController,
                  hintText: Strings.typeSomething,
                  obscurePassword: _obscurePassword,
                ),
                _incorrectPasswordError
                    ? const Text('Incorrect Password',
                        style: TextStyle(color: Colors.red))
                    : const SizedBox()
              ],
            ),
          ),
        ],
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        Column(
          children: [
            // confirm delete
            LargeButton(
              buttonChild: Text(
                Strings.yesIWantToDelete,
                style: RibnToolkitTextStyles.btnMedium.copyWith(
                  color: Colors.white,
                ),
              ),
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
            // cancel delete
            LargeButton(
              buttonChild: Text(
                Strings.noIChangedMyMind,
                style: RibnToolkitTextStyles.btnMedium.copyWith(
                  color: RibnColors.ghostButtonText,
                ),
              ),
              backgroundColor: Colors.transparent,
              hoverColor: Colors.transparent,
              dropShadowColor: Colors.transparent,
              borderColor: RibnColors.ghostButtonText,
              onPressed: () => Navigator.of(context).pop(),
              buttonWidth: 285,
            ),
          ],
        )
      ],
    );
  }
}
