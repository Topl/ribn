import 'package:brambldart/brambldart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ribn/constants/assets.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/containers/asset_transfer_input_container.dart';
import 'package:ribn/presentation/transfers/bottom_review_action.dart';
import 'package:ribn/presentation/transfers/transfer_utils.dart';
import 'package:ribn/presentation/transfers/widgets/from_address_field.dart';
import 'package:ribn/utils.dart';
import 'package:ribn/widgets/address_display_container.dart';
import 'package:ribn/widgets/fee_info.dart';
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn_toolkit/constants/styles.dart';
import 'package:ribn_toolkit/widgets/atoms/custom_page_title.dart';
import 'package:ribn_toolkit/widgets/atoms/large_button.dart';
import 'package:ribn_toolkit/widgets/molecules/asset_amount_field.dart';
import 'package:ribn_toolkit/widgets/molecules/asset_selection_field.dart';
import 'package:ribn_toolkit/widgets/molecules/loading_spinner.dart';
import 'package:ribn_toolkit/widgets/molecules/note_field.dart';
import 'package:ribn_toolkit/widgets/molecules/recipient_field.dart';
import 'package:ribn_toolkit/widgets/molecules/sliding_segment_control.dart';

/// The asset transfer input page that allows the initiation of an asset transfer.
///
/// Prompts the user to select an asset, the recipient address, amount, and an optional note as transaction metadata.
class AssetTransferInputPage extends StatefulWidget {
  const AssetTransferInputPage({Key? key}) : super(key: key);

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
  AssetAmount? _selectedAsset;

  /// Assigned the valid recipient address.
  String _validRecipientAddress = '';

  /// True if currently loading raw tx creation.
  bool _loadingRawTx = false;

  bool _validAmount = false;

  int currentTabIndex = 0;

  @override
  void initState() {
    _controllers = [
      _noteController,
      _recipientController,
      _amountController,
    ];
    _controllers.forEach(initListener);
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
          backgroundColor: RibnColors.background,
          body: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // page title
                    const CustomPageTitle(
                      title: Strings.send,
                      hideBackArrow: true,
                    ),
                    const SizedBox(height: 40),
                    SizedBox(
                      width: 310,
                      child: SlidingSegmentControl(
                        currentTabIndex: currentTabIndex,
                        updateTabIndex: (i) => {
                          setState(() {
                            currentTabIndex = i as int;
                          })
                        },
                        tabItems: <int, Widget>{
                          0: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              Strings.sendAssets,
                              style: RibnToolkitTextStyles.btnMedium.copyWith(color: RibnColors.defaultText),
                            ),
                          ),
                          1: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              Strings.sendNativeCoins,
                              style: RibnToolkitTextStyles.btnMedium.copyWith(color: RibnColors.defaultText),
                            ),
                          ),
                        },
                        redirectOnClick: () => vm.routeToSendPolys(),
                      ),
                    ),
                    const SizedBox(height: 40),
                    SizedBox(
                      width: 310,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AssetSelectionField(
                            formattedSelectedAsset: {
                              'assetCode': _selectedAsset?.assetCode.toString(),
                              'longName': vm.assetDetails[_selectedAsset?.assetCode.toString()]?.longName,
                              'shortName': _selectedAsset?.assetCode.shortName.show,
                              'assetIcon': vm.assetDetails[_selectedAsset?.assetCode.toString()]?.icon,
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
                                _validAmount = TransferUtils.validateAmount(
                                  _amountController.text,
                                  vm.getAssetBalance(asset.assetCode.toString()),
                                );
                              });
                            },
                            tooltipIcon: Image.asset(
                              RibnAssets.greyHelpBubble,
                              width: 18,
                            ),
                            chevronIcon: Image.asset(
                              RibnAssets.chevronDownDark,
                              width: 24,
                            ),
                          ),
                          AssetAmountField(
                            selectedUnit: vm.assetDetails[_selectedAsset?.assetCode.toString()]?.unit,
                            controller: _amountController,
                            allowEditingUnit: false,
                            onUnitSelected: (String amount) {
                              setState(() {
                                _validAmount = TransferUtils.validateAmount(
                                  amount,
                                  vm.getAssetBalance(_selectedAsset?.assetCode.toString()),
                                );
                              });
                            },
                            chevronIcon: Image.asset(
                              RibnAssets.chevronDownDark,
                              width: 24,
                            ),
                            maxTransferrableAmount: vm.getAssetBalance(_selectedAsset?.assetCode.toString()),
                          ),
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
                            // clear the textfield on backspace
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
          bottomNavigationBar: BottomReviewAction(
            children: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // fee info for the tx
                FeeInfo(fee: vm.networkFee),
                _buildReviewButton(vm),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildReviewButton(AssetTransferInputViewModel vm) {
    final bool enteredValidInputs =
        _validRecipientAddress.isNotEmpty && _amountController.text.isNotEmpty && _validAmount;

    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Center(
        child: LargeButton(
          buttonWidth: double.infinity,
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
                    recipient: _validRecipientAddress,
                    amount: _amountController.text,
                    note: _noteController.text,
                    assetCode: _selectedAsset!.assetCode,
                    assetDetails: vm.assetDetails[_selectedAsset!.assetCode.toString()],
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
              : () {},
          disabled: !enteredValidInputs,
        ),
      ),
    );
  }
}
