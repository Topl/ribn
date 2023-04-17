// Dart imports:
import 'dart:convert';

// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:bip_topl/bip_topl.dart' as bip_topl;
import 'package:brambldart/credentials.dart';

// Project imports:
import 'package:ribn/v1/constants/network_utils.dart';
import 'package:ribn/v1/constants/rules.dart';
import 'package:ribn/v1/constants/test_data.dart';
import 'package:ribn/v1/models/ribn_network.dart';

@immutable
class KeychainState {
  /// The encrypted Topl Main Key as json. Can be null, e.g. before onboarding.
  final String? keyStoreJson;

  /// An HdWallet helper to derive child keys.
  final HdWallet? hdWallet;

  /// Networks supported by Ribn, with the networkName as key and [RibnNetwork] as value.
  final Map<String, RibnNetwork> networks;

  /// The name of the current network.
  final String currentNetworkName;

  /// Gets the current [RibnNetwork].
  RibnNetwork get currentNetwork => networks[currentNetworkName]!;

  /// Gets all supported [RibnNetwork]s.
  List<RibnNetwork> get allNetworks => networks.values.toList();

  const KeychainState({
    this.keyStoreJson,
    this.hdWallet,
    required this.networks,
    required this.currentNetworkName,
  });

  factory KeychainState.initial() {
    return KeychainState(
      currentNetworkName: NetworkUtils.valhalla,
      networks: Map.unmodifiable(RibnNetwork.initializeToplNetworks()),
    );
  }

  factory KeychainState.test() {
    return KeychainState(
      keyStoreJson: TestData.keyStoreJson,
      currentNetworkName: NetworkUtils.valhalla,
      networks: Map.unmodifiable(RibnNetwork.initializeToplNetworks()),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'keyStoreJson': keyStoreJson,
      'currentNetworkName': currentNetworkName,
      'networks': networks.map((String key, RibnNetwork value) => MapEntry(key, value.toMap())),
    };
  }

  factory KeychainState.fromMap(Map<String, dynamic> map) {
    return KeychainState(
      keyStoreJson: map['keyStoreJson'] as String?,
      currentNetworkName: map['currentNetworkName'] as String,
      hdWallet: map['toplKey'] != null
          ? HdWallet(
              rootSigningKey: bip_topl.Bip32SigningKey.fromValidBytes(
                bip_topl.Base58Encoder.instance.decode(map['toplKey']),
                depth: Rules.toplKeyDepth,
              ),
            )
          : null,
      networks: Map<String, RibnNetwork>.unmodifiable(
        (map['networks'] as Map<String, dynamic>).map(
          (key, value) => MapEntry(
            key,
            RibnNetwork.fromMap(value as Map<String, dynamic>),
          ),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory KeychainState.fromJson(String source) => KeychainState.fromMap(json.decode(source));

  @override
  String toString() {
    return 'KeychainState(keyStoreJson: $keyStoreJson, hdWallet: $hdWallet, networks: $networks, currentNetworkName: $currentNetworkName)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is KeychainState &&
        other.keyStoreJson == keyStoreJson &&
        other.hdWallet == hdWallet &&
        mapEquals(other.networks, networks) &&
        other.currentNetworkName == currentNetworkName;
  }

  @override
  int get hashCode {
    return keyStoreJson.hashCode ^ hdWallet.hashCode ^ networks.hashCode ^ currentNetworkName.hashCode;
  }

  KeychainState copyWith({
    String? keyStoreJson,
    HdWallet? hdWallet,
    Map<String, RibnNetwork>? networks,
    String? currentNetworkName,
  }) {
    return KeychainState(
      keyStoreJson: keyStoreJson ?? this.keyStoreJson,
      hdWallet: hdWallet ?? this.hdWallet,
      networks: networks ?? this.networks,
      currentNetworkName: currentNetworkName ?? this.currentNetworkName,
    );
  }
}
