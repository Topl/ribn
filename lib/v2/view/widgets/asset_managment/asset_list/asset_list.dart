import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ribn/v2/core/models/transaction.dart';
import 'package:ribn/v2/view/widgets/asset_managment/asset_list/asset_list_header.dart';
import 'package:ribn/v2/view/widgets/asset_managment/asset_list/asset_list_item.dart';

class AssetList extends HookWidget {
  final List<Transaction> transactions;
  const AssetList({
    required this.transactions,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isShowingNfts = useState(false);

    return Container(
      child: Column(
        children: [
          AssetListHeader(
            isShowingNfts: isShowingNfts.value,
            onCryptoNftToggle: () {
              isShowingNfts.value = !isShowingNfts.value;
            },
            onSearch: (String searchQuery) {
              print(searchQuery);
            },
          ),
          ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (BuildContext context, int index) {
              final Transaction transaction = transactions[index];
              return AssetListItem(
                assetName: transaction.assetName,
                assetType: transaction.assetType,
                assetAmount: transaction.assetAmount,
              );
            },
          ),
        ],
      ),
    );
  }
}
