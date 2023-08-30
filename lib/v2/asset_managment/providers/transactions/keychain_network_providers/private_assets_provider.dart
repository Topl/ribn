// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:ribn/v2/asset_managment/models/asset_details.dart';
import 'package:ribn/v2/asset_managment/providers/transactions/keychain_network_providers/assets_provider_class.dart';

final privateAssetsLoadedProvider = StateProvider.autoDispose<bool>((ref) {
  return false;
});

final privateAssetsNotifierProvider =
    StateNotifierProvider.autoDispose<PrivateTransactionProvider, AsyncValue<List<AssetDetails>>>((ref) {
  return PrivateTransactionProvider(ref);
});

class PrivateTransactionProvider extends AssetsNotifier {
  final Ref ref;
  PrivateTransactionProvider(this.ref) : super();

  @override
  Future<List<AssetDetails>> getAssets() {
    // TODO: implement getTransactions
    throw UnimplementedError();
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
    ref.read(privateAssetsLoadedProvider.notifier).state = true;
  }
}
