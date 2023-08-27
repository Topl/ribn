// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ribn/v2/asset_managment/widgets/asset_list/asset_list_item.dart';

// Project imports:
import 'package:ribn/v2/shared/constants/colors.dart';
import 'package:ribn/v2/shared/extensions/build_context_extensions.dart';
import 'package:ribn/v2/asset_managment/models/asset_details.dart';
import 'package:ribn/v2/asset_managment/providers/transactions/selected_network_assets_provider.dart';
import 'package:ribn/v2/shared/theme.dart';

class AssetList extends HookConsumerWidget {
  const AssetList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<AssetDetails>> assets = ref.watch(selectedNetworkAssetProvider);

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
          bottom: 40,
        ),
        child: assets.when(
          data: (data) {
            return Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    itemCount: data.length,
                    padding: EdgeInsets.only(
                      top: 10,
                      left: 10,
                      right: 10,
                    ),
                    separatorBuilder: (context, index) => SizedBox(
                      height: 20,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      final AssetDetails asset = data[index];
                      return AssetListItem(
                        assetName: asset.assetName,
                        assetType: asset.assetType,
                        assetAmount: asset.assetAmount,
                      );
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
                    style: bodyMedium(context),
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
