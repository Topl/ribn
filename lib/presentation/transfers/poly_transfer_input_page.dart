import 'package:brambldart/utils.dart';
import 'package:flutter/material.dart';
import 'package:ribn/constants/assets.dart';
import 'package:ribn/constants/colors.dart';
import 'package:ribn/constants/rules.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/containers/poly_transfer_input_container.dart';
import 'package:ribn/presentation/transfers/widgets/custom_input_field.dart';
import 'package:ribn/presentation/transfers/widgets/from_address_field.dart';
import 'package:ribn/presentation/transfers/widgets/note_field.dart';
import 'package:ribn/presentation/transfers/widgets/recipient_field.dart';
import 'package:ribn/widgets/custom_page_title.dart';
import 'package:ribn/widgets/custom_text_field.dart';
import 'package:ribn/widgets/fee_info.dart';
import 'package:ribn/widgets/large_button.dart';
import 'package:ribn/widgets/loading_spinner.dart';

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
          backgroundColor: RibnColors.accent,
          body: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    // page title
                    _buildPageTitle(),
                    const SizedBox(height: 30),
                    SizedBox(
                      width: 310,
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                // UI to indicate poly transfer
                                _buildPolyDisplay(),
                                const SizedBox(width: 20),
                                // field for entering amount of polys needed for transfer
                                _buildAmountField(),
                              ],
                            ),
                            // field for displaying the sender addresss
                            const FromAddressField(),
                            // field for entering the recipient address
                            RecipientField(
                              controller: _recipientController,
                              validRecipientAddress: _validRecipientAddress,
                              // validate the address entered on text change
                              onChanged: (text) => validateRecipientAddress(vm.currNetworkId),
                              // clear the textfield on backspace pressed
                              onBackspacePressed: () {
                                setState(() {
                                  _recipientController.clear();
                                  _validRecipientAddress = '';
                                });
                              },
                            ),
                            // field for adding a note to the tx
                            NoteField(
                              controller: _noteController,
                              noteLength: _noteController.text.length,
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
              vm.loadingRawTx ? const LoadingSpinner() : const SizedBox(),
            ],
          ),
        );
      },
    );
  }

  /// Builds the title of the page.
  Widget _buildPageTitle() {
    return const Padding(
      padding: EdgeInsets.only(top: 45),
      child: CustomPageTitle(title: Strings.sendAssets),
    );
  }

  /// Builds the UI for indicating poly transfer.
  Widget _buildPolyDisplay() {
    return CustomInputField(
      itemLabel: Strings.youSend,
      item: Container(
        width: 207,
        height: 31,
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
        width: 82,
        height: 31,
        controller: _amountController,
        hintText: Strings.amountHint,
      ),
    );
  }

  /// Builds the review button to initate tx.
  Widget _buildReviewButton(PolyTransferInputViewModel vm) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, bottom: 10),
      child: LargeButton(
        label: Strings.review,
        onPressed: () {
          vm.initiateTx(
            amount: _amountController.text,
            recipient: _validRecipientAddress,
            note: _noteController.text,
          );
        },
      ),
    );
  }

  /// Validates the recipient address entered by the user.
  ///
  /// If valid, [_validRecipientAddress] is updated.
  /// The [_recipientController.text] is also cleared beacuse the UI is updated with a different widget for a valid recipient address.
  void validateRecipientAddress(int networkId) {
    Map<String, dynamic> result = {};
    try {
      result = validateAddressByNetwork(
        Rules.networkStrings[networkId]!,
        _recipientController.text,
      );
    } catch (e) {
      result['success'] = false;
    }
    setState(() {
      if (result['success'] as bool) {
        _validRecipientAddress = _recipientController.text;
        _recipientController.text = '';
      } else {
        _validRecipientAddress = '';
      }
    });
  }
}
