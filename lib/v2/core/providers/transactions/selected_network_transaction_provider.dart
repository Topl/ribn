// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:ribn/v2/core/models/network.dart';
import 'package:ribn/v2/core/models/transaction.dart';
import 'package:ribn/v2/core/providers/network/selected_network_provider.dart';
import 'package:ribn/v2/core/providers/transactions/keychain_network_providers/mainnet_transaction_provider.dart';
import 'package:ribn/v2/core/providers/transactions/keychain_network_providers/private_transaction_provider.dart';
import 'package:ribn/v2/core/providers/transactions/keychain_network_providers/valhalla_transaction_provider.dart';

final selectedNetworkTransactionProvider = Provider.autoDispose<AsyncValue<List<Transaction>>>((ref) {
  final Network selectedKeychain = ref.watch(selectedNetworkNotifierProvider);
  switch (selectedKeychain) {
    case Network.topl_mainnet:
      return ref.watch(mainnetTransactionNotifierProvider);
    case Network.valhalla_testnet:
      return ref.watch(valhallaTransactionNotifierProvider);
    case Network.private_network:
      return ref.watch(privateTransactionNotifierProvider);
  }
});
