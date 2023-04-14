import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ribn/v2/core/providers/nfts/keychain_nft_providers/mainnet_nft_provider.dart';
import 'package:ribn/v2/core/providers/nfts/keychain_nft_providers/private_nft_provider.dart';
import 'package:ribn/v2/core/providers/nfts/keychain_nft_providers/valhalla_nft_provider.dart';
import 'package:ribn/v2/core/providers/transactions/keychain_transaction_providers/mainnet_transaction_provider.dart';
import 'package:ribn/v2/core/providers/transactions/keychain_transaction_providers/private_transaction_provider.dart';
import 'package:ribn/v2/core/providers/transactions/keychain_transaction_providers/valhalla_transaction_provider.dart';

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
  final mainnetTransactionLoaded = ref.watch(mainnetTransactionLoadedProvider);
  if (mainnetTransactionLoaded) {
    ref.watch(mainnetTransactionNotifierProvider);
  }
  final privateTransactionLoaded = ref.watch(privateTransactionLoadedProvider);
  if (privateTransactionLoaded) {
    ref.watch(privateTransactionNotifierProvider);
  }
  final valhallaTransactionLoaded = ref.watch(valhallaTransactionLoadedProvider);
  if (valhallaTransactionLoaded) {
    ref.watch(valhallaTransactionNotifierProvider);
  }

  return mainnetNFTLoaded &&
      privateNFTLoaded &&
      valhallaNFTLoaded &&
      mainnetTransactionLoaded &&
      privateTransactionLoaded &&
      valhallaTransactionLoaded;
});
