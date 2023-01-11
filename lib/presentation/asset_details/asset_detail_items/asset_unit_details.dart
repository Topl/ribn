// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:ribn_toolkit/constants/assets.dart';
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn_toolkit/constants/styles.dart';
import 'package:ribn_toolkit/widgets/atoms/hover_icon_button.dart';

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
            const Text('Unit', style: RibnToolkitTextStyles.h4),
            const Spacer(),
            editingSectionOpened
                ? const SizedBox()
                : HoverIconButton(
                    buttonText: Text(
                      'Edit',
                      style: RibnToolkitTextStyles.dropdownButtonStyle
                          .copyWith(color: RibnColors.primary),
                    ),
                    buttonIcon: Image.asset(RibnAssets.editIcon),
                    onPressed: onEditPressed,
                  ),
          ],
        ),
        const SizedBox(height: 3),
        Text(currUnit ?? 'Undefined', style: RibnToolkitTextStyles.smallBody),
      ],
    );
  }
}
