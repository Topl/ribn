// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn_toolkit/constants/styles.dart';
import 'package:ribn_toolkit/widgets/atoms/custom_text_field.dart';
import 'package:ribn_toolkit/widgets/atoms/large_button.dart';
import 'package:ribn_toolkit/widgets/molecules/note_field.dart';
import 'package:ribn_toolkit/widgets/molecules/recipient_field.dart';

// Project imports:
import 'package:ribn/constants/assets.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/containers/poly_transfer_input_container.dart';
import 'package:ribn/presentation/transfers/bottom_review_action.dart';
import 'package:ribn/presentation/transfers/transfer_utils.dart';
import 'package:ribn/presentation/transfers/widgets/custom_input_field.dart';
import 'package:ribn/presentation/transfers/widgets/from_address_field.dart';
import 'package:ribn/utils.dart';
import 'package:ribn/widgets/address_display_container.dart';
import 'package:ribn/widgets/fee_info.dart';

/// The input page that allows initiating poly transfer transaction.
///
/// Builds the necessary input fields needed for a poly transfer.
// ignore: must_be_immutable
class PolyTransferSection extends StatefulWidget {
  PolyTransferInputViewModel vm;
  final Function updateButton;

  PolyTransferSection({
    required this.vm,
    required this.updateButton,
    Key? key,
  }) : super(key: key);

  @override
  _PolyTransferSectionState createState() => _PolyTransferSectionState();
}

class _PolyTransferSectionState extends State<PolyTransferSection> {
  final TextEditingController _noteController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _recipientController = TextEditingController();
  late List<TextEditingController> _controllers;
  final GlobalKey _formKey = GlobalKey<FormState>();

  /// Assigned the valid recipient address
  String _validRecipientAddress = '';

  /// True if amount is valid.
  // ignore: prefer_final_fields
  bool _validAmount = false;

  int currentTabIndex = 1;

  @override
  void initState() {
    _controllers = [
      _noteController,
      _amountController,
      _recipientController,
    ];

    // initialize listeners for each of the TextEditingControllers
    _controllers.forEach(initListener);
    renderBottomButton();
    super.initState();
  }

  @override
  void dispose() {
    _controllers.forEach(disposeController);
    super.dispose();
  }

  initListener(TextEditingController controller) {
    controller.addListener(() {
      renderBottomButton();
      setState(() {});
    });
  }

  disposeController(TextEditingController controller) {
    controller.dispose();
  }

  void renderBottomButton() {
    return WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.updateButton(
        BottomReviewAction(
          maxHeight: kIsWeb ? 120 : 143,
          children: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // fee info for the tx
              FeeInfo(fee: widget.vm.networkFee),
              _buildReviewButton(widget.vm),
            ],
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 310,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // UI to indicate poly transfer
                _buildPolyDisplay(),
                // field for entering amount of polys needed for transfer
                _buildAmountField(widget.vm),
                // field for displaying the sender addresss
                const FromAddressField(),
                // field for entering the recipient address
                RecipientField(
                  controller: _recipientController,
                  validRecipientAddress: _validRecipientAddress,
                  // validate the address entered on text change
                  onChanged: (text) => validateRecipientAddress(
                    networkName: widget.vm.currentNetwork.networkName,
                    address: _recipientController.text,
                    handleResult: (bool result) {
                      setState(() {
                        if (result) {
                          _validRecipientAddress = _recipientController.text;
                          _recipientController.text = '';
                        } else {
                          _validRecipientAddress = '';
                        }
                      });
                    },
                  ),
                  onBackspacePressed: () {
                    setState(() {
                      if (_validRecipientAddress.isNotEmpty) {
                        _recipientController.text = _validRecipientAddress;
                        _recipientController
                          ..text = _recipientController.text.substring(0, _recipientController.text.length)
                          ..selection = TextSelection.collapsed(
                            offset: _recipientController.text.length,
                          );
                      }
                      _validRecipientAddress = '';
                    });
                  },
                  icon: SvgPicture.asset(RibnAssets.recipientFingerprint),
                  alternativeDisplayChild: const AddressDisplayContainer(
                    text: Strings.yourRibnWalletAddress,
                    icon: RibnAssets.myFingerprint,
                    width: 250,
                  ),
                ),
                // field for adding a note to the tx
                NoteField(
                  controller: _noteController,
                  noteLength: _noteController.text.length,
                  tooltipIcon: Image.asset(
                    RibnAssets.greyHelpBubble,
                    width: 18,
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  /// Builds the UI for indicating poly transfer.
  Widget _buildPolyDisplay() {
    return CustomInputField(
      itemLabel: Strings.sending,
      item: Container(
        width: 310,
        height: 36,
        decoration: BoxDecoration(
          color: RibnColors.whiteBackground,
          border: Border.all(
            color: const Color(0xffE9E9E9),
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(4.7),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 7.0),
              child: Image.asset(RibnAssets.polysIcon),
            ),
            const Text('POLY'),
          ],
        ),
      ),
    );
  }

  /// Builds the TextField for entering amount needed for the transfer.
  Widget _buildAmountField(vm) {
    return CustomInputField(
      itemLabel: Strings.amount,
      item: CustomTextField(
        width: 310,
        height: 36,
        controller: _amountController,
        hintText: Strings.amountHint,
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        onChanged: (String amount) {
          setState(() {
            _validAmount = TransferUtils.validateAmount(
              amount,
              vm.maxTransferrableAmount,
            );
          });
        },
      ),
    );
  }

  Widget _buildReviewButton(PolyTransferInputViewModel vm) {
    final bool enteredValidInputs =
        _validRecipientAddress.isNotEmpty && _amountController.text.isNotEmpty && _validAmount;

    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: Center(
        child: LargeButton(
          buttonWidth: double.infinity,
          buttonChild: Text(
            Strings.review,
            style: RibnToolkitTextStyles.btnLarge.copyWith(
              color: Colors.white,
            ),
          ),
          onPressed: enteredValidInputs
              ? () {
                  context.loaderOverlay.show();
                  vm.initiateTx(
                    amount: _amountController.text,
                    recipient: _validRecipientAddress,
                    note: _noteController.text,
                    onRawTxCreated: (bool success) async {
                      context.loaderOverlay.hide();
                      // Display error dialog if failed to create raw tx
                      if (!success) {
                        await TransferUtils.showErrorDialog(context);
                      }
                    },
                  );
                }
              : () {},
          disabled: !enteredValidInputs,
        ),
      ),
    );
  }
}
