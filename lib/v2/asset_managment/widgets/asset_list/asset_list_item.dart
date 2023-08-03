// Flutter imports:
import 'package:flutter/material.dart';
import 'package:ribn/v2/asset_managment/models/asset_type.dart';

// Project imports:
import 'package:ribn/v2/shared/constants/colors.dart';
import 'package:ribn/v2/shared/constants/ribn_text_style.dart';

class AssetListItem extends StatelessWidget {
  final String assetName;
  final AssetType assetType;
  final double assetAmount;
  const AssetListItem({
    required this.assetName,
    required this.assetType,
    required this.assetAmount,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          _Icon(
            assetType: assetType,
          ),
          SizedBox(width: 10),
          Text(
            assetName,
            style: RibnTextStyle.h3,
          ),
          Spacer(),
          _Amount(
            assetAmount: assetAmount,
            assetType: assetType,
          ),
        ],
      ),
    );
  }
}

class _Icon extends StatelessWidget {
  final AssetType assetType;
  const _Icon({
    required this.assetType,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      width: 45,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(
          color: RibnColors.grey,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Center(
        child: Image.asset(assetType.icon),
      ),
    );
  }
}

class _Amount extends StatelessWidget {
  final double assetAmount;
  final AssetType assetType;
  const _Amount({
    required this.assetAmount,
    required this.assetType,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          assetAmount.toString(),
          style: RibnTextStyle.h3,
        ),
        Text(
          assetType.abbreviation,
          style: RibnTextStyle.h3.copyWith(color: RibnColors.inactive),
        )
      ],
    );
  }
}
