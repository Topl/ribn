import 'package:brambldart/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ribn/constants/assets.dart';
import 'package:ribn/constants/colors.dart';

/// A custom widget to display asset information.
class AssetInfo extends StatelessWidget {
  final AssetCode assetCode;
  const AssetInfo({required this.assetCode, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: SizedBox(
            width: 19,
            height: 19,
            child: SvgPicture.asset(RibnAssets.coffeeGreenIcon),
          ),
        ),
        SizedBox(
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
                  assetCode.shortName.show,
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
