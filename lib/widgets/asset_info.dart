import 'package:brambldart/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ribn/constants/assets.dart';
import 'package:ribn/constants/colors.dart';

/// A custom display for asset information.
class AssetInfo extends StatelessWidget {
  /// AssetCode for which information needs to be displayed.
  final AssetCode? assetCode;

  const AssetInfo({
    required this.assetCode,
    Key? key,
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
        fontFamily: 'Nunito',
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
                : SvgPicture.asset(RibnAssets.coffeeGreenIcon),
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
                      child: const Text(
                        'Long Name',
                        style: TextStyle(
                          fontFamily: 'Nunito',
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
                          fontFamily: 'Nunito',
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
