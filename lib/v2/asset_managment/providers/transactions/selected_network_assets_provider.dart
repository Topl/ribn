// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:ribn/v2/asset_managment/models/network.dart';
import 'package:ribn/v2/asset_managment/models/asset_details.dart';
import 'package:ribn/v2/asset_managment/providers/selected_network_provider.dart';
import 'package:ribn/v2/asset_managment/providers/transactions/keychain_network_providers/mainnet_assets_provider.dart';
import 'package:ribn/v2/asset_managment/providers/transactions/keychain_network_providers/private_assets_provider.dart';
import 'package:ribn/v2/asset_managment/providers/transactions/keychain_network_providers/valhalla_assets_provider.dart';

final selectedNetworkAssetProvider = Provider.autoDispose<AsyncValue<List<AssetDetails>>>((ref) {
  final Network selectedKeychain = ref.watch(selectedNetworkNotifierProvider);
  switch (selectedKeychain) {
    case Network.topl_mainnet:
      return ref.watch(mainnetAssetsNotifierProvider);
    case Network.valhalla_testnet:
      return ref.watch(valhallaAssetsNotifierProvider);
    case Network.private_network:
      return ref.watch(privateAssetsNotifierProvider);
  }
});
