import 'package:flutter/material.dart';
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn_toolkit/widgets/atoms/text/ribn_font12_text_widget.dart';
import 'package:ribn_toolkit/widgets/atoms/text/ribn_h4_text_widget.dart';

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
            RibnH4TextWidget(
              text: 'Total Amount',
              textAlignment: TextAlign.start,
              textColor: RibnColors.ghostButtonText,
              fontWeight: FontWeight.w500,
            ),
          ],
        ),
        const SizedBox(height: 3),
        RibnFont12TextWidget(
          text: assetQuantity.toString(),
          textAlignment: TextAlign.start,
          textColor: RibnColors.ghostButtonText,
          fontWeight: FontWeight.w500,
        )
      ],
    );
  }
}
