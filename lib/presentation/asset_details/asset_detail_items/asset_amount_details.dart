// Flutter imports:
import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:ribn/presentation/asset_details/asset_detail_items/asset_column.dart';
=======

>>>>>>> rc-0.4
// Package imports:
import 'package:ribn_toolkit/constants/styles.dart';

/// One of the asset details displayed on [AssetDetailsPage].
///
/// Displays the total amount/quantity of asset owned.
class AssetAmountDetails extends StatelessWidget {
  /// The total quantity of the asset.
  final num assetQuantity;

  const AssetAmountDetails({
    Key? key,
    required this.assetQuantity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AssetColumn(
      child1: Text('Amount', style: RibnToolkitTextStyles.h4),
      child2: Text(assetQuantity.toString(), style: RibnToolkitTextStyles.smallBody),
    );
  }
}
