import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:ribn/constants/assets.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/constants/styles.dart';
import 'package:ribn/utils.dart';
import 'package:ribn/widgets/custom_copy_button.dart';
import 'package:ribn/widgets/custom_tooltip.dart';

class IssuerAddressDetails extends StatelessWidget {
  final String issuerAddress;
  const IssuerAddressDetails({
    Key? key,
    required this.issuerAddress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(Strings.issuerAddress, style: RibnTextStyles.extH4),
            CustomToolTip(
              tooltipText: Strings.issuerAddressInfo,
              offsetPositionLeftValue: 120,
              tooltipIcon: SvgPicture.asset(
                RibnAssets.roundInfoCircle,
                width: 10,
              ),
              toolTipBackgroundColor: const Color(0xffeef9f8),
            ),
          ],
        ),
        const SizedBox(height: 3),
        Row(
          children: [
            SvgPicture.asset(RibnAssets.issuerFingerprint),
            Text(
              formatAddrString(issuerAddress),
              style: RibnTextStyles.smallBody,
            ),
            CustomCopyButton(textToBeCopied: issuerAddress),
          ],
        ),
      ],
    );
  }
}
