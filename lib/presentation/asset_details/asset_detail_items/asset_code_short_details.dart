// Flutter imports:
import 'package:flutter/material.dart';
// Project imports:
import 'package:ribn/constants/assets.dart';
import 'package:ribn/constants/strings.dart';
// Package imports:
import 'package:ribn_toolkit/constants/styles.dart';
import 'package:ribn_toolkit/widgets/molecules/custom_tooltip.dart';

/// One of the asset details displayed on [AssetDetailsPage].
///
/// Displays the asset short name.
class AssetCodeShortDetails extends StatelessWidget {
  final String assetShortName;
  final String? currentIcon;

  AssetCodeShortDetails({
    Key? key,
    required this.assetShortName,
    required this.currentIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text('Asset name', style: RibnToolkitTextStyles.h4),
            Padding(
              padding: const EdgeInsets.only(left: 4.0),
              child: CustomToolTip(
                offsetPositionLeftValue: 120,
                borderColor: Border.all(color: const Color(0xffE9E9E9)),
                toolTipIcon: Image.asset(
                  RibnAssets.greyHelpBubble,
                  width: 18,
                ),
                toolTipChild: const Text(
                  Strings.assetCodeShortInfo,
                  style: RibnToolkitTextStyles.toolTipTextStyle,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 3),
        Row(children: [
          Padding(
            padding: const EdgeInsets.only(top: 3, bottom: 5),
            child: SizedBox(
              width: 20,
                height: 20,
                child: currentIcon == null
                    ? Image.asset(RibnAssets.undefinedIcon)
                    : Image.asset(
                        currentIcon!,
                        width: 31,
                      ),
            ),
          ),
          SizedBox(width: 5,),
          Text(assetShortName, style: RibnToolkitTextStyles.smallBody),
        ],),
        // asset icon display - can be edited

      ],
    );
  }
}
