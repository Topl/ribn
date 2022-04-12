import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:ribn/models/asset_details.dart';

/// This class holds custom details about the wallet user.
///
/// For now, the only custom details that the user can add are [assetDetails].
class UserDetailsState {
  /// Holds custom asset details that are locally stored.
  final Map<String, AssetDetails> assetDetails;

  UserDetailsState({
    required this.assetDetails,
  });

  factory UserDetailsState.initial() {
    return UserDetailsState(
      assetDetails: {},
    );
  }

  UserDetailsState copyWith({
    Map<String, AssetDetails>? assetDetails,
  }) {
    return UserDetailsState(
      assetDetails: assetDetails ?? this.assetDetails,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'assetDetails': assetDetails.map((key, value) => MapEntry(key, value.toMap())),
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
    );
  }

  String toJson() => json.encode(toMap());

  factory UserDetailsState.fromJson(String source) => UserDetailsState.fromMap(json.decode(source));

  @override
  String toString() => 'UserDetailsState(assetDetails: $assetDetails)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserDetailsState && mapEquals(other.assetDetails, assetDetails);
  }

  @override
  int get hashCode => assetDetails.hashCode;
}
