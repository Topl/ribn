// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:ribn/v2/asset_managment/providers/nfts/network_nft_providers/mainnet_nft_provider.dart';
import 'package:ribn/v2/asset_managment/providers/nfts/network_nft_providers/private_nft_provider.dart';
import 'package:ribn/v2/asset_managment/providers/nfts/network_nft_providers/valhalla_nft_provider.dart';
import 'package:ribn/v2/asset_managment/providers/transactions/keychain_network_providers/mainnet_assets_provider.dart';
import 'package:ribn/v2/asset_managment/providers/transactions/keychain_network_providers/private_assets_provider.dart';
import 'package:ribn/v2/asset_managment/providers/transactions/keychain_network_providers/valhalla_assets_provider.dart';

/// This provider is used to keep loaded assets in memory
/// That way get requests are not made every time the user switches between NFTs and Crypto
/// as well as when the user switches between networks
/// NOT CURRENTLY WORKING
final loadedAssetsProvider = Provider.autoDispose<bool>((ref) {
  ref.onDispose(() {});
  // NFTs
  final mainnetNFTLoaded = ref.watch(mainnetNFTLoadedProvider);
  if (mainnetNFTLoaded) {
    ref.watch(mainnetNFTNotifierProvider);
  }
  final privateNFTLoaded = ref.watch(privateNFTLoadedProvider);
  if (privateNFTLoaded) {
    ref.watch(privateNFTNotifierProvider);
  }
  final valhallaNFTLoaded = ref.watch(valhallaNFTLoadedProvider);
  if (valhallaNFTLoaded) {
    ref.watch(valhallaNFTNotifierProvider);
  }

  // Transactions
  final mainnetTransactionLoaded = ref.watch(mainnetAssetsLoadedProvider);
  if (mainnetTransactionLoaded) {
    ref.watch(mainnetAssetsNotifierProvider);
  }
  final privateTransactionLoaded = ref.watch(privateAssetsLoadedProvider);
  if (privateTransactionLoaded) {
    ref.watch(privateAssetsNotifierProvider);
  }
  final valhallaTransactionLoaded = ref.watch(valhallaAssetsLoadedProvider);
  if (valhallaTransactionLoaded) {
    ref.watch(valhallaAssetsNotifierProvider);
  }

  return mainnetNFTLoaded &&
      privateNFTLoaded &&
      valhallaNFTLoaded &&
      mainnetTransactionLoaded &&
      privateTransactionLoaded &&
      valhallaTransactionLoaded;
});
