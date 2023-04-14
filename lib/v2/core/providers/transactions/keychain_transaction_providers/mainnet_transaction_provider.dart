import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ribn/v2/core/models/asset_type.dart';
import 'package:ribn/v2/core/models/transaction.dart';
import 'package:ribn/v2/core/providers/transactions/keychain_transaction_providers/transaction_provider_class.dart';

final mainnetTransactionLoadedProvider = StateProvider.autoDispose<bool>((ref) {
  ref.onDispose(() {});
  return false;
});

final mainnetTransactionNotifierProvider =
    StateNotifierProvider.autoDispose<MainnetTransactionProvider, AsyncValue<List<Transaction>>>((ref) {
  return MainnetTransactionProvider(ref);
});

class MainnetTransactionProvider extends TransactionNotifier {
  final Ref ref;
  MainnetTransactionProvider(this.ref) : super();

  @override
  Future<List<Transaction>> getTransactions() async {
    return [
      Transaction(
        assetName: 'Topl',
        assetType: AssetType.poly,
        assetAmount: 69,
      )
    ];
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
    ref.read(mainnetTransactionLoadedProvider.notifier).state = true;
  }
}
