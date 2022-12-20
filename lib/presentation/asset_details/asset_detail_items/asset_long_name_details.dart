// ignore_for_file: unused_import

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ribn_toolkit/constants/assets.dart';
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn_toolkit/constants/styles.dart';
import 'package:ribn_toolkit/widgets/atoms/hover_icon_button.dart';

// Project imports:
import 'package:ribn/models/app_state.dart';
import 'package:ribn/models/asset_details.dart';

/// One of the asset details displayed on [AssetDetailsPage].
///
/// Displays the custom long name assigned to the asset.
class AssetLongNameDetails extends StatelessWidget {
  /// The current long name assigned to the asset.
  final String? currLongName;

  /// True if this is currently being edited.
  final bool editingSectionOpened;

  /// Callback for when edit is pressed.
  final VoidCallback onEditPressed;

  const AssetLongNameDetails({
    Key? key,
    required this.currLongName,
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
            const Text('Asset name', style: RibnToolkitTextStyles.h4),
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
        Text(currLongName ?? 'Undefined',
            style: RibnToolkitTextStyles.smallBody),
      ],
    );
  }
}
