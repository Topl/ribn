import 'package:flutter/material.dart';
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn_toolkit/constants/styles.dart';
import 'package:ribn_toolkit/widgets/atoms/large_button.dart';

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
          child: LargeButton(
            buttonChild: Text(
              Strings.exportWallet,
              style: RibnToolkitTextStyles.btnLarge.copyWith(
                color: Colors.white,
                fontSize: 10,
              ),
            ),
            backgroundColor: RibnColors.primary,
            hoverColor: RibnColors.primaryButtonHover,
            dropShadowColor: RibnColors.primaryButtonShadow,
            onPressed: onExportPressed,
          ),
        ),
      ],
    );
  }
}
