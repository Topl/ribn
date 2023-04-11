import 'package:flutter/material.dart';
import 'package:ribn/v2/core/models/asset_type.dart';

class AssetListItem extends StatelessWidget {
  final String assetName;
  final AssetType assetType;
  const AssetListItem({
    required this.assetName,
    required this.assetType,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
