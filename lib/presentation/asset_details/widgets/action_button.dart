import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:ribn/actions/user_details_actions.dart';
import 'package:ribn/constants/colors.dart';
import 'package:ribn/constants/styles.dart';
import 'package:ribn/models/app_state.dart';

/// The action button used on the edit sections, e.g. see [AssetIconEditSection].
class ActionButton extends StatelessWidget {
  /// True if changes need to be saved.
  final bool saveChanges;

  /// The asset code for which changes are being saved.
  final String assetCode;

  /// The long name to be assigned to the asset.
  final String? longName;

  /// The icon to be assigned to the asset.
  final String? icon;

  /// The unit to be assigned to the asset.
  final String? unit;

  /// A callback function to handle onPressed event.
  final VoidCallback onPressed;

  const ActionButton({
    Key? key,
    required this.saveChanges,
    required this.assetCode,
    this.longName,
    this.icon,
    this.unit,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String label = saveChanges ? 'Save' : 'Cancel';
    final Color buttonColor = saveChanges ? RibnColors.primary : RibnColors.accent;

    return MaterialButton(
      elevation: 0,
      padding: EdgeInsets.zero,
      onPressed: () {
        if (saveChanges) {
          StoreProvider.of<AppState>(context).dispatch(
            UpdateAssetDetailsAction(
              assetCode: assetCode,
              longName: longName,
              unit: unit,
              icon: icon,
            ),
          );
        }
        onPressed();
      },
      child: Container(
        width: 123,
        height: 33,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          color: buttonColor,
        ),
        child: Center(
          child: Text(
            label,
            style: RibnTextStyles.btnMedium,
          ),
        ),
      ),
    );
  }
}
