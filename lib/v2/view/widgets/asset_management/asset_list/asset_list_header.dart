import 'package:flutter/material.dart';
import 'package:ribn/v2/core/constants/assets.dart';
import 'package:ribn/v2/core/utils/ui_utils.dart';
import 'package:ribn/v2/view/widgets/shared/buttons/selectable_text_button.dart';

class AssetListHeader extends StatelessWidget {
  final bool isShowingNfts;
  final Function() onToggleShowNft;
  final Function() onToggleShowCrypto;
  final Function(String searchQuery) onSearch;
  const AssetListHeader({
    required this.isShowingNfts,
    required this.onToggleShowNft,
    required this.onToggleShowCrypto,
    required this.onSearch,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          SelectableTextButton(
            onPressed: () {
              onToggleShowCrypto();
            },
            text: 'Crypto',
            isSelected: !isShowingNfts,
          ),
          SelectableTextButton(
            onPressed: () {
              onToggleShowNft();
            },
            text: 'NFTs',
            isSelected: isShowingNfts,
          ),
          Spacer(),
          IconButton(
            onPressed: () {
              showToast(
                context: context,
                message: 'Implementation Needed',
              );
            },
            icon: Image.asset(
              Assets.searchLogo,
              width: 20,
            ),
          ),
        ],
      ),
    );
  }
}
