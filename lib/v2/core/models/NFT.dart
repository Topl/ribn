import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ribn/v2/core/models/asset_type.dart';

part 'NFT.freezed.dart';
part 'NFT.g.dart';

/// TODO SDK
/// This will most likely be replaced by the SDK
@freezed
class NFT with _$NFT {
  const factory NFT({
    required String assetName,
    required AssetType assetType,
  }) = _NFT;

  factory NFT.fromJson(Map<String, dynamic> json) => _$NFTFromJson(json);
}
