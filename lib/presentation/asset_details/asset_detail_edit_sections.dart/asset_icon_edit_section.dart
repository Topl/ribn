import 'package:flutter/material.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:ribn/constants/colors.dart';
import 'package:ribn/constants/ui_constants.dart';
import 'package:ribn/presentation/asset_details/widgets/action_button.dart';

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
      width: 309,
      decoration: const BoxDecoration(
        color: RibnColors.whiteBackground,
        boxShadow: [BoxShadow(color: Color(0x0f000000), offset: Offset(0, 4), blurRadius: 4, spreadRadius: 0)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildIconMenu(),
          const SizedBox(height: 20),
          Row(
            children: [
              ActionButton(
                saveChanges: true,
                assetCode: widget.assetCode,
                onPressed: widget.onActionTaken,
                icon: _selectedIcon,
              ),
              const SizedBox(width: 15),
              ActionButton(
                saveChanges: false,
                assetCode: widget.assetCode,
                onPressed: widget.onActionTaken,
              ),
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
                portal: Image.asset(icon),
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
