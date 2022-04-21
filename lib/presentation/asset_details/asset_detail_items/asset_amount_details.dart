import 'package:flutter/material.dart';
import 'package:ribn_toolkit/constants/styles.dart';

/// One of the asset details displayed on [AssetDetailsPage].
///
/// Displays the total amount/quantity of asset owned.
class AssetAmountDetails extends StatelessWidget {
  /// The total quantity of the asset.
  final num assetQuantity;
  const AssetAmountDetails({
    Key? key,
    required this.assetQuantity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: const [
            Text('Total Amount', style: RibnToolkitTextStyles.extH4),
          ],
        ),
        const SizedBox(height: 3),
        Text(assetQuantity.toString(), style: RibnToolkitTextStyles.smallBody),
      ],
    );
  }
}
