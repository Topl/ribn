import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ribn/v2/core/models/transaction.dart';

// QQQQ TODO - Should this even be called transactions? Maybe it should be called crypto
abstract class TransactionNotifier extends StateNotifier<AsyncValue<List<Transaction>>> {
  TransactionNotifier() : super(AsyncLoading()) {
    getTransactions().then((value) {
      state = AsyncData(value);
    });
  }

  Future<List<Transaction>> getTransactions();

  Future<List<Transaction>> refreshTransactions();

  Stream<List<Transaction>> streamTransactions();

  void onProviderLoad();
}
