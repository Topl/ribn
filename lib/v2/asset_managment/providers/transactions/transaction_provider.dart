// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ribn/v2/asset_managment/models/asset_type.dart';

// Project imports:
import 'package:ribn/v2/asset_managment/models/asset_details.dart';
import 'package:ribn/v2/asset_managment/models/chains.dart';
import 'package:ribn/v2/asset_managment/providers/selected_network_provider.dart';

final transactionNotifierProvider =
    StateNotifierProvider.autoDispose<TransactionNotifier, AsyncValue<List<AssetDetails>>>((ref) {
  final selectedChain = ref.watch(selectedChainProvider);
  return TransactionNotifier(ref, selectedChain);
});

class TransactionNotifier extends StateNotifier<AsyncValue<List<AssetDetails>>> {
  final Ref ref;
  final Chains selectedChain;
  TransactionNotifier(this.ref, this.selectedChain) : super(AsyncLoading()) {
    getAssets();
  }

  Future<void> getAssets() async {
    state = AsyncData(
      [
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
      ],
    );
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
