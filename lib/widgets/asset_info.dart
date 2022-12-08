import 'package:brambldart/model.dart';
import 'package:flutter/material.dart';
import 'package:ribn/models/asset_details.dart';
import 'package:ribn_toolkit/constants/assets.dart';
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn_toolkit/widgets/atoms/text/ribn_font12_text_widget.dart';

/// A custom display for asset information.
class AssetInfo extends StatelessWidget {
  /// AssetCode for which information needs to be displayed.
  final AssetCode? assetCode;
  final AssetDetails? assetDetails;

  const AssetInfo({
    Key? key,
    required this.assetCode,
    this.assetDetails,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// True if [assetCode] is null.
    final bool assetNotSelected = assetCode == null;

    /// Default text to be displayed if no asset been selected.
    const Text defaultText = RibnFont12TextWidget(
        text: 'Choose Asset',
        textAlignment: TextAlign.justify,
        textColor: RibnColors.greyedOut,
        fontWeight: FontWeight.w600,
        );

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: SizedBox(
            width: 19,
            height: 19,
            child: assetNotSelected
                ? Image.asset(RibnAssets.unselectedAsset)
                : Image.asset(assetDetails?.icon ?? RibnAssets.undefinedIcon),
          ),
        ),
        assetNotSelected
            ? defaultText
            : SizedBox(
                height: 19,
                width: 154,
                child: Row(
                  children: [
                    Container(
                      constraints: const BoxConstraints(maxWidth: 75),
                      child: RibnFont12TextWidget(
                          text: assetDetails?.longName ?? '',
                          textAlignment: TextAlign.justify,
                          textColor: RibnColors.defaultText,
                          fontWeight: FontWeight.w600,
                          textOverflow: TextOverflow.ellipsis,),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: Container(
                        width: 3,
                        height: 3,
                        decoration: BoxDecoration(
                          color: RibnColors.primary,
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 60,
                      child: RibnFont12TextWidget(
                          text: assetCode!.shortName.show,
                          textAlignment: TextAlign.justify,
                          textColor: RibnColors.defaultText,
                          fontWeight: FontWeight.w600,

                          textOverflow: TextOverflow.ellipsis,),
                    ),
                  ],
                ),
              ),
      ],
    );
  }
}
