import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ribn/constants/assets.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/utils.dart';
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn_toolkit/widgets/atoms/custom_copy_button.dart';
import 'package:ribn_toolkit/widgets/atoms/text/ribn_font12_text_widget.dart';
import 'package:ribn_toolkit/widgets/atoms/text/ribn_h4_text_widget.dart';
import 'package:ribn_toolkit/widgets/molecules/custom_tooltip.dart';

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
            const RibnH4TextWidget(
                text: Strings.issuerAddress,
                textAlignment: TextAlign.justify,
                textColor: RibnColors.defaultText,
                fontWeight: FontWeight.w500,),
            Padding(
              padding: const EdgeInsets.only(left: 4.0),
              child: CustomToolTip(
                borderColor: Border.all(color: const Color(0xffE9E9E9)),
                toolTipIcon: Image.asset(
                  RibnAssets.greyHelpBubble,
                  width: 18,
                ),
                offsetPositionLeftValue: 100,
                toolTipChild: const RibnFont12TextWidget(
                    text: Strings.issuerAddressInfo,
                    textAlignment: TextAlign.justify,
                    textColor: RibnColors.primary,
                    fontWeight: FontWeight.w300,),
              ),
            ),
          ],
        ),
        const SizedBox(height: 3),
        Row(
          children: [
            SvgPicture.asset(RibnAssets.issuerFingerprint),
            const SizedBox(width: 8),
            RibnFont12TextWidget(
                text: formatAddrString(issuerAddress),
                textAlignment: TextAlign.justify,
                textColor: RibnColors.primary,
                fontWeight: FontWeight.w300,),
            const SizedBox(width: 8),
            CustomCopyButton(
              textToBeCopied: issuerAddress,
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
