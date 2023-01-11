import 'dart:convert';

/// User defined asset details.
class AssetDetails {
  /// The long name assigned to the asset.
  final String? longName;

  /// The custom icon assigned to the asset; see [UIConstants.assetIconsList]
  final String? icon;

  /// The cusotm unit that's assigned to the asset; see [UIConstants.assetUnitsList].
  final String? unit;

  AssetDetails({
    this.longName,
    this.icon,
    this.unit,
  });

  AssetDetails copyWith({
    String? longName,
    String? icon,
    String? unit,
  }) {
    return AssetDetails(
      longName: longName ?? this.longName,
      icon: icon ?? this.icon,
      unit: unit ?? this.unit,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'longName': longName,
      'icon': icon,
      'unit': unit,
    };
  }

  factory AssetDetails.fromMap(Map<String, dynamic> map) {
    return AssetDetails(
      longName: map['longName'],
      icon: map['icon'],
      unit: map['unit'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AssetDetails.fromJson(String source) =>
      AssetDetails.fromMap(json.decode(source));

  @override
  String toString() =>
      'AssetDetails(longName: $longName, icon: $icon, unit: $unit)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AssetDetails &&
        other.longName == longName &&
        other.icon == icon &&
        other.unit == unit;
  }

  @override
  int get hashCode => longName.hashCode ^ icon.hashCode ^ unit.hashCode;
}
