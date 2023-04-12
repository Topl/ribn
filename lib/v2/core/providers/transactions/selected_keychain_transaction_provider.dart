import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ribn/v2/core/models/keychain.dart';
import 'package:ribn/v2/core/models/transaction.dart';
import 'package:ribn/v2/core/providers/keychain/selected_keychain_provider.dart';
import 'package:ribn/v2/core/providers/transactions/keychain_transaction_providers/mainnet_transaction_provider.dart';
import 'package:ribn/v2/core/providers/transactions/keychain_transaction_providers/private_transaction_provider.dart';
import 'package:ribn/v2/core/providers/transactions/keychain_transaction_providers/valhalla_transaction_provider.dart';

final selectedKeychainTransactionProvider = Provider.autoDispose<AsyncValue<List<Transaction>>>((ref) {
  print('QQQQ here 1');
  final Keychain selectedKeychain = ref.watch(selectedKeychainNotifierProvider);
  print('QQQQ here 2');
  switch (selectedKeychain) {
    case Keychain.topl_mainnet:
      return ref.watch(mainnetTransactionNotifierProvider);
    case Keychain.valhalla_testnet:
      return ref.watch(valhallaTransactionNotifierProvider);
    case Keychain.private_network:
      return ref.watch(privateTransactionNotifierProvider);
  }
});
