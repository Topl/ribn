import 'package:flutter/material.dart';

import 'package:ribn/constants/colors.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/constants/styles.dart';
import 'package:ribn/constants/ui_constants.dart';
import 'package:ribn/presentation/transfers/widgets/custom_input_field.dart';
import 'package:ribn/widgets/custom_drop_down.dart';
import 'package:ribn/widgets/custom_text_field.dart';

/// An input field used on the [MintInputPage].
///
/// Allows the user to define the amount of asset to be minted and a custom unit for it.
class AssetAmountField extends StatefulWidget {
  /// Controller for the amount textfield.
  final TextEditingController controller;

  /// The selected unit for the asset to be minted.
  final String? selectedUnit;

  /// Handler for when a unit is selected.
  final Function(String) onUnitSelected;

  const AssetAmountField({
    Key? key,
    required this.onUnitSelected,
    required this.controller,
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
    return CustomInputField(
      itemLabel: Strings.amount,
      item: Stack(
        children: [
          // textfield for entering the asset amount
          CustomTextField(
            width: 116,
            height: 30,
            controller: widget.controller,
            hintText: Strings.amountHint,
          ),
          // dropdown for selecting a custom unit
          Positioned(
            right: 0,
            top: 1,
            child: CustomDropDown(
              visible: showUnitDropdown,
              onDismissed: () {
                setState(() {
                  showUnitDropdown = false;
                });
              },
              childAlignment: Alignment.bottomLeft,
              dropDownAlignment: Alignment.topLeft,
              dropdownButton: _buildUnitDropdownButton(),
              dropdownChild: _buildUnitDropdownChild(),
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
          showDropdownArrow = true;
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
            showUnitDropdown = true;
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
                  formatUnit(widget.selectedUnit),
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

  String formatUnit(String? unit) {
    return unit?.split(' ').first ?? 'Unit';
  }
}
