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
final loadedAssetsProvider = Provider.autoDispose<void>((ref) {
  // NFTs
  if (ref.watch(mainnetNFTLoadedProvider)) {
    print('QQQQ mainnetNFTLoadedProvider');
    ref.watch(mainnetNFTNotifierProvider);
  }
  if (ref.watch(privateNFTLoadedProvider)) {
    print('QQQQ privateNFTLoadedProvider');
    ref.watch(privateNFTNotifierProvider);
  }
  if (ref.watch(valhallaNFTLoadedProvider)) {
    print('QQQQ valhallaNFTLoadedProvider');
    ref.watch(valhallaNFTNotifierProvider);
  }

  // Transactions
  if (ref.watch(mainnetTransactionLoadedProvider)) {
    print('QQQQ mainnetTransactionLoadedProvider');
    ref.watch(mainnetTransactionNotifierProvider);
  }
  if (ref.watch(privateTransactionLoadedProvider)) {
    print('QQQQ privateTransactionLoadedProvider');
    ref.watch(privateTransactionNotifierProvider);
  }
  if (ref.watch(valhallaTransactionLoadedProvider)) {
    print('QQQQ valhallaTransactionLoadedProvider');
    ref.watch(valhallaTransactionNotifierProvider);
  }
  return;
});
