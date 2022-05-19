import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ribn/constants/assets.dart';
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn_toolkit/constants/styles.dart';
import 'package:ribn_toolkit/widgets/atoms/custom_icon_button.dart';
import 'package:ribn_toolkit/widgets/atoms/large_button.dart';
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

  const DeleteWalletConfirmationDialog({required this.onConfirmDeletePressed, Key? key}) : super(key: key);

  @override
  _DeleteWalletConfirmationDialogState createState() => _DeleteWalletConfirmationDialogState();
}

class _DeleteWalletConfirmationDialogState extends State<DeleteWalletConfirmationDialog> {
  final TextEditingController _passwordController = TextEditingController();

  /// True if incorrect password was entered.
  bool _incorrectPasswordError = false;

  bool _obscurePassword = true;

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
          Positioned(
            top: 18,
            right: 14,
            child: CustomIconButton(
              icon: const Icon(
                Icons.close,
                color: Color(0xffb9b9b9),
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
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
                    style: RibnToolkitTextStyles.extH2,
                  ),
                ),
                const SizedBox(height: 25),
                // description
                SizedBox(
                  width: 228,
                  height: 125,
                  child: Text(
                    Strings.deleteRibnWalletDesc,
                    style: RibnToolkitTextStyles.smallBody.copyWith(fontSize: 15),
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
                          fontFamily: 'DM Sans',
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      PasswordTextField(
                        controller: _passwordController,
                        hintText: Strings.typeSomething,
                        icon: SvgPicture.asset(
                          _obscurePassword ? RibnAssets.passwordVisibleIon : RibnAssets.passwordHiddenIcon,
                          width: 12,
                        ),
                        obscurePassword: _obscurePassword,
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
                  buttonChild: Text(
                    Strings.noIChangedMyMind,
                    style: RibnToolkitTextStyles.btnMedium.copyWith(
                      color: RibnColors.primary,
                    ),
                  ),
                  backgroundColor: RibnColors.primary.withOpacity(0.19),
                  onPressed: () => Navigator.of(context).pop(),
                  buttonWidth: 285,
                ),
                const SizedBox(height: 10),
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
