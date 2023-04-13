import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ribn/v2/core/constants/colors.dart';
import 'package:ribn/v2/core/models/transaction.dart';
import 'package:ribn/v2/view/widgets/asset_management/asset_list/asset_list_header.dart';
import 'package:ribn/v2/view/widgets/asset_management/asset_list/asset_list_item.dart';

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
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        color: RibnColors.whiteBackground,
      ),
      padding: EdgeInsets.only(
        top: 10,
        left: 5,
        right: 5,
      ),
      child: Column(
        children: [
          AssetListHeader(
            isShowingNfts: isShowingNfts.value,
            onToggleShowNft: () {
              isShowingNfts.value = true;
            },
            onToggleShowCrypto: () {
              isShowingNfts.value = false;
            },
            onSearch: (String searchQuery) {
              print(searchQuery);
            },
          ),
          Expanded(
            child: ListView.builder(
              itemCount: transactions.length,
              padding: EdgeInsets.only(
                top: 10,
                left: 10,
                right: 10,
              ),
              itemBuilder: (BuildContext context, int index) {
                final Transaction transaction = transactions[index];
                return AssetListItem(
                  assetName: transaction.assetName,
                  assetType: transaction.assetType,
                  assetAmount: transaction.assetAmount,
                );
              },
            ),
          ),
          OutlinedButton(
            style: ButtonStyle(),
            onPressed: () {},
            child: Text('See all assets'),
          ),
        ],
      ),
    );
  }
}
