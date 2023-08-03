// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:ribn/v2/asset_managment/models/NFT.dart';

final searchNftNotifierProvider = StateNotifierProvider.autoDispose<SearchNftNotifier, AsyncValue<List<NFT>>>((ref) {
  return SearchNftNotifier();
});

class SearchNftNotifier extends StateNotifier<AsyncValue<List<NFT>>> {
  SearchNftNotifier() : super(AsyncLoading());

  /// TODO SDK - Implement searchNfts
  Future<void> searchNFTs(String query) async {
    state = AsyncLoading();
    try {} catch (e) {}
  }

  /// Clears the search results
  void clearSearch() {
    state = AsyncData([]);
  }
}
