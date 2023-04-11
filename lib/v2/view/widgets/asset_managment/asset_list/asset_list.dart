import 'package:flutter/material.dart';
import 'package:ribn/v2/core/models/transaction.dart';
import 'package:ribn/v2/view/widgets/asset_managment/asset_list/asset_list_item.dart';

class AssetList extends StatelessWidget {
  final List<Transaction> transactions;
  const AssetList({
    required this.transactions,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (BuildContext context, int index) {
              final Transaction transaction = transactions[index];
              return AssetListItem(
                assetName: transaction.assetName,
                assetType: transaction.assetType,
              );
            },
          ),
        ],
      ),
    );
  }
}
