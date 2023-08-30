// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ribn/v2/asset_managment/models/asset_type.dart';

// Project imports:

part 'asset_details.freezed.dart';
part 'asset_details.g.dart';

/// TODO SDK
/// This will most likely be replaced by the SDK
@freezed
class AssetDetails with _$AssetDetails {
  const factory AssetDetails({
    required String assetName,
    required AssetType assetType,
    required double assetAmount,
  }) = _AssetDetails;

  factory AssetDetails.fromJson(Map<String, dynamic> json) => _$AssetDetailsFromJson(json);
}
