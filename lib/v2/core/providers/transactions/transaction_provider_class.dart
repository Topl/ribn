import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ribn/v2/core/models/transaction.dart';

abstract class TransactionNotifier extends StateNotifier<AsyncValue<List<Transaction>>> {
  TransactionNotifier() : super(AsyncLoading()) {
    getTransactions().then((value) {
      state = AsyncData(value);
    });
  }

  Future<List<Transaction>> getTransactions();

  Future<List<Transaction>> refreshTransactions();

  Stream<List<Transaction>> streamTransactions();
}
