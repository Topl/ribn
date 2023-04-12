import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ribn/v2/core/models/NFT.dart';
import 'package:ribn/v2/core/models/keychain.dart';
import 'package:ribn/v2/core/providers/keychain/selected_keychain_provider.dart';
import 'package:ribn/v2/core/providers/NFTs/keychain_NFT_providers/mainnet_nft_provider.dart';
import 'package:ribn/v2/core/providers/NFTs/keychain_NFT_providers/private_nft_provider.dart';
import 'package:ribn/v2/core/providers/NFTs/keychain_NFT_providers/valhalla_nft_provider.dart';

final selectedKeychainNFTProvider = Provider.autoDispose<AsyncValue<List<NFT>>>((ref) {
  final Keychain selectedKeychain = ref.watch(selectedKeychainNotifierProvider);
  switch (selectedKeychain) {
    case Keychain.topl_mainnet:
      return ref.watch(mainnetNFTNotifierProvider);
    case Keychain.valhalla_testnet:
      return ref.watch(valhallaNFTNotifierProvider);
    case Keychain.private_network:
      return ref.watch(privateNFTNotifierProvider);
  }
});
