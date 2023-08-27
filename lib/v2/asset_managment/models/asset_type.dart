// Project imports:
import 'package:ribn/v2/shared/constants/assets.dart';

enum AssetType {
  poly(
    abbreviation: 'POLY',
    icon: Assets.cryptoAsset1,
    name: 'Topl',
  ),
  governance(
    abbreviation: 'TOPL',
    icon: Assets.toplAssetIcon,
    name: 'Topl Governance',
  ),
  transaction(
    abbreviation: 'LVL',
    icon: Assets.toplLvl,
    name: 'Topl Transaction',
  ),
  avalanche(
    abbreviation: 'AVAX',
    icon: Assets.avalancheIcon,
    name: 'Avalanche',
  ),
  polygon(
    abbreviation: 'MATIC',
    icon: Assets.polygonIcon,
    name: 'Polygon',
  ),
  ethereum(
    abbreviation: 'ETH',
    icon: Assets.ethereumIcon,
    name: 'Ethereum',
  ),
  bitcoin(
    abbreviation: 'BTC',
    icon: Assets.bitcoinIcon,
    name: 'Bitcoin',
  );

  const AssetType({
    required this.abbreviation,
    required this.icon,
    required this.name,
  });

  final String abbreviation;
  final String icon;
  final String name;
}
