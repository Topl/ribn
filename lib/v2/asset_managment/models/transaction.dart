// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ribn/v2/asset_managment/models/asset_type.dart';

// Project imports:

part 'transaction.freezed.dart';
part 'transaction.g.dart';

/// TODO SDK
/// This will most likely be replaced by the SDK
@freezed
class Transaction with _$Transaction {
  const factory Transaction({
    required String assetName,
    required AssetType assetType,
    required double assetAmount,
  }) = _Transaction;

  factory Transaction.fromJson(Map<String, dynamic> json) => _$TransactionFromJson(json);
}
