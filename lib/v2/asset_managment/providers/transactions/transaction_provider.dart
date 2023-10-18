// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ribn/v2/asset_managment/models/asset_type.dart';

// Project imports:
import 'package:ribn/v2/asset_managment/models/asset_details.dart';

final transactionNotifierProvider =
    StateNotifierProvider.autoDispose<TransactionNotifier, AsyncValue<List<AssetDetails>>>((ref) {
  return TransactionNotifier(ref);
});

class TransactionNotifier extends StateNotifier<AsyncValue<List<AssetDetails>>> {
  final Ref ref;
  TransactionNotifier(this.ref) : super(AsyncLoading()) {
    getAssets().then((value) {
      state = AsyncData(value);
    });
  }

  Future<List<AssetDetails>> getAssets() async {
    return [
      AssetDetails(
        assetName: 'Topl Governance',
        assetType: AssetType.governance,
        assetAmount: 8437,
      ),
      AssetDetails(
        assetName: 'Topl Transaction',
        assetType: AssetType.transaction,
        assetAmount: 4012,
      ),
      AssetDetails(
        assetName: 'Avalanche',
        assetType: AssetType.avalanche,
        assetAmount: 508.6,
      ),
      AssetDetails(
        assetName: 'Polygon',
        assetType: AssetType.polygon,
        assetAmount: 0.35,
      ),
      AssetDetails(
        assetName: 'Ethereum',
        assetType: AssetType.ethereum,
        assetAmount: 1.53,
      ),
      AssetDetails(
        assetName: 'Bitcoin',
        assetType: AssetType.bitcoin,
        assetAmount: 0.35,
      )
    ];
  }

  Future<List<AssetDetails>> refreshAssets() {
    // TODO: implement refreshTransactions
    throw UnimplementedError();
  }

  Stream<List<AssetDetails>> streamAssets() {
    // TODO: implement streamTransactions
    throw UnimplementedError();
  }
}
