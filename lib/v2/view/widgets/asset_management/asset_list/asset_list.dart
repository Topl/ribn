// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:ribn/v2/core/constants/colors.dart';
import 'package:ribn/v2/core/constants/ribn_text_style.dart';
import 'package:ribn/v2/core/extensions/build_context_extensions.dart';
import 'package:ribn/v2/core/models/NFT.dart';
import 'package:ribn/v2/core/models/transaction.dart';
import 'package:ribn/v2/core/providers/nfts/selected_network_nft_provider.dart';
import 'package:ribn/v2/core/providers/transactions/keychain_network_providers/mainnet_transaction_provider.dart';
import 'package:ribn/v2/core/providers/transactions/selected_network_transaction_provider.dart';
import 'package:ribn/v2/view/widgets/asset_management/asset_list/asset_list_header.dart';
import 'package:ribn/v2/view/widgets/asset_management/asset_list/asset_list_item.dart';
import 'package:ribn/v2/view/widgets/asset_management/asset_list/nft_list_item.dart';

class AssetList extends HookConsumerWidget {
  const AssetList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(() {
      return () {
        ref.read(mainnetTransactionLoadedProvider.notifier).state = false;
      };
    }, const []);
    final isShowingNfts = useState(false);

    final AsyncValue<List<dynamic>> assets =
        isShowingNfts.value ? ref.watch(selectedNetworkNFTProvider) : ref.watch(selectedNetworkTransactionProvider);

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
          left: 10,
          right: 10,
          bottom: 15,
        ),
        child: assets.when(
          data: (data) {
            return Column(
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
                    itemCount: data.length,
                    padding: EdgeInsets.only(
                      top: 10,
                      left: 10,
                      right: 10,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      if (isShowingNfts.value) {
                        final NFT nft = data[index];
                        return NFTListItem(
                          assetName: nft.assetName,
                          assetUrl: nft.assetUrl,
                        );
                      } else {
                        final Transaction transaction = data[index];
                        return AssetListItem(
                          assetName: transaction.assetName,
                          assetType: transaction.assetType,
                          assetAmount: transaction.assetAmount,
                        );
                      }
                    },
                  ),
                ),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      minimumSize: Size.fromHeight(40),
                      side: BorderSide(
                        color: RibnColors.grey,
                        width: 1,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding: EdgeInsets.all(15)),
                  onPressed: () {
                    context.showSnackBar('Needs Implementation');
                  },
                  child: Text(
                    'See all assets',
                    style: RibnTextStyle.h3,
                  ),
                ),
              ],
            );
          },
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
          error: (error, stackTrace) => const Center(
            child: Text('Error'),
          ),
        ));
  }
}
