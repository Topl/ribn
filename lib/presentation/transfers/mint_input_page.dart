import 'package:brambldart/brambldart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:ribn/constants/assets.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/constants/ui_constants.dart';
import 'package:ribn/containers/mint_input_container.dart';
import 'package:ribn/models/asset_details.dart';
import 'package:ribn/presentation/empty_state_screen.dart';
import 'package:ribn/presentation/transfers/bottom_review_action.dart';
import 'package:ribn/presentation/transfers/transfer_utils.dart';
import 'package:ribn/presentation/transfers/widgets/issuer_address_field.dart';
import 'package:ribn/utils.dart';
import 'package:ribn/widgets/address_display_container.dart';
import 'package:ribn/widgets/fee_info.dart';
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn_toolkit/constants/styles.dart';
import 'package:ribn_toolkit/widgets/organisms/custom_page_text_title.dart';
import 'package:ribn_toolkit/widgets/atoms/large_button.dart';
import 'package:ribn_toolkit/widgets/molecules/asset_amount_field.dart';
import 'package:ribn_toolkit/widgets/molecules/asset_long_name_field.dart';
import 'package:ribn_toolkit/widgets/molecules/asset_selection_field.dart';
import 'package:ribn_toolkit/widgets/molecules/asset_short_name_field.dart';
import 'package:ribn_toolkit/widgets/molecules/note_field.dart';
import 'package:ribn_toolkit/widgets/molecules/recipient_field.dart';
import 'package:ribn_toolkit/widgets/molecules/sliding_segment_control.dart';

/// The mint input page that allows the initiation of an mint asset transaction.
class MintInputPage extends StatefulWidget {
  const MintInputPage({Key? key}) : super(key: key);

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

  /// Indicates whether minting a new asset or reminting existing asset
  bool mintingNewAsset = true;

  /// The current active tab index for SlidingSegmentControl
  int currentTabIndex = 0;

  final GlobalKey _formKey = GlobalKey<FormState>();
  bool isKeyboardVisible = false;

  @override
  void initState() {
    KeyboardVisibilityController().onChange.listen((bool visible) {
      setState(() {
        isKeyboardVisible = visible;
      });
    });

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
    dynamic returnFormFieldsOrEmptyState(vm) {
      if (vm.assets.isEmpty && mintingNewAsset == false) {
        return EmptyStateScreen(
          icon: RibnAssets.walletWithBorder,
          title: Strings.noAssetsInWallet,
          body: emptyStateBody,
          buttonOneText: 'Mint',
          buttonOneAction: () => {
            setState(() {
              mintingNewAsset = true;
              currentTabIndex = 0;
            })
          },
          buttonTwoText: 'Share',
          buttonTwoAction: () async => await showReceivingAddress(),
          mobileHeight: MediaQuery.of(context).size.height * 0.63,
          desktopHeight: 258,
        );
      }

      return SizedBox(
        width: 310,
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // builds the apt asset defining field, depending on [widget.mintingNewAsset]
              _buildAssetField(vm),
              // field for defining a short name
              mintingNewAsset
                  ? AssetShortNameField(
                      controller: _assetShortNameController,
                      tooltipIcon: Image.asset(
                        RibnAssets.greyHelpBubble,
                        width: 18,
                      ),
                    )
                  : const SizedBox(),
              // field for defining asset amount & custom unit
              AssetAmountField(
                selectedUnit: _selectedUnit,
                controller: _amountController,
                allowEditingUnit: mintingNewAsset,
                onUnitSelected: (String unit) {
                  setState(() {
                    _selectedUnit = unit;
                  });
                },
                chevronIcon: Image.asset(
                  RibnAssets.chevronDownDark,
                  width: 24,
                ),
              ),
              // ignore: prefer_const_constructors
              IssuerAddressField(width: 213), // const ignored here so that tooltip can be dismissed
              // field for entering the recipient address
              RecipientField(
                controller: _recipientController,
                validRecipientAddress: _validRecipientAddress,
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
                icon: SvgPicture.asset(RibnAssets.myFingerprint),
                alternativeDisplayChild: const AddressDisplayContainer(
                  text: Strings.yourRibnWalletAddress,
                  icon: RibnAssets.myFingerprint,
                  width: 256,
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
      );
    }

    return MintInputContainer(
      builder: (BuildContext context, MintInputViewmodel vm) => Listener(
        onPointerDown: (_) {
          if (mounted) setState(() {});
        },
        child: LoaderOverlay(
          child: Scaffold(
            backgroundColor: RibnColors.background,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  /// Builds the title of the page.
                  const CustomPageTextTitle(
                    title: Strings.mint,
                    hideBackArrow: true,
                  ),
                  const SizedBox(height: 20),
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
                            Strings.mintAsset,
                            style: RibnToolkitTextStyles.btnMedium.copyWith(color: RibnColors.defaultText),
                          ),
                        ),
                        1: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            Strings.mintExistingAsset,
                            style: RibnToolkitTextStyles.btnMedium.copyWith(color: RibnColors.defaultText),
                          ),
                        ),
                      },
                      redirectOnClick: () => {
                        setState(() {
                          mintingNewAsset = !mintingNewAsset;
                        })
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  returnFormFieldsOrEmptyState(vm),
                ],
              ),
            ),
            bottomNavigationBar: BottomReviewAction(
              maxHeight: kIsWeb ? 120 : 143,
              children: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // fee info for the tx
                  FeeInfo(fee: vm.networkFee),
                  _buildReviewButton(vm),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Builds the asset defining field.
  ///
  /// If [widget.mintingNewAsset] is true, [AssetLongNameField] is built to allow entering a long name for the asset.
  /// If [widget.mintingNewAsset] is false, [AssetSelectionField] is built to allow selecting from an existing asset.
  ///
  /// The [AssetLongNameField] also allows selecting an icon for the new asset to be minted.
  Widget _buildAssetField(MintInputViewmodel vm) {
    return mintingNewAsset
        ? AssetLongNameField(
            controller: _assetLongNameController,
            selectedIcon: _selectedIcon,
            onIconSelected: (String icon) {
              setState(() {
                _selectedIcon = icon;
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
            assetsIconList: UIConstants.assetIconsList,
          )
        : AssetSelectionField(
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
            onSelected: (AssetAmount? asset) {
              setState(() {
                _selectedAsset = asset;
                _selectedUnit = vm.assetDetails[asset!.assetCode.toString()]?.unit;
                _assetShortNameController.text = asset.assetCode.shortName.show;
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
          );
  }

  /// Builds the review button to initate tx.
  ///
  /// Upon pressing the review button, the tx flow is initiated via [vm.initiateTx].
  /// Note: [assetDetails] only updated if a new asset is being minted.
  Widget _buildReviewButton(MintInputViewmodel vm) {
    final bool enteredValidInputs = _amountController.text.isNotEmpty &&
        _assetShortNameController.text.isNotEmpty &&
        _validRecipientAddress.isNotEmpty;
    // Update assetDetails if minting a new asset
    final AssetDetails? assetDetails = mintingNewAsset
        ? AssetDetails(
            icon: _selectedIcon,
            longName: _assetLongNameController.text,
            unit: _selectedUnit,
          )
        : vm.assetDetails[_selectedAsset?.assetCode.toString()];
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
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
                  assetShortName: _assetShortNameController.text,
                  amount: _amountController.text,
                  recipient: _validRecipientAddress,
                  note: _noteController.text,
                  mintingNewAsset: mintingNewAsset,
                  assetDetails: assetDetails,
                  onRawTxCreated: (bool success) async {
                    context.loaderOverlay.hide();
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
    );
  }
}
