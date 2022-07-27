import 'package:flutter/material.dart';
import 'package:ribn/constants/strings.dart';
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
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            const Text('Asset code · short', style: RibnTextStyles.extH4),
            // ignore: prefer_const_constructors
            CustomToolTip(
              toolTipChild: const Text(
                Strings.assetCodeShortInfo,
                style: RibnTextStyles.toolTipTextStyle,
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
