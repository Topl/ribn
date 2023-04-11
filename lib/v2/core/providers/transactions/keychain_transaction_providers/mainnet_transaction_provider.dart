import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ribn/v2/core/models/transaction.dart';
import 'package:ribn/v2/core/providers/transactions/transaction_provider_class.dart';

final mainnetTransactionNotifierProvider =
    StateNotifierProvider.autoDispose<MainnetTransactionProvider, AsyncValue<List<Transaction>>>((ref) {
  return MainnetTransactionProvider(ref);
});

class MainnetTransactionProvider extends TransactionNotifier {
  final Ref ref;
  MainnetTransactionProvider(this.ref) : super();

  @override
  Future<List<Transaction>> getTransactions() {
    // TODO: implement getTransactions
    throw UnimplementedError();
  }

  @override
  Future<List<Transaction>> refreshTransactions() {
    // TODO: implement refreshTransactions
    throw UnimplementedError();
  }

  @override
  Stream<List<Transaction>> streamTransactions() {
    // TODO: implement streamTransactions
    throw UnimplementedError();
  }
}
