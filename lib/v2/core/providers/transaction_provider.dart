import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ribn/v2/core/models/transaction.dart';

final transactionNotifierProvider = StateNotifierProvider<TransactionNotifier, List<Transaction>>((ref) {
  return TransactionNotifier(ref);
});

class TransactionNotifier extends StateNotifier<List<Transaction>> {
  final Ref ref;
  TransactionNotifier(this.ref) : super([]);
}
