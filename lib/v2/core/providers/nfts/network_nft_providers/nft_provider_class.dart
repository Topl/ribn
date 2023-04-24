// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:ribn/v2/core/models/NFT.dart';

abstract class NFTNotifier extends StateNotifier<AsyncValue<List<NFT>>> {
  NFTNotifier() : super(AsyncLoading()) {
    getNFTs().then((value) {
      state = AsyncData(value);
    });
  }

  void onProviderLoad();

  Future<List<NFT>> getNFTs();

  Future<List<NFT>> refreshNFTs();

  Stream<List<NFT>> streamNFTs();
}
