import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ribn/v2/shared/theme.dart';

import '../../shared/constants/assets.dart';
import '../models/asset_details.dart';
import 'asset_card.dart';

final assets = [
  AssetDetails(
    name: 'Topl Transaction',
    symbol: "TPL",
    icon: SvgPicture.asset(Assets.toplAssetIcon),
  ),
  AssetDetails(
    name: 'Topl Governance',
    symbol: "TOPL",
    icon: SvgPicture.asset(Assets.toplAssetIcon),
  ),
  AssetDetails(
    name: 'Avalanche',
    symbol: "AVAX",
    icon: SvgPicture.asset(Assets.avalancheIcon),
  ),
  AssetDetails(
    name: 'Polygon',
    symbol: "MATIC",
    icon: SvgPicture.asset(Assets.polygonIcon),
  ),
  AssetDetails(
    name: 'Ethereum',
    symbol: "ETH",
    icon: SvgPicture.asset(Assets.ethereumIcon),
  ),
  AssetDetails(
    name: 'Bitcoin',
    symbol: "BTC",
    icon: SvgPicture.asset(Assets.bitcoinIcon),
  )
];

class SelectAssetsScreen extends StatelessWidget {
  const SelectAssetsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Receive",
            style: headlineLarge(context),
          ),
          SizedBox(height: 16),
          Text(
            "Choose an asset",
            style: bodyMedium(context),
          ),
          SizedBox(height: 5),
          SearchBar(
            leading: SvgPicture.asset('assets/v2/icons/search_logo.svg'),
            padding: MaterialStateProperty.all(
              EdgeInsets.symmetric(horizontal: 12),
            ),
            constraints: BoxConstraints(
              minHeight: 40,
            ),
            hintText: "Search",
            hintStyle: MaterialStateProperty.all(
              labelLarge(context),
            ),
            elevation: MaterialStateProperty.all(1),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(
                  color: Color(0xFFE2E3E3),
                ),
              ),
            ),
            shadowColor: MaterialStateProperty.all(Colors.transparent),
            onChanged: (value) {
              //TODO: implement search
              print(value);
            },
          ),
          SizedBox(height: 16),
          ListView.separated(
            scrollDirection: Axis.vertical,
            separatorBuilder: (context, index) => SizedBox(height: 16),
            shrinkWrap: true,
            itemCount: assets.length,
            itemBuilder: (context, index) {
              return AssetCard(
                assetName: assets[index].name,
                assetIcon: assets[index].icon,
                assetShortName: assets[index].symbol,
              );
            },
          ),
        ],
      ),
    );
  }
}
