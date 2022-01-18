import 'package:brambldart/brambldart.dart';
import 'package:flutter/material.dart';
import 'package:ribn/constants/colors.dart';
import 'package:ribn/constants/rules.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/containers/mint_input_container.dart';
import 'package:ribn/presentation/transfers/widgets/asset_amount_field.dart';
import 'package:ribn/presentation/transfers/widgets/asset_long_name_field.dart';
import 'package:ribn/presentation/transfers/widgets/asset_selection_field.dart';
import 'package:ribn/presentation/transfers/widgets/asset_short_name_field.dart';
import 'package:ribn/presentation/transfers/widgets/issuer_address_field.dart';
import 'package:ribn/presentation/transfers/widgets/note_field.dart';
import 'package:ribn/presentation/transfers/widgets/recipient_field.dart';
import 'package:ribn/widgets/custom_page_title.dart';
import 'package:ribn/widgets/fee_info.dart';
import 'package:ribn/widgets/large_button.dart';
import 'package:ribn/widgets/loading_spinner.dart';

/// The mint input page that allows the initiation of an mint asset transaction.
class MintInputPage extends StatefulWidget {
  /// Indicates whether minting a new asset or reminting existing asset
  final bool mintingNewAsset;

  /// Indicates whether minting to user's own wallet or to another wallet
  final bool mintingToMyWallet;
  const MintInputPage({
    Key? key,
    required this.mintingNewAsset,
    required this.mintingToMyWallet,
  }) : super(key: key);

  @override
  _MintInputPageState createState() => _MintInputPageState();
}

class _MintInputPageState extends State<MintInputPage> {
  final TextEditingController _noteController = TextEditingController();
  final TextEditingController _assetLongNameController = TextEditingController();
  final TextEditingController _assetShortNameController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _recipientController = TextEditingController();
  late List<TextEditingController> _controllers;

  /// Assigned the valid recipient address
  String _validRecipientAddress = '';

  /// Currently selected asset; used when going through a 'remint' flow
  AssetAmount? _selectedAsset;

  /// The selcted unit for the asset to be minted
  String? _selectedUnit;

  /// The selected icon for the asset to be minted
  String? _selectedIcon;

  final GlobalKey _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _controllers = [
      _noteController,
      _assetLongNameController,
      _assetShortNameController,
      _amountController,
      _recipientController
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
    return MintInputContainer(
      builder: (BuildContext context, MintInputViewmodel vm) => Scaffold(
        backgroundColor: RibnColors.accent,
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  _buildPageTitle(),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: 310,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // builds the apt asset defining field, depending on [widget.mintingNewAsset]
                          _buildAssetField(vm),
                          Row(
                            children: [
                              // field for defining a short name for the asset
                              AssetShortNameField(controller: _assetShortNameController),
                              const Spacer(),
                              // field for defining asset amount & custom unit
                              AssetAmountField(
                                selectedUnit: _selectedUnit,
                                controller: _amountController,
                                onUnitSelected: (String unit) {
                                  setState(() {
                                    _selectedUnit = unit;
                                  });
                                },
                              ),
                            ],
                          ),
                          const IssuerAddressField(),
                          // field for entering the recipient address
                          RecipientField(
                            controller: _recipientController,
                            validRecipientAddress: _validRecipientAddress,
                            mintingToMyWallet: widget.mintingToMyWallet,
                            // validate the address entered on change
                            onChanged: (text) => validateRecipientAddress(vm.currNetworkId),
                            // clear the textfield on backspace
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
      ),
    );
  }

  /// Builds the title of the page.
  Widget _buildPageTitle() {
    return Padding(
      padding: const EdgeInsets.only(top: 45),
      child: CustomPageTitle(title: widget.mintingNewAsset ? Strings.mint : Strings.remint),
    );
  }

  /// Builds the asset defining field.
  ///
  /// If [widget.mintingNewAsset] is true, [AssetLongNameField] is built to allow entering a long name for the asset.
  /// If [widget.mintingNewAsset] is false, [AssetSelectionField] is built to allow selecting from an existing asset.
  ///
  /// The [AssetLongNameField] also allows selecting an icon for the new asset to be minted.
  Widget _buildAssetField(MintInputViewmodel vm) {
    return widget.mintingNewAsset
        ? AssetLongNameField(
            controller: _assetLongNameController,
            selectedIcon: _selectedIcon,
            onIconSelected: (String icon) {
              setState(() {
                _selectedIcon = icon;
              });
            },
          )
        : AssetSelectionField(
            selectedAsset: _selectedAsset,
            assets: vm.assets,
            onSelected: (AssetAmount? asset) {
              setState(() {
                _selectedAsset = asset;
              });
            },
          );
  }

  /// Builds the review button to initate tx.
  Widget _buildReviewButton(MintInputViewmodel vm) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, bottom: 10),
      child: LargeButton(
        label: Strings.review,
        onPressed: () {
          vm.initiateTx(
            assetShortName: _assetShortNameController.text,
            amount: _amountController.text,
            recipient: _validRecipientAddress,
            note: _noteController.text,
            mintingToMyWallet: widget.mintingToMyWallet,
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
