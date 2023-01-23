// ignore_for_file: public_member_api_docs, sort_constructors_first

// Dart imports:
import 'dart:convert';

// Flutter imports:
import 'package:flutter/foundation.dart';

// Project imports:
import 'package:ribn/models/asset_details.dart';

/// This class holds custom details about the wallet user.
///
/// For now, the only custom details that the user can add are [assetDetails].
class UserDetailsState {
  /// Holds custom asset details that are locally stored.
  final Map<String, AssetDetails> assetDetails;
  final bool isBiometricsEnabled;

  UserDetailsState({
    required this.assetDetails,
    required this.isBiometricsEnabled,
  });

  factory UserDetailsState.initial() {
    return UserDetailsState(
      assetDetails: {},
      isBiometricsEnabled: false,
    );
  }

  UserDetailsState copyWith({
    Map<String, AssetDetails>? assetDetails,
    bool? isBiometricsEnabled,
  }) {
    return UserDetailsState(
      assetDetails: assetDetails ?? this.assetDetails,
      isBiometricsEnabled: isBiometricsEnabled ?? this.isBiometricsEnabled,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'assetDetails':
          assetDetails.map((key, value) => MapEntry(key, value.toMap())),
      'isBiometricsEnabled': isBiometricsEnabled,
    };
  }

  factory UserDetailsState.fromMap(Map<String, dynamic> map) {
    return UserDetailsState(
      assetDetails: Map<String, AssetDetails>.from(
        (map['assetDetails'] as Map<String, dynamic>).map(
          (key, value) => MapEntry(
            key,
            AssetDetails.fromMap(value),
          ),
        ),
      ),
      isBiometricsEnabled: map['isBiometricsEnabled'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserDetailsState.fromJson(String source) =>
      UserDetailsState.fromMap(json.decode(source));

  @override
  String toString() =>
      'UserDetailsState(assetDetails: $assetDetails, isBiometricsEnabled: $isBiometricsEnabled)';

  @override
  bool operator ==(covariant UserDetailsState other) {
    if (identical(this, other)) return true;

    return mapEquals(other.assetDetails, assetDetails) &&
        other.isBiometricsEnabled == isBiometricsEnabled;
  }

  @override
  int get hashCode => assetDetails.hashCode ^ isBiometricsEnabled.hashCode;
}
