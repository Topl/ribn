import 'package:brambldart/brambldart.dart';
import 'package:flutter/material.dart';
import 'package:ribn/constants/colors.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/containers/asset_transfer_input_container.dart';
import 'package:ribn/presentation/error_section.dart';
import 'package:ribn/presentation/transfers/widgets/asset_amount_field.dart';
import 'package:ribn/presentation/transfers/widgets/asset_selection_field.dart';
import 'package:ribn/presentation/transfers/widgets/from_address_field.dart';
import 'package:ribn/presentation/transfers/widgets/note_field.dart';
import 'package:ribn/presentation/transfers/widgets/recipient_field.dart';
import 'package:ribn/utils.dart';
import 'package:ribn/widgets/custom_page_title.dart';
import 'package:ribn/widgets/fee_info.dart';
import 'package:ribn/widgets/large_button.dart';
import 'package:ribn/widgets/loading_spinner.dart';

/// The asset transfer input page that allows the initiation of an asset transfer.
///
/// Prompts the user to select an asset, the recipient address, amount, and an optional note as transaction metadata.
class AssetTransferInputPage extends StatefulWidget {
  const AssetTransferInputPage({required this.asset, Key? key}) : super(key: key);
  final AssetAmount asset;

  @override
  State<AssetTransferInputPage> createState() => _AssetTransferInputPageState();
}

class _AssetTransferInputPageState extends State<AssetTransferInputPage> {
  final TextEditingController _noteController = TextEditingController();
  final TextEditingController _recipientController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  late List<TextEditingController> _controllers;

  /// The currently selected asset for the transfer.
  /// Initialized with [widget.asset] in [initState].
  late AssetAmount _selectedAsset;

  /// Assigned the valid recipient address.
  String _validRecipientAddress = '';

  @override
  void initState() {
    _controllers = [
      _noteController,
      _recipientController,
      _amountController,
    ];
    _controllers.forEach(initListener);
    _selectedAsset = widget.asset;
    super.initState();
  }

  @override
  void dispose() {
    _controllers.forEach(disposeController);
    super.dispose();
  }

  void initListener(TextEditingController controller) {
    controller.addListener(() {
      setState(() {});
    });
  }

  void disposeController(TextEditingController controller) => controller.dispose();

  @override
  Widget build(BuildContext context) {
    return AssetTransferInputContainer(
      onWillChange: (prevVm, currVm) async {
        if (currVm.failedToCreateRawTx && currVm.failedToCreateRawTx != prevVm?.failedToCreateRawTx) {
          await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              backgroundColor: RibnColors.accent,
              title: ErrorSection(onTryAgain: () => Navigator.of(context).pop()),
            ),
          );
        }
      },
      builder: (BuildContext context, AssetTransferInputViewModel vm) {
        return Scaffold(
          backgroundColor: RibnColors.accent,
          body: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // page title
                    const Padding(
                      padding: EdgeInsets.only(top: 45),
                      child: CustomPageTitle(title: Strings.sendAssets),
                    ),
                    const SizedBox(height: 40),
                    SizedBox(
                      width: 310,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              // Field for displaying the selected asset for the transfer.
                              // Allows changing the asset for the transfer via a dropdown.
                              AssetSelectionField(
                                selectedAsset: _selectedAsset,
                                label: Strings.youSend,
                                assets: vm.assets,
                                assetDetails: vm.assetDetails,
                                onSelected: (AssetAmount? asset) {
                                  setState(() {
                                    _selectedAsset = asset!;
                                  });
                                },
                              ),
                              const Spacer(),
                              // Field for entering the amount for the asset transfer.
                              AssetAmountField(
                                selectedUnit: vm.assetDetails[_selectedAsset.assetCode.toString()]?.unit,
                                controller: _amountController,
                                allowEditingUnit: false,
                                onUnitSelected: (String unit) {},
                              ),
                            ],
                          ),
                          const SizedBox(height: 14),
                          // Displays the sender address.
                          const FromAddressField(),
                          // Field for entering the recipient address.
                          RecipientField(
                            controller: _recipientController,
                            validRecipientAddress: _validRecipientAddress,
                            // validate the address on change
                            onChanged: (text) => validateRecipientAddress(
                              networkId: vm.currNetworkId,
                              address: _recipientController.text,
                              handleResult: (bool result) {
                                if (mounted) {
                                  setState(() {
                                    if (result) {
                                      _validRecipientAddress = _recipientController.text;
                                      _recipientController.text = '';
                                    } else {
                                      _validRecipientAddress = '';
                                    }
                                  });
                                }
                              },
                            ),
                            // clear the textfield on backspace
                            onBackspacePressed: () {
                              setState(() {
                                _recipientController.clear();
                                _validRecipientAddress = '';
                              });
                            },
                          ),
                          // Field for attaching a note to the tx.
                          NoteField(controller: _noteController, noteLength: _noteController.text.length),
                          FeeInfo(fee: vm.networkFee),
                          const SizedBox(height: 20),
                          _buildReviewButton(vm),
                        ],
                      ),
                    ),
                    const SizedBox(height: 18),
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

  /// Builds the review button to initate tx.
  ///
  /// Upon pressing the review button, the tx flow is initiated via [vm.initiateTx].
  Widget _buildReviewButton(AssetTransferInputViewModel vm) {
    return LargeButton(
      label: Strings.review,
      onPressed: () {
        vm.initiateTx(
          _recipientController.text,
          _amountController.text,
          _noteController.text,
          _selectedAsset.assetCode,
          vm.assetDetails[_selectedAsset.assetCode.toString()],
        );
      },
    );
  }
}
