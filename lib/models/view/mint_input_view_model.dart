import 'package:brambldart/model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ribn/models/asset_details.dart';
import 'package:ribn/models/ribn_network.dart';

part 'mint_input_view_model.freezed.dart';

@freezed
class MintInputViewModel with _$MintInputViewModel {
  // Added constructor. Must not have any parameter
  // const PolyTransferInputViewModel._();

  const factory MintInputViewModel({
    /// Handler for initiating mint asset tx.
    required Future<void> Function({
      required String assetShortName,
      required String amount,
      required String recipient,
      required String note,
      bool mintingToMyWallet,
      bool mintingNewAsset,
      AssetDetails? assetDetails,
      required Function(bool success) onRawTxCreated,
    })
        initiateTx,

    /// Tx fee for the current network.
    required num networkFee,

    /// Current network id.
    required RibnNetwork currentNetwork,

    /// The list of assets previously issued/minted by this wallet.
    required List<AssetAmount> assets,

    /// Locally stored asset details.
    required Map<String, AssetDetails> assetDetails,
  }) = _MintInputViewModel;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MintInputViewmodel &&
        other.networkFee == networkFee &&
        listEquals(other.assets, assets) &&
        other.currentNetwork == currentNetwork &&
        mapEquals(other.assetDetails, assetDetails);
  }
}
