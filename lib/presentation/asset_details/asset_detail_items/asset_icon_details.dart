import 'package:flutter/material.dart';
import 'package:ribn_toolkit/constants/assets.dart';
import 'package:ribn_toolkit/constants/styles.dart';
import 'package:ribn/presentation/asset_details/widgets/edit_button.dart';

/// One of the asset details displayed on [AssetDetailsPage].
///
/// Displays the icon that's assigned to the asset.
class AssetIconDetails extends StatelessWidget {
  /// The current icon assigned to the asset.
  final String? currIcon;

  /// True if this is currently being edited.
  final bool editingSectionOpened;

  /// Callback for when edit button is pressed.
  final VoidCallback onEditPressed;

  const AssetIconDetails({
    Key? key,
    required this.currIcon,
    required this.editingSectionOpened,
    required this.onEditPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text('Icon', style: RibnToolkitTextStyles.extH4),
            const Spacer(),
            editingSectionOpened ? const SizedBox() : EditButton(onEditPressed: onEditPressed),
          ],
        ),
        const SizedBox(height: 3),
        SizedBox(
          width: 20,
          height: 20,
          child: currIcon == null ? Image.asset(RibnAssets.undefinedIcon) : Image.asset(currIcon!),
        ),
      ],
    );
  }
}
