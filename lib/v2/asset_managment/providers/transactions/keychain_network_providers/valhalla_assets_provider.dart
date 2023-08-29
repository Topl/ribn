// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:ribn/v2/asset_managment/models/asset_details.dart';
import 'package:ribn/v2/asset_managment/providers/transactions/keychain_network_providers/assets_provider_class.dart';

import '../../../models/asset_type.dart';

final valhallaAssetsLoadedProvider = StateProvider.autoDispose<bool>((ref) {
  return false;
});

final valhallaAssetsNotifierProvider =
    StateNotifierProvider.autoDispose<ValhallaTransactionProvider, AsyncValue<List<AssetDetails>>>((ref) {
  return ValhallaTransactionProvider(ref);
});

class ValhallaTransactionProvider extends AssetsNotifier {
  final Ref ref;
  ValhallaTransactionProvider(this.ref) : super();

  @override
  Future<List<AssetDetails>> getAssets() async {
    return [
      AssetDetails(
        assetName: 'Valhala Topl Governance',
        assetType: AssetType.governance,
        assetAmount: 8437,
      ),
      AssetDetails(
        assetName: 'Valhalla Topl Transaction',
        assetType: AssetType.transaction,
        assetAmount: 4012,
      ),
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
    ref.read(valhallaAssetsLoadedProvider.notifier).state = true;
  }
}
