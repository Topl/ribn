import 'package:flutter/material.dart';
import 'package:ribn/constants/assets.dart';

class UIConstants {
  static const sizedBox = SizedBox(height: 10);
  static const bigSizedBox = SizedBox(height: 20);
  static const double smallTextSize = 12;
  static const double generalPadding = 12;
  static const double textFieldSize = 200;
  static const double maxWidth = 200;
  static const double loginTextFieldWidth = 420;
  static const double addressListTileSize = 40;
  static const List<String> assetUnitsList = [
    'G - Gram',
    'Kg - Kilogram',
    'Oz - Ounce',
    'L - Liter',
    'Bbl - Barrel',
  ];
  static const List<String> assetIconsList = [
    RibnAssets.coffGreenIcon,
    RibnAssets.coffYellowIcon,
    RibnAssets.coffPurpleIcon,
    RibnAssets.coffBlueIcon,
    RibnAssets.diaGreenIcon,
    RibnAssets.diaYellowIcon,
    RibnAssets.diaPurpleIcon,
    RibnAssets.diaBlueIcon,
  ];
}
