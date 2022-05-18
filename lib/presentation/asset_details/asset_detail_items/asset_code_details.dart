import 'package:flutter/material.dart';
import 'package:ribn/constants/assets.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/utils.dart';
import 'package:ribn_toolkit/widgets/molecules/custom_tooltip.dart';
import 'package:ribn_toolkit/constants/styles.dart';
import 'package:ribn_toolkit/widgets/atoms/custom_copy_button.dart';

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
            const Text('Asset code', style: RibnToolkitTextStyles.h4),
            Padding(
              padding: const EdgeInsets.only(left: 4.0),
              child: CustomToolTip(
                toolTipIcon: Image.asset(
                  RibnAssets.greyHelpBubble,
                  width: 18,
                ),
                offsetPositionLeftValue: 80,
                toolTipChild: const Text(
                  Strings.assetCodeLongInfo,
                  style: RibnToolkitTextStyles.toolTipTextStyle,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 3),
        Row(
          children: [
            Text(
              formatAddrString(assetCode),
              style: RibnToolkitTextStyles.smallBody,
            ),
            CustomCopyButton(
              textToBeCopied: assetCode,
              icon: Image.asset(
                RibnAssets.copyIcon,
                width: 26,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
