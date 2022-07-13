import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ribn/constants/assets.dart';
import 'package:ribn/constants/colors.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/presentation/transfers/widgets/custom_input_field.dart';
import 'package:ribn/presentation/transfers/widgets/error_bubble.dart';
import 'package:ribn/utils.dart';
import 'package:ribn/widgets/address_display_container.dart';
import 'package:ribn/widgets/custom_text_field.dart';

/// An input field used on the input transfer pages.
///
/// Allows the user to enter a recipient address.
class RecipientField extends StatefulWidget {
  /// Controller for the recipient textfield.
  final TextEditingController controller;

  /// Holds the recipient address if valid.
  final String validRecipientAddress;

  /// True if minting to own wallet.
  final bool mintingToMyWallet;

  /// Handler for when the text changes.
  final Function(String)? onChanged;

  /// Handler for when backspace is pressed.
  final Function onBackspacePressed;

  const RecipientField({
    Key? key,
    required this.controller,
    required this.validRecipientAddress,
    this.mintingToMyWallet = false,
    this.onChanged,
    required this.onBackspacePressed,
  }) : super(key: key);

  bool isValidRecipient() => validRecipientAddress.isNotEmpty;

  bool isTextFieldEmpty() => controller.text.isEmpty;

  @override
  _RecipientFieldState createState() => _RecipientFieldState();
}

class _RecipientFieldState extends State<RecipientField> {
  /// True if the recipient entered is invalid.
  bool hasError = false;

  /// True if error bubble needs to be displayed.
  bool displayErrorBubble = false;

  /// Timer for displaying the error message bubble.
  Timer? errorTimer;

  @override
  void dispose() {
    errorTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      builder: (FormFieldState<String> formFieldState) => CustomInputField(
        itemLabel: Strings.to,
        item: widget.mintingToMyWallet
            ? const AddressDisplayContainer(
                text: Strings.yourRibnWalletAddress,
                icon: RibnAssets.myFingerprint,
              )
            : Stack(
                children: [
                  Focus(
                    onFocusChange: handleFocusChange,
                    onKey: (focusNode, rawKeyEvent) {
                      // listen for backspace and call handler
                      if (rawKeyEvent.isKeyPressed(LogicalKeyboardKey.backspace)) {
                        widget.onBackspacePressed();
                      }
                      return KeyEventResult.ignored;
                    },
                    child: PortalEntry(
                      visible: displayErrorBubble,
                      child: CustomTextField(
                        controller: widget.controller,
                        hintText: Strings.assetTransferToHint,
                        onChanged: widget.onChanged,
                        showCursor: !widget.isValidRecipient(),
                        hasError: hasError,
                      ),
                      portal: const ErrorBubble(
                        errorText: Strings.invalidRecipientAddressError,
                      ),
                      portalAnchor: Alignment.topLeft,
                      childAnchor: Alignment.bottomLeft,
                    ),
                  ),
                  widget.isValidRecipient() ? _buildValidAddressDisplay() : const SizedBox(),
                ],
              ),
      ),
    );
  }

  /// Builds a custom display for a valid address in the recipient field.
  Widget _buildValidAddressDisplay() {
    return Positioned(
      top: 3,
      left: 3,
      child: Container(
        width: 205,
        height: 23,
        decoration: BoxDecoration(
          color: const Color(0xffefefef),
          borderRadius: BorderRadius.circular(11),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 4.0, right: 7),
              child: SizedBox(width: 19, height: 19, child: SvgPicture.asset(RibnAssets.recipientFingerprint)),
            ),
            Text(
              formatAddrString(widget.validRecipientAddress),
              style: const TextStyle(
                fontFamily: 'Nunito',
                fontSize: 12,
                color: RibnColors.defaultText,
              ),
            )
          ],
        ),
      ),
    );
  }

  /// Handler for when focus is lost from the textfield.
  ///
  /// If the textfield has an invalid address at the time of losing focus,
  /// the error message is displayed.
  void handleFocusChange(bool gotFocus) {
    final bool invalidAddressEntered = !widget.isTextFieldEmpty() && !widget.isValidRecipient();
    // if focus is lost and a invalid address entered
    if (!gotFocus && invalidAddressEntered) {
      setState(() {
        hasError = true;
        displayErrorBubble = true;
      });
      errorTimer = Timer(const Duration(seconds: 3), () {
        setState(() {
          displayErrorBubble = false;
        });
      });
    } else {
      setState(() {
        hasError = false;
        displayErrorBubble = false;
        errorTimer?.cancel();
      });
    }
  }
}
