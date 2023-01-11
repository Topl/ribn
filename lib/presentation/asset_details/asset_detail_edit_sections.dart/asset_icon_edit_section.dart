// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_portal/flutter_portal.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn_toolkit/constants/styles.dart';
import 'package:ribn_toolkit/widgets/atoms/large_button.dart';

// Project imports:
import 'package:ribn/actions/user_details_actions.dart';
import 'package:ribn/constants/ui_constants.dart';
import 'package:ribn/models/app_state.dart';

/// The section for editing asset icon.
///
/// The asset icon can be selected from a dropdown consisting of [UIConstants.assetIconsList].
class AssetIconEditSection extends StatefulWidget {
  /// The asset code with which the long name will be associated.
  final String assetCode;

  /// A callback function for handling save/cancel actions.
  final VoidCallback onActionTaken;
  const AssetIconEditSection({
    Key? key,
    required this.assetCode,
    required this.onActionTaken,
  }) : super(key: key);

  @override
  _AssetIconEditSectionState createState() => _AssetIconEditSectionState();
}

class _AssetIconEditSectionState extends State<AssetIconEditSection> {
  String? _selectedIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      height: 140,
      width: 307,
      decoration: const BoxDecoration(
        color: RibnColors.whiteBackground,
        boxShadow: [
          BoxShadow(
            color: Color(0x0f000000),
            offset: Offset(0, 4),
            blurRadius: 4,
            spreadRadius: 0,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildIconMenu(),
          const SizedBox(height: 20),
          Row(
            children: [
              LargeButton(
                buttonWidth: 123,
                buttonHeight: 33,
                buttonChild: Text(
                  'Save',
                  style: RibnToolkitTextStyles.btnMedium
                      .copyWith(color: Colors.white),
                ),
                backgroundColor: RibnColors.primary,
                onPressed: () {
                  StoreProvider.of<AppState>(context).dispatch(
                    UpdateAssetDetailsAction(
                      assetCode: widget.assetCode,
                      icon: _selectedIcon,
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
                  style: RibnToolkitTextStyles.btnMedium
                      .copyWith(color: RibnColors.ghostButtonText),
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

  Widget _buildIconMenu() {
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
              (icon) => PortalEntry(
                child: MaterialButton(
                  padding: EdgeInsets.zero,
                  minWidth: 0,
                  onPressed: () {
                    setState(() {
                      _selectedIcon = icon;
                    });
                  },
                  child: Image.asset(icon),
                ),
                portal: Image.asset(
                  icon,
                  width: 31,
                ),
                portalAnchor: Alignment.bottomCenter,
                childAnchor: Alignment.topCenter,
                visible: _selectedIcon == icon,
              ),
            )
            .toList(),
      ),
    );
  }
}
