import 'package:flutter/material.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn_toolkit/constants/styles.dart';
import 'package:ribn/constants/ui_constants.dart';
import 'package:ribn/presentation/transfers/widgets/custom_input_field.dart';
import 'package:ribn/widgets/custom_drop_down.dart';
import 'package:ribn_toolkit/widgets/atoms/custom_text_field.dart';

/// An input field used on the [MintInputPage].
///
/// Allows the user to define an asset long name and select a icon for the asset.
class AssetLongNameField extends StatefulWidget {
  /// Controller for the asset long name.
  final TextEditingController controller;

  /// The selected icon for the asset to be minted.
  final String? selectedIcon;

  /// Handler for when an icon is selected.
  final Function(String) onIconSelected;

  const AssetLongNameField({
    Key? key,
    required this.controller,
    required this.onIconSelected,
    this.selectedIcon,
  }) : super(key: key);

  @override
  _AssetLongNameFieldState createState() => _AssetLongNameFieldState();
}

class _AssetLongNameFieldState extends State<AssetLongNameField> {
  /// Max length of the asset long name.
  final int maxLength = 16;

  /// True if icon dropdown needs to be displayed.
  bool showIconDropdown = false;

  /// True if dropdown arrow needs to be displayed, i.e. on hover.
  bool showDropdownArrow = false;

  @override
  Widget build(BuildContext context) {
    return CustomInputField(
      informationText: Strings.assetLongNameInfo,
      itemLabel: Strings.assetLongName,
      item: Stack(
        children: [
          // textfield for entering the asset long name
          CustomTextField(
            controller: widget.controller,
            hintText: Strings.assetLongNameHint,
            maxLength: maxLength,
          ),
          // dropdown for selecting an asset icon
          Positioned(
            right: 5,
            top: 1,
            child: CustomDropDown(
              childAlignment: Alignment.bottomCenter,
              dropDownAlignment: Alignment.topCenter,
              visible: showIconDropdown,
              onDismissed: () {
                setState(() {
                  showIconDropdown = false;
                });
              },
              dropdownButton: _buildIconDropdownButton(),
              dropdownChild: _buildIconDropdownChild(),
            ),
          ),
        ],
      ),
    );
  }

  /// Builds the icon dropdown button.
  ///
  /// If [showDropdownArrow] is true, a drop down arrow is also displayed.
  Widget _buildIconDropdownButton() {
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
            showIconDropdown = true;
          });
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            widget.selectedIcon != null
                ? Image.asset(widget.selectedIcon!)
                : Container(
                    width: 42,
                    height: 21,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      color: Color(0xff26a69a),
                    ),
                    child: const Center(
                      child: Text(
                        'Icon',
                        style: RibnToolkitTextStyles.dropdownButtonStyle,
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

  /// Builds the icon dropdown widget.
  ///
  /// Allows user to select from a list of custom icons, i.e. [UIConstants.assetIconsList].
  Widget _buildIconDropdownChild() {
    return Container(
      width: 98,
      height: 68,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(3)),
        border: Border.all(color: const Color(0xffefefef)),
        color: Colors.white,
      ),
      child: GridView(
        padding: const EdgeInsets.all(5),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
        ),
        children: UIConstants.assetIconsList
            .map(
              (icon) => MaterialButton(
                padding: EdgeInsets.zero,
                minWidth: 0,
                onPressed: () {
                  widget.onIconSelected(icon);
                  setState(() {
                    showIconDropdown = false;
                  });
                },
                child: Image.asset(icon),
              ),
            )
            .toList(),
      ),
    );
  }
}
