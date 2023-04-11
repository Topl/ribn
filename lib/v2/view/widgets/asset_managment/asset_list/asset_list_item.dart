import 'package:flutter/material.dart';
import 'package:ribn/v2/core/models/asset_type.dart';

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
          _Icon(),
          Text(assetName),
          _Amount(),
        ],
      ),
    );
  }
}

class _Icon extends StatelessWidget {
  const _Icon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class _Amount extends StatelessWidget {
  const _Amount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
