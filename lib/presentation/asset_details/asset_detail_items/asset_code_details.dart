import 'package:flutter/material.dart';
import 'package:ribn/constants/assets.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/utils.dart';
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn_toolkit/widgets/atoms/custom_copy_button.dart';
import 'package:ribn_toolkit/widgets/atoms/text/ribn_font12_text_widget.dart';
import 'package:ribn_toolkit/widgets/atoms/text/ribn_h4_text_widget.dart';
import 'package:ribn_toolkit/widgets/molecules/custom_tooltip.dart';

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
            const RibnH4TextWidget(
              text: 'Asset code',
              textAlignment: TextAlign.start,
              textColor: RibnColors.ghostButtonText,
              fontWeight: FontWeight.w500,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 4.0),
              child: CustomToolTip(
                borderColor: Border.all(color: const Color(0xffE9E9E9)),
                toolTipIcon: Image.asset(
                  RibnAssets.greyHelpBubble,
                  width: 18,
                ),
                offsetPositionLeftValue: 80,
                toolTipChild: const RibnFont12TextWidget(
                    text: Strings.assetCodeLongInfo,
                    textAlignment: TextAlign.justify,
                    textColor: RibnColors.defaultText,
                    fontWeight: FontWeight.w300,),
              ),
            ),
          ],
        ),
        const SizedBox(height: 3),
        Row(
          children: [
            RibnFont12TextWidget(
                text: formatAddrString(assetCode),
                textAlignment: TextAlign.start,
                textColor: RibnColors.defaultText,
                fontWeight: FontWeight.w300,),
            const SizedBox(width: 8),
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
