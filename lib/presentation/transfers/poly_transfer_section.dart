// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

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
class PolyTransferSection extends HookWidget {
  PolyTransferInputViewModel vm;
  final Function updateButton;

  PolyTransferSection({
    required this.vm,
    required this.updateButton,
    Key? key,
  }) : super(key: key);

  final GlobalKey _formKey = GlobalKey<FormState>();

  // @override
  // void initState() {
  //   // initialize listeners for each of the TextEditingControllers
  //   renderBottomButton();
  // }

  // initListener(TextEditingController controller) {
  //   controller.addListener(() {
  //     renderBottomButton();
  //   });
  // }

  // TODO, Update this so that it's not causing a render in another widget
  void renderBottomButton({
    required TextEditingController amountController,
    required TextEditingController noteController,
    required String recipientAddress,
  }) {
    return WidgetsBinding.instance.addPostFrameCallback((_) {
      updateButton(
        BottomReviewAction(
          maxHeight: kIsWeb ? 120 : 143,
          children: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // fee info for the tx
              FeeInfo(fee: vm.networkFee),
              _ReviewButton(
                vm: vm,
                amountController: amountController,
                noteController: noteController,
                recipientAddress: recipientAddress,
              ),
            ],
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController _noteController = useTextEditingController();
    final TextEditingController _amountController = useTextEditingController();
    final TextEditingController _recipientController = useTextEditingController();

    /// Assigned the valid recipient address
    final _validRecipientAddress = useState('');

    useEffect(() {
      renderBottomButton(
        amountController: _amountController,
        noteController: _noteController,
        recipientAddress: _validRecipientAddress.value,
      );
    }, []);

    /// True if amount is valid.
    // ignore: prefer_final_fields
    // QQQQ probably delete
    // final _validAmount = useState(false);

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
                _PolyDisplay(),
                // field for entering amount of polys needed for transfer
                _AmountField(
                  vm: vm,
                  amountController: _amountController,
                ),
                // field for displaying the sender addresss
                const FromAddressField(),
                // field for entering the recipient address
                RecipientField(
                  controller: _recipientController,
                  validRecipientAddress: _validRecipientAddress.value,
                  // validate the address entered on text change
                  onChanged: (text) => validateRecipientAddress(
                    networkName: vm.currentNetwork.networkName,
                    address: _recipientController.text,
                    handleResult: (bool result) {
                      if (result) {
                        _validRecipientAddress.value = _recipientController.text;
                        _recipientController.text = '';
                      } else {
                        _validRecipientAddress.value = '';
                      }
                    },
                  ),
                  onBackspacePressed: () {
                    if (_validRecipientAddress.value.isNotEmpty) {
                      _recipientController.text = _validRecipientAddress.value;
                      _recipientController
                        ..text =
                            _recipientController.text.substring(0, _recipientController.text.length)
                        ..selection = TextSelection.collapsed(
                          offset: _recipientController.text.length,
                        );
                    }
                    _validRecipientAddress.value = '';
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
}

/// Builds the UI for indicating poly transfer.
class _PolyDisplay extends StatelessWidget {
  const _PolyDisplay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
}

/// Builds the TextField for entering amount needed for the transfer.
class _AmountField extends StatelessWidget {
  final TextEditingController amountController;
  final PolyTransferInputViewModel vm;
  const _AmountField({
    required this.vm,
    required this.amountController,
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    print('QQQQ vm ${vm.maxTransferrableAmount}');

    bool _validAmount = TransferUtils.validateAmount(
      amountController.value.text,
      vm.maxTransferrableAmount,
    );

    return CustomInputField(
      itemLabel: Strings.amount,
      item: CustomTextField(
        width: 310,
        height: 36,
        controller: amountController,
        hintText: Strings.amountHint,
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        hasError: !_validAmount,

        // QQQQ probably remove
        // onChanged: (String amount) {
        //   _validAmount = TransferUtils.validateAmount(
        //     amount,
        //     vm.maxTransferrableAmount,
        //   );
        // },
      ),
    );
  }
}

class _ReviewButton extends StatelessWidget {
  final TextEditingController amountController;
  final PolyTransferInputViewModel vm;
  final String recipientAddress;
  final TextEditingController noteController;
  const _ReviewButton({
    required this.vm,
    required this.amountController,
    required this.recipientAddress,
    required this.noteController,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _validAmount = TransferUtils.validateAmount(
      amountController.value.text,
      vm.maxTransferrableAmount,
    );
    final bool enteredValidInputs =
        recipientAddress.isNotEmpty && amountController.text.isNotEmpty && _validAmount;

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
                    amount: amountController.text,
                    recipient: recipientAddress,
                    note: noteController.text,
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
