import 'package:flutter/material.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn_toolkit/widgets/atoms/large_button.dart';
import 'package:ribn_toolkit/widgets/atoms/text/ribn_font14_text_widget.dart';
import 'package:ribn_toolkit/widgets/atoms/text/ribn_font15_text_widget.dart';
import 'package:ribn_toolkit/widgets/atoms/text/ribn_h2_text_widget.dart';
import 'package:ribn_toolkit/widgets/molecules/custom_modal.dart';
import 'package:ribn_toolkit/widgets/molecules/password_text_field.dart';

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
      {required this.onConfirmDeletePressed, Key? key,})
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
      title: const RibnH2TextWidget(
        text: Strings.deleteRibnWallet,
        textAlignment: TextAlign.justify,
        textColor: RibnColors.defaultText,
        fontWeight: FontWeight.bold,
      ),
      context: context,
      body: Column(
        children: [
          const SizedBox(
            width: 228,
            height: 125,
            child: RibnFont15TextWidget(
                text: Strings.deleteRibnWalletDesc,
                textAlignment: TextAlign.justify,
                textColor: RibnColors.defaultText,
                fontWeight: FontWeight.w300,),
          ),
          const SizedBox(height: 30),
          // enter password
          SizedBox(
            width: 285,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const RibnFont15TextWidget(
                    text: Strings.enterWalletPassword,
                    textAlignment: TextAlign.justify,
                    textColor: RibnColors.defaultText,
                    fontWeight: FontWeight.w700,),
                PasswordTextField(
                  controller: _passwordController,
                  hintText: Strings.typeSomething,
                  obscurePassword: _obscurePassword,
                ),
                _incorrectPasswordError
                    ? const RibnFont14TextWidget(
                        text: 'Incorrect Password',
                        textAlignment: TextAlign.justify,
                        textColor: RibnColors.redColor,
                        fontWeight: FontWeight.normal,)
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
              buttonChild: const RibnFont14TextWidget(
                  text: Strings.yesIWantToDelete,
                  textAlignment: TextAlign.justify,
                  textColor: RibnColors.white,
                  fontWeight: FontWeight.w300,),
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
              buttonChild: const RibnFont14TextWidget(
                  text: Strings.noIChangedMyMind,
                  textAlignment: TextAlign.justify,
                  textColor: RibnColors.ghostButtonText,
                  fontWeight: FontWeight.w300,),
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
