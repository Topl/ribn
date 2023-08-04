// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:ribn/v2/asset_managment/models/transaction.dart';

// TODO SDK - Should this even be called transactions? Maybe it should be called crypto
abstract class TransactionNotifier extends StateNotifier<AsyncValue<List<Transaction>>> {
  TransactionNotifier() : super(AsyncLoading()) {
    getTransactions().then((value) {
      state = AsyncData(value);
      onProviderLoad();
    });
  }

  Future<List<Transaction>> getTransactions();

  Future<List<Transaction>> refreshTransactions();

  Stream<List<Transaction>> streamTransactions();

  void onProviderLoad();
}