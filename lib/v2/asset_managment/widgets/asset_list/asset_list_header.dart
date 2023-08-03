// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:ribn/v2/shared/constants/assets.dart';
import 'package:ribn/v2/shared/extensions/build_context_extensions.dart';
import 'package:ribn/v2/shared/widgets/shared/buttons/selectable_text_button.dart';

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
              context.showSnackBar('Implementation Needed');
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
