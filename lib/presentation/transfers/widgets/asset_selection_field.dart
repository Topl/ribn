import 'package:brambldart/brambldart.dart';
import 'package:flutter/material.dart';
import 'package:ribn/constants/colors.dart';
import 'package:ribn/presentation/transfers/widgets/custom_input_field.dart';
import 'package:ribn/widgets/asset_info.dart';
import 'package:ribn/widgets/custom_drop_down.dart';

/// An input field used on the [MintInputPage].
///
/// Allows the user to select from a dropdown of existing assets in the wallet.
class AssetSelectionField extends StatefulWidget {
  /// Currently selected asset.
  final AssetAmount? selectedAsset;

  /// List of assets in the wallet.
  final List<AssetAmount> assets;

  /// Handler for when an asset is selected.
  final Function(AssetAmount) onSelected;
  const AssetSelectionField({
    Key? key,
    required this.selectedAsset,
    required this.assets,
    required this.onSelected,
  }) : super(key: key);

  @override
  _AssetSelectionFieldState createState() => _AssetSelectionFieldState();
}

class _AssetSelectionFieldState extends State<AssetSelectionField> {
  /// True if asset dropdown needs to be displayed.
  bool showAssetDropdown = false;

  /// Scroll controller initialized for [Scrollbar] usage.
  final ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return CustomInputField(
      itemLabel: 'Remint',
      item: CustomDropDown(
        childAlignment: Alignment.bottomLeft,
        dropDownAlignment: Alignment.topLeft,
        visible: showAssetDropdown,
        onDismissed: () {
          setState(() {
            showAssetDropdown = false;
          });
        },
        dropdownButton: _buildAssetDropdownButton(),
        dropdownChild: _buildAssetDropdownChild(),
      ),
    );
  }

  /// Builds the asset dropdown button.
  Widget _buildAssetDropdownButton() {
    return Container(
      width: 310,
      height: 31,
      color: RibnColors.whiteBackground,
      padding: const EdgeInsets.all(3),
      child: MaterialButton(
        elevation: 0,
        color: const Color(0xffefefef),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
        child: Row(
          children: [
            AssetInfo(assetCode: widget.selectedAsset?.assetCode),
            const Spacer(),
            const Icon(Icons.keyboard_arrow_down_sharp, color: Colors.grey, size: 10),
          ],
        ),
        onPressed: () {
          setState(() {
            showAssetDropdown = true;
          });
        },
      ),
    );
  }

  /// Builds the asset dropdown widget.
  ///
  /// Allows user to select from the list of existing assets in the wallet, i.e. [widget.assets].
  Widget _buildAssetDropdownChild() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xffffffff),
        borderRadius: const BorderRadius.all(Radius.circular(4)),
        border: Border.all(color: const Color(0xffeeeeee)),
      ),
      width: 233,
      constraints: const BoxConstraints(maxHeight: 86, minHeight: 0),
      child: Scrollbar(
        controller: scrollController,
        isAlwaysShown: true,
        child: ListView(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          controller: scrollController,
          children: widget.assets
              .map(
                (asset) => MaterialButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    widget.onSelected(asset);
                    setState(() {
                      showAssetDropdown = false;
                    });
                  },
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: AssetInfo(assetCode: asset.assetCode),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
