import 'package:flutter/material.dart';

enum AssetType {
  poly(
    abbreviation: 'POLY',
    iconData: Icon(null),
    name: 'Topl',
  );

  const AssetType({
    required this.abbreviation,
    required this.iconData,
    required this.name,
  });

  final String abbreviation;
  final Icon iconData;
  final String name;
}
