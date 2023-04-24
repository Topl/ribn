// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:ribn/v2/core/models/NFT.dart';
import 'package:ribn/v2/core/models/network.dart';
import 'package:ribn/v2/core/providers/network/selected_network_provider.dart';
import 'package:ribn/v2/core/providers/nfts/network_nft_providers/mainnet_nft_provider.dart';
import 'package:ribn/v2/core/providers/nfts/network_nft_providers/private_nft_provider.dart';
import 'package:ribn/v2/core/providers/nfts/network_nft_providers/valhalla_nft_provider.dart';

final selectedNetworkNFTProvider = Provider.autoDispose<AsyncValue<List<NFT>>>((ref) {
  final Network selectedKeychain = ref.watch(selectedNetworkNotifierProvider);
  switch (selectedKeychain) {
    case Network.topl_mainnet:
      return ref.watch(mainnetNFTNotifierProvider);
    case Network.valhalla_testnet:
      return ref.watch(valhallaNFTNotifierProvider);
    case Network.private_network:
      return ref.watch(privateNFTNotifierProvider);
  }
});
