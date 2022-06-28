import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ribn/actions/user_details_actions.dart';
import 'package:ribn/constants/ui_constants.dart';
import 'package:ribn/models/app_state.dart';
import 'package:ribn/widgets/custom_drop_down.dart';
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn_toolkit/constants/styles.dart';
import 'package:ribn_toolkit/widgets/atoms/large_button.dart';

/// The section for editing asset unit.
///
/// The asset unit can be selected from a dropdown consisting of [UIConstants.assetUnitsList].
class AssetUnitEditSection extends StatefulWidget {
  /// The asset code with which the unit will be associated.
  final String assetCode;

  /// The currently assigned unit for the asset.
  final String? currentUnit;

  /// A callback function for handling save/cancel actions.
  final VoidCallback onActionTaken;

  const AssetUnitEditSection({
    Key? key,
    required this.assetCode,
    this.currentUnit,
    required this.onActionTaken,
  }) : super(key: key);

  @override
  _AssetUnitEditSectionState createState() => _AssetUnitEditSectionState();
}

class _AssetUnitEditSectionState extends State<AssetUnitEditSection> {
  /// True if the dropdown is active.
  bool dropdownOpened = false;

  /// Assigned the new unit when selected from the dropdown.
  String? selectedUnit;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      height: 100,
      width: 307,
      decoration: const BoxDecoration(
        color: RibnColors.whiteBackground,
        boxShadow: [BoxShadow(color: Color(0x0f000000), offset: Offset(0, 4), blurRadius: 4, spreadRadius: 0)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomDropDown(
            dropdownButton: _buildUnitDropdownButton(),
            dropdownChild: _buildUnitDropdownChild(),
            childAlignment: Alignment.bottomCenter,
            dropDownAlignment: Alignment.topCenter,
            visible: dropdownOpened,
            onDismissed: () {
              Overlay.of(context)!.setState(() {
                dropdownOpened = false;
              });
            },
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              LargeButton(
                buttonWidth: 123,
                buttonHeight: 33,
                buttonChild: Text(
                  'Save',
                  style: RibnToolkitTextStyles.btnMedium.copyWith(color: Colors.white),
                ),
                backgroundColor: RibnColors.primary,
                onPressed: () {
                  StoreProvider.of<AppState>(context).dispatch(
                    UpdateAssetDetailsAction(
                      assetCode: widget.assetCode,
                      unit: selectedUnit,
                    ),
                  );
                  widget.onActionTaken();
                },
              ),
              const SizedBox(width: 15),
              LargeButton(
                buttonWidth: 123,
                buttonHeight: 33,
                buttonChild: Text(
                  'Cancel',
                  style: RibnToolkitTextStyles.btnMedium.copyWith(color: RibnColors.ghostButtonText),
                ),
                backgroundColor: Colors.transparent,
                hoverColor: Colors.transparent,
                dropShadowColor: Colors.transparent,
                borderColor: RibnColors.ghostButtonText,
                onPressed: () => widget.onActionTaken(),
              )
            ],
          ),
        ],
      ),
    );
  }

  /// Builds the Unit dropdown button.
  Widget _buildUnitDropdownButton() {
    return MaterialButton(
      padding: EdgeInsets.zero,
      minWidth: 0,
      onPressed: () {
        setState(() {});
        Overlay.of(context)?.setState(() {
          dropdownOpened = true;
        });
      },
      child: Container(
        width: 125,
        height: 30,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(4.7)),
          border: Border.all(color: RibnColors.primary),
          color: const Color(0xffefefef),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 104,
              height: 21,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                color: RibnColors.primary,
              ),
              child: Center(
                child: Text(
                  selectedUnit ?? widget.currentUnit ?? 'Select Unit type',
                  style: RibnToolkitTextStyles.dropdownButtonStyle.copyWith(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(
              width: 8,
              child: Icon(
                Icons.keyboard_arrow_down_sharp,
                size: 12,
                color: Color(0xff859391),
              ),
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
                  child: Text(unit, style: RibnToolkitTextStyles.smallBody),
                ),
                onPressed: () {
                  setState(() {
                    dropdownOpened = false;
                  });
                  Overlay.of(context)!.setState(() {
                    selectedUnit = unit;
                    dropdownOpened = false;
                  });
                },
              ),
            )
            .toList(),
      ),
    );
  }
}
