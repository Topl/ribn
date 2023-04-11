import 'package:flutter/material.dart';

class AssetListHeader extends StatelessWidget {
  final bool isShowingNfts;
  final Function() onCryptoNftToggle;
  final Function(String searchQuery) onSearch;
  const AssetListHeader({
    required this.isShowingNfts,
    required this.onCryptoNftToggle,
    required this.onSearch,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          TextButton(
            onPressed: () {},
            child: Text(
              'Crypto',
            ),
          ),
          TextButton(
            onPressed: () {},
            child: Text(
              'NFTs',
            ),
          ),
          Spacer(),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search),
          ),
        ],
      ),
    );
  }
}
