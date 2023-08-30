// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ribn/v2/asset_managment/models/asset_type.dart';

// Project imports:
import 'package:ribn/v2/asset_managment/models/asset_details.dart';
import 'package:ribn/v2/asset_managment/providers/transactions/keychain_network_providers/assets_provider_class.dart';

final mainnetAssetsLoadedProvider = StateProvider.autoDispose<bool>((ref) {
  ref.onDispose(() {});
  return false;
});

final mainnetAssetsNotifierProvider =
    StateNotifierProvider.autoDispose<MainnetTransactionProvider, AsyncValue<List<AssetDetails>>>((ref) {
  return MainnetTransactionProvider(ref);
});

class MainnetTransactionProvider extends AssetsNotifier {
  final Ref ref;
  MainnetTransactionProvider(this.ref) : super();

  @override
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

  @override
  Future<List<AssetDetails>> refreshAssets() {
    // TODO: implement refreshTransactions
    throw UnimplementedError();
  }

  @override
  Stream<List<AssetDetails>> streamAssets() {
    // TODO: implement streamTransactions
    throw UnimplementedError();
  }

  @override
  void onProviderLoad() {
    ref.read(mainnetAssetsLoadedProvider.notifier).state = true;
  }
}
