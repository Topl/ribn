// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ribn/v2/asset_managment/models/asset_details.dart';

// Project imports:

final searchTransactionNotifierProvider =
    StateNotifierProvider.autoDispose<SearchTransactionNotifier, AsyncValue<List<AssetDetails>>>((ref) {
  return SearchTransactionNotifier();
});

class SearchTransactionNotifier extends StateNotifier<AsyncValue<List<AssetDetails>>> {
  SearchTransactionNotifier() : super(AsyncLoading());

  /// TODO SDK - Implement searchTransactions
  Future<void> searchTransactions(String query) async {
    state = AsyncLoading();
    try {} catch (e) {}
  }

  /// Clears the search results
  void clearSearch() {
    state = AsyncData([]);
  }
}
