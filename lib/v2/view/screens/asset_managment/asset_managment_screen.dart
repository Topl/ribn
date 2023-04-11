import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ribn/v2/core/models/transaction.dart';
import 'package:ribn/v2/core/providers/transaction_provider.dart';
import 'package:ribn/v2/view/widgets/asset_managment/asset_list/asset_list.dart';
import 'package:ribn/v2/view/widgets/asset_managment/asset_screen_header/asset_screen_header.dart';

class AssetManagementScreen extends HookConsumerWidget {
  static const Key assetManagementScreenKey = Key('assetManagementScreenKey');
  const AssetManagementScreen({
    Key key = assetManagementScreenKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Transaction> transactions = ref.watch(transactionNotifierProvider);
    return Container(
      child: Column(
        children: [
          AssetScreenHeader(),
          AssetList(
            transactions: transactions,
          ),
        ],
      ),
    );
  }
}
