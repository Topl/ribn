import 'package:flutter/material.dart';
import 'package:ribn/constants/assets.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn_toolkit/widgets/atoms/text/ribn_font12_text_widget.dart';
import 'package:ribn_toolkit/widgets/atoms/text/ribn_h4_text_widget.dart';
import 'package:ribn_toolkit/widgets/molecules/custom_tooltip.dart';

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
            const RibnH4TextWidget(
                text: 'Asset code · short',
                textAlignment: TextAlign.start,
                textColor: RibnColors.defaultText,
                fontWeight: FontWeight.w500,),
            Padding(
              padding: const EdgeInsets.only(left: 4.0),
              child: CustomToolTip(
                offsetPositionLeftValue: 120,
                borderColor: Border.all(color: const Color(0xffE9E9E9)),
                toolTipIcon: Image.asset(
                  RibnAssets.greyHelpBubble,
                  width: 18,
                ),
                toolTipChild: const RibnFont12TextWidget(
                    textAlignment: TextAlign.justify,
                    text: Strings.assetCodeShortInfo,
                    textColor: RibnColors.defaultText,
                    fontWeight: FontWeight.w300,),
              ),
            ),
          ],
        ),
        const SizedBox(height: 3),
        RibnFont12TextWidget(
            text: assetShortName,
            textAlignment: TextAlign.justify,
            textColor: RibnColors.defaultText,
            fontWeight: FontWeight.w300,),
      ],
    );
  }
}
