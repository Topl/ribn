import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ribn/v2/core/models/transaction.dart';
import 'package:ribn/v2/core/providers/transactions/selected_keychain_transaction_provider.dart';
import 'package:ribn/v2/view/widgets/asset_managment/asset_list/asset_list.dart';
import 'package:ribn/v2/view/widgets/asset_managment/asset_screen_header/asset_screen_header.dart';

class AssetManagementScreen extends HookConsumerWidget {
  static const Key assetManagementScreenKey = Key('assetManagementScreenKey');
  const AssetManagementScreen({
    Key key = assetManagementScreenKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<Transaction>> transactions = ref.watch(selectedKeychainTransactionProvider);
    return Container(
      child: transactions.when(
        data: (List<Transaction> transactions) {
          return Column(
            children: [
              AssetScreenHeader(),
              AssetList(
                transactions: transactions,
              ),
            ],
          );
        },
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (Object error, StackTrace stackTrace) => const Center(
          child: Text('QQQQ'),
        ),
      ),
    );
  }
}
