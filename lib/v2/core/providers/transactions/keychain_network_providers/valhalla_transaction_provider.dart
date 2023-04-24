// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:ribn/v2/core/models/transaction.dart';
import 'package:ribn/v2/core/providers/transactions/keychain_network_providers/transaction_provider_class.dart';

final valhallaTransactionLoadedProvider = StateProvider.autoDispose<bool>((ref) {
  return false;
});

final valhallaTransactionNotifierProvider =
    StateNotifierProvider.autoDispose<ValhallaTransactionProvider, AsyncValue<List<Transaction>>>((ref) {
  return ValhallaTransactionProvider(ref);
});

class ValhallaTransactionProvider extends TransactionNotifier {
  final Ref ref;
  ValhallaTransactionProvider(this.ref) : super();

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

  @override
  void onProviderLoad() {
    ref.read(valhallaTransactionLoadedProvider.notifier).state = true;
  }
}
