import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ribn/constants/assets.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/containers/poly_transfer_input_container.dart';
import 'package:ribn/presentation/transfers/transfer_utils.dart';
import 'package:ribn/presentation/transfers/widgets/custom_input_field.dart';
import 'package:ribn/presentation/transfers/widgets/from_address_field.dart';
import 'package:ribn/utils.dart';
import 'package:ribn/widgets/address_display_container.dart';
import 'package:ribn/widgets/fee_info.dart';
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn_toolkit/constants/styles.dart';
import 'package:ribn_toolkit/widgets/atoms/custom_page_title.dart';
import 'package:ribn_toolkit/widgets/atoms/custom_text_field.dart';
import 'package:ribn_toolkit/widgets/atoms/large_button.dart';
import 'package:ribn_toolkit/widgets/molecules/loading_spinner.dart';
import 'package:ribn_toolkit/widgets/molecules/note_field.dart';
import 'package:ribn_toolkit/widgets/molecules/recipient_field.dart';

/// The input page that allows initiating poly transfer transaction.
///
/// Builds the necessary input fields needed for a poly transfer.
class PolyTransferInputPage extends StatefulWidget {
  const PolyTransferInputPage({Key? key}) : super(key: key);

  @override
  _PolyTransferInputPageState createState() => _PolyTransferInputPageState();
}

class _PolyTransferInputPageState extends State<PolyTransferInputPage> {
  final TextEditingController _noteController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _recipientController = TextEditingController();
  late List<TextEditingController> _controllers;
  final GlobalKey _formKey = GlobalKey<FormState>();

  /// Assigned the valid recipient address
  String _validRecipientAddress = '';

  /// True if currently loading raw tx creation.
  bool _loadingRawTx = false;

  /// True if amount is valid.
  bool _validAmount = false;

  @override
  void initState() {
    _controllers = [
      _noteController,
      _amountController,
      _recipientController,
    ];

    // initialize listeners for each of the TextEditingControllers
    _controllers.forEach(initListener);
    super.initState();
  }

  @override
  void dispose() {
    _controllers.forEach(disposeController);
    super.dispose();
  }

  initListener(TextEditingController controller) {
    controller.addListener(() {
      setState(() {});
    });
  }

  disposeController(TextEditingController controller) {
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PolyTransferInputContainer(
      builder: (BuildContext context, PolyTransferInputViewModel vm) {
        return Scaffold(
          backgroundColor: RibnColors.background,
          body: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    // page title
                    const CustomPageTitle(title: Strings.sendAssets),
                    const SizedBox(height: 30),
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
                            _buildAmountField(),
                            // field for displaying the sender addresss
                            const FromAddressField(),
                            // field for entering the recipient address
                            RecipientField(
                              controller: _recipientController,
                              validRecipientAddress: _validRecipientAddress,
                              // validate the address entered on text change
                              onChanged: (text) => validateRecipientAddress(
                                networkName: vm.currentNetwork.networkName,
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
                                      ..selection = TextSelection.collapsed(offset: _recipientController.text.length);
                                  }
                                  _validRecipientAddress = '';
                                });
                              },
                              icon: SvgPicture.asset(RibnAssets.recipientFingerprint),
                              alternativeDisplayChild: const AddressDisplayContainer(
                                text: Strings.yourRibnWalletAddress,
                                icon: RibnAssets.myFingerprint,
                                width: 300,
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
                            // fee info for the tx
                            FeeInfo(fee: vm.networkFee),
                            _buildReviewButton(vm),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              _loadingRawTx ? const LoadingSpinner() : const SizedBox(),
            ],
          ),
        );
      },
    );
  }

  /// Builds the UI for indicating poly transfer.
  Widget _buildPolyDisplay() {
    return CustomInputField(
      itemLabel: Strings.youSend,
      item: Container(
        width: 310,
        height: 36,
        decoration: const BoxDecoration(
          color: RibnColors.whiteBackground,
          borderRadius: BorderRadius.all(
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
  Widget _buildAmountField() {
    return CustomInputField(
      itemLabel: Strings.amount,
      item: CustomTextField(
        width: 310,
        height: 36,
        controller: _amountController,
        hintText: Strings.amountHint,
      ),
    );
  }

  /// Builds the review button to initate tx.
  Widget _buildReviewButton(PolyTransferInputViewModel vm) {
    final bool enteredValidInputs =
        _validRecipientAddress.isNotEmpty && _amountController.text.isNotEmpty && _validAmount;
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, bottom: 10),
      child: LargeButton(
        buttonChild: Text(
          Strings.review,
          style: RibnToolkitTextStyles.btnMedium.copyWith(
            color: Colors.white,
          ),
        ),
        onPressed: enteredValidInputs
            ? () {
                setState(() {
                  _loadingRawTx = true;
                });
                vm.initiateTx(
                  amount: _amountController.text,
                  recipient: _validRecipientAddress,
                  note: _noteController.text,
                  onRawTxCreated: (bool success) async {
                    _loadingRawTx = false;
                    setState(() {});
                    // Display error dialog if failed to create raw tx
                    if (!success) {
                      await TransferUtils.showErrorDialog(context);
                    }
                  },
                );
              }
            : null,
      ),
    );
  }
}
