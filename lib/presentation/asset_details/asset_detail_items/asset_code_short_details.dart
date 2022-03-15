import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ribn/constants/assets.dart';
import 'package:ribn/constants/styles.dart';
import 'package:ribn/widgets/custom_tooltip.dart';

/// One of the asset details displayed on [AssetDetailsPage].
///
/// Displays the asset short name.
class AssetCodeShortDetails extends StatelessWidget {
  final String assetShortName;

  const AssetCodeShortDetails({
    Key? key,
    required this.assetShortName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text('Asset code · short', style: RibnTextStyles.extH4),
            CustomToolTip(
              tooltipText: 'Helloooo',
              offsetPositionLeftValue: 100,
              tooltipIcon: SvgPicture.asset(
                RibnAssets.roundInfoCircle,
                width: 10,
              ),
            ),
          ],
        ),
        const SizedBox(height: 3),
        Text(assetShortName, style: RibnTextStyles.smallBody),
      ],
    );
  }
}
