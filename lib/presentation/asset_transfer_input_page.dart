import 'package:brambldart/brambldart.dart';
import 'package:flutter/material.dart';
import 'package:ribn/constants/assets.dart';
import 'package:ribn/constants/colors.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/constants/styles.dart';
import 'package:ribn/containers/asset_transfer_input_container.dart';
import 'package:ribn/widgets/address_display_container.dart';
import 'package:ribn/widgets/asset_info.dart';
import 'package:ribn/widgets/custom_page_title.dart';
import 'package:ribn/widgets/custom_text_field.dart';
import 'package:ribn/widgets/fee_info.dart';
import 'package:ribn/widgets/large_button.dart';
import 'package:ribn/widgets/loading_spinner.dart';
import 'package:ribn/widgets/note_text_field.dart';

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
  late AssetAmount _selectedAsset;

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
      builder: (context, vm) => Scaffold(
        backgroundColor: RibnColors.accent,
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
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
                            _buildAssetField(vm.assets),
                            const Spacer(),
                            _buildInputItem(
                              Strings.amount,
                              CustomTextField(
                                width: 82,
                                controller: _amountController,
                                hintText: Strings.amountHint,
                              ),
                              bottomPadding: 0,
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),
                        _buildInputItem(
                          Strings.from,
                          const AddressDisplayContainer(
                            text: Strings.yourRibnWalletAddress,
                            asset: RibnAssets.myFingerprint,
                          ),
                        ),
                        _buildInputItem(
                          Strings.to,
                          CustomTextField(
                            width: 309,
                            controller: _recipientController,
                            hintText: Strings.assetTransferToHint,
                          ),
                        ),
                        _buildInputItem(
                          Strings.note,
                          NoteTextField(noteController: _noteController, noteLength: _noteController.text.length),
                        ),
                        const FeeInfo(),
                        const SizedBox(height: 20),
                        LargeButton(
                          label: Strings.review,
                          onPressed: () {
                            vm.initiateTx(
                              _recipientController.text,
                              _amountController.text,
                              _noteController.text,
                              _selectedAsset.assetCode,
                            );
                          },
                        ),
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
      ),
    );
  }

  /// Builds the asset selection dropdown widget.
  Widget _buildAssetField(List<AssetAmount> assets) {
    return Column(
      children: [
        const SizedBox(
          width: 211,
          child: Text(
            Strings.youSend,
            style: RibnTextStyles.extH4,
          ),
        ),
        const SizedBox(height: 9.5),
        Container(
          color: RibnColors.whiteBackground,
          width: 211,
          height: 31,
          padding: const EdgeInsets.all(3),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(3),
            child: Material(
              color: RibnColors.whiteBackground,
              child: PopupMenuButton<AssetAmount>(
                offset: const Offset(0, 25),
                elevation: 0,
                initialValue: _selectedAsset,
                itemBuilder: (context) {
                  return assets.map(
                    (AssetAmount asset) {
                      return PopupMenuItem(
                        value: asset,
                        child: Text(asset.assetCode.shortName.show),
                      );
                    },
                  ).toList();
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    AssetInfo(assetCode: _selectedAsset.assetCode),
                    const Spacer(),
                    const Icon(Icons.arrow_drop_down, color: Colors.grey, size: 10),
                  ],
                ),
                onSelected: (AssetAmount asset) {
                  setState(() {
                    _selectedAsset = asset;
                  });
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// A helper function to build each of the input items on this page.
  Widget _buildInputItem(String itemLabel, Widget item, {double bottomPadding = 12}) {
    return Padding(
      padding: EdgeInsets.only(bottom: bottomPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            child: Text(
              itemLabel,
              style: RibnTextStyles.extH4,
            ),
          ),
          const SizedBox(height: 9.5),
          item,
        ],
      ),
    );
  }
}
