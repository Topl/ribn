import 'package:brambldart/model.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ribn/models/asset_details.dart';
import 'package:ribn/models/ribn_network.dart';

part 'asset_transfer_input_view_model.freezed.dart';

@freezed
class AssetTransferInputViewModel with _$AssetTransferInputViewModel {
  // Added constructor. Must not have any parameter
  // const PolyTransferInputViewModel._();

  const factory AssetTransferInputViewModel({
    /// Handler for initiating tx.
    required Future<void> Function({
      required String recipient,
      required String amount,
      required String note,
      required AssetCode assetCode,
      AssetDetails? assetDetails,
      required void Function(bool success) onRawTxCreated,
    })
        initiateTx,

    /// Tx fee for the current network.
    required num networkFee,

    /// Current network id.
    required RibnNetwork currentNetwork,

    /// All assets owned by this wallet.
    required List<AssetAmount> assets,

    /// Locally stored asset details.
    required Map<String, AssetDetails> assetDetails,

    /// Gets total balance in wallet for a particular asset.
    required num Function(String?) getAssetBalance,
  }) = _AssetTransferInputViewModel;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AssetTransferInputViewModel &&
        listEquals(other.assets, assets) &&
        other.networkFee == networkFee &&
        mapEquals(other.assetDetails, assetDetails) &&
        other.currentNetwork == currentNetwork;
  }
}
