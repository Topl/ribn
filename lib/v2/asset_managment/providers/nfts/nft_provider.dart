// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ribn/v2/asset_managment/models/NFT.dart';

final mainnetNFTNotifierProvider = StateNotifierProvider.autoDispose<MainnetNFTProvider, AsyncValue<List<NFT>>>((ref) {
  return MainnetNFTProvider(ref);
});

class MainnetNFTProvider extends StateNotifier<AsyncValue<List<NFT>>> {
  final Ref ref;
  MainnetNFTProvider(this.ref) : super(AsyncLoading()) {
    getNFTs();
  }

  Future<void> getNFTs() async {
    state = AsyncData(
      [
        NFT(
          assetName: 'Whimsical Octoplus Oasis Club',
          assetUrl: 'assets/v2/icons/octoplus.png',
        ),
      ],
    );
  }

  Future<List<NFT>> refreshNFTs() {
    // TODO: implement refreshNFTs
    throw UnimplementedError();
  }

  Stream<List<NFT>> streamNFTs() {
    // TODO: implement streamNFTs
    throw UnimplementedError();
  }
}
