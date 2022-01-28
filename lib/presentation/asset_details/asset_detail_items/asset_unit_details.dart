import 'package:flutter/material.dart';

import 'package:ribn/constants/styles.dart';
import 'package:ribn/presentation/asset_details/widgets/edit_button.dart';

/// One of the asset details displayed on [AssetDetailsPage].
///
/// Displays the custom unit that's assigned to the asset.
class AssetUnitDetails extends StatelessWidget {
  /// The current unit assigned to the asset.
  final String? currUnit;

  /// True if this is currently being edited.
  final bool editingSectionOpened;

  /// Callback for when edit button is pressed.
  final VoidCallback onEditPressed;

  const AssetUnitDetails({
    Key? key,
    required this.currUnit,
    required this.onEditPressed,
    required this.editingSectionOpened,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text('Unit', style: RibnTextStyles.extH4),
            const Spacer(),
            editingSectionOpened ? const SizedBox() : EditButton(onEditPressed: onEditPressed),
          ],
        ),
        const SizedBox(height: 3),
        Text(currUnit ?? 'Undefined', style: RibnTextStyles.smallBody),
      ],
    );
  }
}
