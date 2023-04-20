// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:ribn/v2/core/models/NFT.dart';
import 'package:ribn/v2/core/providers/nfts/keychain_nft_providers/nft_provider_class.dart';

final privateNFTLoadedProvider = StateProvider.autoDispose<bool>((ref) {
  return false;
});

final privateNFTNotifierProvider = StateNotifierProvider.autoDispose<PrivateNFTProvider, AsyncValue<List<NFT>>>((ref) {
  return PrivateNFTProvider(ref);
});

class PrivateNFTProvider extends NFTNotifier {
  final Ref ref;
  PrivateNFTProvider(this.ref) : super();

  @override
  Future<List<NFT>> getNFTs() {
    // TODO: implement getNFTs
    throw UnimplementedError();
  }

  @override
  Future<List<NFT>> refreshNFTs() {
    // TODO: implement refreshNFTs
    throw UnimplementedError();
  }

  @override
  Stream<List<NFT>> streamNFTs() {
    // TODO: implement streamNFTs
    throw UnimplementedError();
  }

  @override
  void onProviderLoad() {
    ref.read(privateNFTLoadedProvider.notifier).state = true;
  }
}
