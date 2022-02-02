import 'package:flutter/material.dart';

import 'package:ribn/constants/colors.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/constants/styles.dart';
import 'package:ribn/constants/ui_constants.dart';
import 'package:ribn/presentation/transfers/widgets/custom_input_field.dart';
import 'package:ribn/utils.dart';
import 'package:ribn/widgets/custom_drop_down.dart';
import 'package:ribn/widgets/custom_text_field.dart';

/// An input field used on the [MintInputPage] and [AssetTransferInputPage].
///
/// Allows the user to define the amount of asset to be minted/transfered and a custom unit associated with it.
class AssetAmountField extends StatefulWidget {
  /// Controller for the amount textfield.
  final TextEditingController controller;

  /// The selected unit for the asset to be minted/transfered.
  final String? selectedUnit;

  /// Handler for when a unit is selected.
  final Function(String) onUnitSelected;

  /// True if the unit type can be edited, e.g. when minting a new asset.
  final bool allowEditingUnit;

  const AssetAmountField({
    Key? key,
    required this.onUnitSelected,
    required this.controller,
    this.allowEditingUnit = true,
    this.selectedUnit,
  }) : super(key: key);

  @override
  _AssetAmountFieldState createState() => _AssetAmountFieldState();
}

class _AssetAmountFieldState extends State<AssetAmountField> {
  /// [TextStyle] for drop down items.
  final TextStyle dropdownTextStyle = const TextStyle(
    color: Color(0xff323232),
    fontWeight: FontWeight.w400,
    fontFamily: 'Nunito',
    fontSize: 12.0,
    decoration: TextDecoration.none,
  );

  /// True if dropdown needs to be displayed.
  bool showUnitDropdown = false;

  /// True if dropdown arrow needs to be displayed.
  bool showDropdownArrow = false;

  @override
  Widget build(BuildContext context) {
    final double textFieldWidth = widget.allowEditingUnit ? 116 : 82;

    return CustomInputField(
      itemLabel: Strings.amount,
      item: Stack(
        children: [
          // textfield for entering the asset amount
          CustomTextField(
            width: textFieldWidth,
            height: 30,
            controller: widget.controller,
            hintText: Strings.amountHint,
          ),
          // show dropdown for selecting a custom unit if [widget.allowEditingUnit] is true.
          // otherwise show the unit already associated with the asset.
          widget.allowEditingUnit
              ? Positioned(
                  right: 0,
                  top: 1,
                  child: CustomDropDown(
                    visible: showUnitDropdown,
                    onDismissed: () {
                      setState(() {
                        showUnitDropdown = false;
                      });
                    },
                    childAlignment: Alignment.bottomCenter,
                    dropDownAlignment: Alignment.topCenter,
                    dropdownButton: _buildUnitDropdownButton(),
                    dropdownChild: _buildUnitDropdownChild(),
                  ),
                )
              : Positioned(
                  right: 2,
                  top: 5,
                  child: SizedBox(
                    width: 30,
                    child: Center(
                      child: Text(
                        formatAssetUnit(widget.selectedUnit),
                        style: RibnTextStyles.dropdownButtonStyle.copyWith(color: RibnColors.primary),
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  /// Builds the Unit dropdown button.
  ///
  /// If [showDropdownArrow] is true, a drop down arrow is also displayed.
  Widget _buildUnitDropdownButton() {
    return MouseRegion(
      onEnter: (pointerEvent) {
        setState(() {
          // show dropdown arrow if unit can be edited.
          showDropdownArrow = widget.allowEditingUnit;
        });
      },
      onExit: (pointerEvent) {
        setState(() {
          showDropdownArrow = false;
        });
      },
      child: MaterialButton(
        minWidth: 0,
        onPressed: () {
          setState(() {
            // show dropdown if unit can be edited.
            showUnitDropdown = widget.allowEditingUnit;
          });
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 42,
              height: 21,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                color: RibnColors.primary,
              ),
              child: Center(
                child: Text(
                  formatAssetUnit(widget.selectedUnit),
                  style: RibnTextStyles.dropdownButtonStyle,
                ),
              ),
            ),
            SizedBox(
              width: 5,
              child: showDropdownArrow
                  ? const Icon(
                      Icons.keyboard_arrow_down_sharp,
                      size: 12,
                      color: Color(0xff859391),
                    )
                  : const SizedBox(),
            ),
          ],
        ),
      ),
    );
  }

  /// Builds the Unit dropdown widget.
  ///
  /// Allows user to select from a list of custom units, i.e. [UIConstants.assetUnitsList].
  Widget _buildUnitDropdownChild() {
    return Container(
      width: 120,
      height: 135,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(4)),
        border: Border.all(color: const Color(0xffeeeeee), width: 1),
        color: const Color(0xffffffff),
      ),
      child: ListView(
        children: UIConstants.assetUnitsList
            .map(
              (unit) => MaterialButton(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(unit, style: dropdownTextStyle),
                ),
                onPressed: () {
                  widget.onUnitSelected(unit);
                  setState(() {
                    showUnitDropdown = false;
                  });
                },
              ),
            )
            .toList(),
      ),
    );
  }
}
