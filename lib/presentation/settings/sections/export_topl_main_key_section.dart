import 'package:flutter/material.dart';
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn_toolkit/constants/styles.dart';

/// The section that allows for downloading the Topl Main Key.
class ExportToplMainKeySection extends StatelessWidget {
  /// Callback for when export button is pressed.
  final VoidCallback onExportPressed;

  const ExportToplMainKeySection({
    required this.onExportPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          Strings.exportToplMainKey,
          style: RibnToolkitTextStyles.extH3,
        ),
        const Padding(
          padding: EdgeInsets.only(top: 6, bottom: 8),
          child: Text(
            Strings.exportToplMainKeyDesc,
            style: RibnToolkitTextStyles.settingsSmallText,
          ),
        ),
        SizedBox(
          width: 110,
          height: 22,
          child: MaterialButton(
            color: RibnColors.primary,
            elevation: 0,
            hoverElevation: 0,
            highlightElevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            onPressed: onExportPressed,
            child: const Text(
              Strings.exportWallet,
              style: TextStyle(
                fontSize: 10,
                fontFamily: 'DM Sans',
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
