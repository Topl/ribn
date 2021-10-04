import 'package:flutter/material.dart';

class UIConstants {
  static const sizedBox = SizedBox(height: 10);
  static const bigSizedBox = SizedBox(height: 20);
  static const double smallTextSize = 12;
  static const double generalPadding = 12;
  static const double textFieldSize = 200;
  static const double maxWidth = 200;
  static const double loginTextFieldWidth = 300;
  static const int mnemonicTileCrossAxisCount = 4;
  static const double mnemonicTileMaxWidth = 250;
  static const double mnemonicTileMaxHeight = 200;
  static const double mnemonicDisplayDimensions = 150;
  static const double addressListTileSize = 40;
  static scaleByWidth(double scale, BuildContext context) => scale * MediaQuery.of(context).size.width;
  static double displayAddressWidth(BuildContext context) => scaleByWidth(0.5, context) as double;
}
