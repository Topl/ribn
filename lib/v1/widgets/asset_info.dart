// Flutter imports:

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:brambldart/model.dart';
import 'package:ribn_toolkit/constants/assets.dart';
import 'package:ribn_toolkit/constants/colors.dart';

// Project imports:
import 'package:ribn/v1/models/asset_details.dart';

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
    const Text defaultText = Text(
      'Choose Asset',
      style: TextStyle(
        color: Color(0xff6d6d6d),
        fontWeight: FontWeight.w600,
        fontFamily: 'DM Sans',
        fontStyle: FontStyle.normal,
        fontSize: 12.0,
      ),
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
                      child: Text(
                        assetDetails?.longName ?? '',
                        style: const TextStyle(
                          fontFamily: 'DM Sans',
                          fontSize: 12,
                          color: RibnColors.defaultText,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
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
                      child: Text(
                        assetCode!.shortName.show,
                        style: const TextStyle(
                          fontFamily: 'DM Sans',
                          fontSize: 12,
                          color: RibnColors.primary,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
      ],
    );
  }
}
