import 'dart:convert';
import 'dart:typed_data';

import 'package:bip_topl/bip_topl.dart' as bip_topl;
import 'package:brambldart/credentials.dart';
import 'package:flutter/foundation.dart';

import 'package:ribn/constants/network_utils.dart';
import 'package:ribn/constants/rules.dart';
import 'package:ribn/constants/test_data.dart';
import 'package:ribn/models/ribn_network.dart';

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
    final Uint8List toplExtendedPrvKeyUint8List = TestData.toplExtendedPrvKeyUint8List;
    return KeychainState(
      keyStoreJson: TestData.keyStoreJson,
      currentNetworkName: NetworkUtils.valhalla,
      hdWallet: HdWallet(
        rootSigningKey: bip_topl.Bip32SigningKey.fromValidBytes(
          toplExtendedPrvKeyUint8List,
          depth: Rules.toplKeyDepth,
        ),
      ),
      networks: Map.unmodifiable(RibnNetwork.initializeToplNetworks()),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'keyStoreJson': keyStoreJson,
      'currentNetworkId': currentNetworkName,
      'networks': networks.map((key, value) => MapEntry(key, value.toMap())),
    };
  }

  factory KeychainState.fromMap(Map<String, dynamic> map) {
    return KeychainState(
      keyStoreJson: map['keyStoreJson'] as String?,
      currentNetworkName: map['currentNetworkName'] as String,
      networks: Map<String, RibnNetwork>.from(
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
