import 'package:brambldart/brambldart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ribn/constants/assets.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/containers/asset_transfer_input_container.dart';
import 'package:ribn/presentation/transfers/transfer_utils.dart';
import 'package:ribn/presentation/transfers/widgets/from_address_field.dart';
import 'package:ribn/utils.dart';
import 'package:ribn/widgets/address_display_container.dart';
import 'package:ribn/widgets/custom_page_title.dart';
import 'package:ribn/widgets/fee_info.dart';
import 'package:ribn/widgets/loading_spinner.dart';
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn_toolkit/constants/styles.dart';
import 'package:ribn_toolkit/widgets/molecules/asset_amount_field.dart';
import 'package:ribn_toolkit/widgets/atoms/large_button.dart';
import 'package:ribn_toolkit/widgets/molecules/asset_selection_field.dart';
import 'package:ribn_toolkit/widgets/molecules/note_field.dart';
import 'package:ribn_toolkit/widgets/molecules/recipient_field.dart';

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

  /// True if currently loading raw tx creation.
  bool _loadingRawTx = false;

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
                                formattedSelectedAsset: {
                                  'assetCode': _selectedAsset.assetCode.toString(),
                                  'longName': vm.assetDetails[_selectedAsset.assetCode.toString()]?.longName,
                                  'shortName': _selectedAsset.assetCode.shortName.show,
                                  'assetIcon': vm.assetDetails[_selectedAsset.assetCode.toString()]?.icon,
                                },
                                formattedAsset: (asset) {
                                  return {
                                    'longName': vm.assetDetails[asset!.assetCode.toString()]?.longName,
                                    'shortName': asset.assetCode.shortName.show,
                                    'assetIcon': vm.assetDetails[asset!.assetCode.toString()]?.icon,
                                  };
                                },
                                assets: vm.assets,
                                label: Strings.youSend,
                                onSelected: (AssetAmount? asset) {
                                  setState(() {
                                    _selectedAsset = asset!;
                                  });
                                },
                                tooltipIcon: Image.asset(
                                  RibnAssets.greyHelpBubble,
                                  width: 18,
                                ),
                              ),
                              const Spacer(),
                              // Field for entering the amount for the asset transfer.
                              AssetAmountField(
                                selectedUnit: vm.assetDetails[_selectedAsset.assetCode.toString()]?.unit,
                                controller: _amountController,
                                allowEditingUnit: false,
                                onUnitSelected: (String unit) {},
                                chevronIcon: Image.asset(
                                  RibnAssets.chevronDownDark,
                                  width: 24,
                                ),
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
                              networkName: vm.currentNetwork.networkName,
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
                            icon: SvgPicture.asset(RibnAssets.recipientFingerprint),
                            alternativeDisplayChild: const AddressDisplayContainer(
                              text: Strings.yourRibnWalletAddress,
                              icon: RibnAssets.myFingerprint,
                              width: 240,
                            ),
                            errorBubbleIcon: Image.asset('assets/icons/invalid_recipient.png'),
                            // clear the textfield on backspace
                            onBackspacePressed: () {
                              setState(() {
                                _recipientController.clear();
                                _validRecipientAddress = '';
                              });
                            },
                          ),
                          // Field for attaching a note to the tx.
                          NoteField(
                            controller: _noteController,
                            noteLength: _noteController.text.length,
                            tooltipIcon: Image.asset(
                              RibnAssets.greyHelpBubble,
                              width: 18,
                            ),
                          ),
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
              _loadingRawTx ? const LoadingSpinner() : const SizedBox(),
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
      buttonChild: Text(
        Strings.review,
        style: RibnToolkitTextStyles.btnMedium.copyWith(
          color: Colors.white,
        ),
      ),
      onPressed: () {
        setState(() {
          _loadingRawTx = true;
        });
        vm.initiateTx(
          recipient: _validRecipientAddress,
          amount: _amountController.text,
          note: _noteController.text,
          assetCode: _selectedAsset.assetCode,
          assetDetails: vm.assetDetails[_selectedAsset.assetCode.toString()],
          onRawTxCreated: (bool success) async {
            _loadingRawTx = false;
            setState(() {});
            // Display error dialog if failed to create raw tx
            if (!success) {
              await TransferUtils.showErrorDialog(context);
            }
          },
        );
      },
    );
  }
}
