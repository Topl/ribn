import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ribn/v2/core/models/NFT.dart';
import 'package:ribn/v2/core/providers/nfts/keychain_nft_providers/nft_provider_class.dart';

/// This provider is used to tell the app mainnet NFTs have been loaded
final mainnetNFTLoadedProvider = StateProvider<bool>((ref) {
  ref.onDispose(() {});
  return false;
});

final mainnetNFTNotifierProvider = StateNotifierProvider.autoDispose<MainnetNFTProvider, AsyncValue<List<NFT>>>((ref) {
  return MainnetNFTProvider(ref);
});

class MainnetNFTProvider extends NFTNotifier {
  final Ref ref;
  MainnetNFTProvider(this.ref) : super();

  @override
  Future<List<NFT>> getNFTs() async {
    return [
      NFT(
        assetName: 'Whimsical Octoplus Oasis Club',
        assetUrl: 'assets/v2/icons/octoplus.png',
      ),
    ];
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
    ref.read(mainnetNFTLoadedProvider.notifier).state = true;
  }
}
