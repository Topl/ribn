// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:ribn/v2/asset_managment/models/NFT.dart';
import 'package:ribn/v2/asset_managment/providers/nfts/network_nft_providers/nft_provider_class.dart';

final valhallaNFTLoadedProvider = StateProvider.autoDispose<bool>((ref) {
  return false;
});

final valhallaNFTNotifierProvider =
    StateNotifierProvider.autoDispose<valhallaNFTProvider, AsyncValue<List<NFT>>>((ref) {
  return valhallaNFTProvider(ref);
});

class valhallaNFTProvider extends NFTNotifier {
  final Ref ref;
  valhallaNFTProvider(this.ref) : super();

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
    ref.read(valhallaNFTLoadedProvider.notifier).state = true;
  }
}
