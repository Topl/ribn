// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:ribn/v2/core/models/transaction.dart';

final searchTransactionNotifierProvider =
    StateNotifierProvider.autoDispose<SearchTransactionNotifier, AsyncValue<List<Transaction>>>((ref) {
  return SearchTransactionNotifier();
});

class SearchTransactionNotifier extends StateNotifier<AsyncValue<List<Transaction>>> {
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
