import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/utils.dart';
import 'package:ribn_toolkit/widgets/molecules/custom_tooltip.dart';
import 'package:ribn/constants/assets.dart';
import 'package:ribn_toolkit/constants/styles.dart';
import 'package:ribn_toolkit/widgets/atoms/custom_copy_button.dart';

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
            const Text(Strings.issuerAddress, style: RibnToolkitTextStyles.h4),
            Padding(
              padding: const EdgeInsets.only(left: 4.0),
              child: CustomToolTip(
                toolTipIcon: Image.asset(
                  RibnAssets.greyHelpBubble,
                  width: 18,
                ),
                offsetPositionLeftValue: 100,
                toolTipChild: const Text(
                  Strings.issuerAddressInfo,
                  style: RibnToolkitTextStyles.toolTipTextStyle,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 3),
        Row(
          children: [
            SvgPicture.asset(RibnAssets.issuerFingerprint),
            Text(
              formatAddrString(issuerAddress),
              style: RibnToolkitTextStyles.smallBody,
            ),
            CustomCopyButton(textToBeCopied: issuerAddress),
          ],
        ),
      ],
    );
  }
}
