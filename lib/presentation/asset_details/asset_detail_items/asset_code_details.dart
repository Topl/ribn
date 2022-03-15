import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ribn/constants/assets.dart';
import 'package:ribn/constants/styles.dart';
import 'package:ribn/utils.dart';
import 'package:ribn/widgets/custom_copy_button.dart';
import 'package:ribn/widgets/custom_tooltip.dart';

/// One of the asset details displayed on [AssetDetailsPage].
///
/// Displays the asset code, a tooltip with more description, and a copy button.
class AssetCodeDetails extends StatelessWidget {
  /// The asset code to be displayed.
  final String assetCode;
  const AssetCodeDetails({
    Key? key,
    required this.assetCode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text('Asset code', style: RibnTextStyles.extH4),
            CustomToolTip(
              tooltipText: 'Asset code',
              offsetPositionLeftValue: 100,
              tooltipIcon: SvgPicture.asset(
                RibnAssets.roundInfoCircle,
                width: 10,
              ),
            ),
          ],
        ),
        const SizedBox(height: 3),
        Row(
          children: [
            Text(
              formatAddrString(assetCode),
              style: RibnTextStyles.smallBody,
            ),
            CustomCopyButton(textToBeCopied: assetCode),
          ],
        ),
      ],
    );
  }
}
