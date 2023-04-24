// Project imports:
import 'package:ribn/v2/core/constants/assets.dart';

enum AssetType {
  poly(
    abbreviation: 'POLY',
    icon: Assets.cryptoAsset1,
    name: 'Topl',
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
