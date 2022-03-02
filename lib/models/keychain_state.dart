import 'dart:convert';
import 'dart:typed_data';
import 'package:bip_topl/bip_topl.dart' as t;
import 'package:brambldart/credentials.dart';
import 'package:flutter/foundation.dart';
import 'package:ribn/constants/rules.dart';
import 'package:ribn/constants/test_data.dart';
import 'package:ribn/models/ribn_network.dart';

class KeychainState {
  final String? keyStoreJson;
  final HdWallet? hdWallet; // never persisted
  final List<RibnNetwork> networks;
  final int currNetworkIdx;

  RibnNetwork get currentNetwork => networks[currNetworkIdx];

  KeychainState({
    this.keyStoreJson,
    this.hdWallet,
    required this.networks,
    required this.currNetworkIdx,
  });

  factory KeychainState.initial() {
    final List<RibnNetwork> initialNetworks = RibnNetwork.initializeNetworks();
    return KeychainState(
      networks: initialNetworks,
      currNetworkIdx: 0,
    );
  }

  factory KeychainState.test() {
    final Uint8List toplExtendedPrvKeyUint8List = TestData.toplExtendedPrvKeyUint8List;
    final List<RibnNetwork> initialNetworks = RibnNetwork.initializeNetworks();
    return KeychainState(
      keyStoreJson: TestData.keyStoreJson,
      networks: initialNetworks,
      currNetworkIdx: 0,
      hdWallet: HdWallet(
        rootSigningKey: t.Bip32SigningKey.fromValidBytes(
          toplExtendedPrvKeyUint8List,
          depth: Rules.toplKeyDepth,
        ),
      ),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'keyStoreJson': keyStoreJson,
      'networks': networks.map((x) => x.toMap()).toList(),
      'currNetworkIdx': currNetworkIdx,
    };
  }

  factory KeychainState.fromMap(Map<String, dynamic> map) {
    return KeychainState(
      keyStoreJson: map['keyStoreJson'] as String?,
      networks: List<RibnNetwork>.from(
          (map['networks'] as Iterable<dynamic>).map((x) => RibnNetwork.fromMap(x as Map<String, dynamic>))),
      currNetworkIdx: map['currNetworkIdx'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory KeychainState.fromJson(String source) => KeychainState.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'KeychainState(keyStoreJson: $keyStoreJson, hdWallet: $hdWallet, networks: $networks, currNetworkIdx: $currNetworkIdx)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is KeychainState &&
        other.keyStoreJson == keyStoreJson &&
        other.hdWallet == hdWallet &&
        listEquals(other.networks, networks) &&
        other.currNetworkIdx == currNetworkIdx;
  }

  @override
  int get hashCode {
    return keyStoreJson.hashCode ^ hdWallet.hashCode ^ networks.hashCode ^ currNetworkIdx.hashCode;
  }

  KeychainState copyWith({
    String? keyStoreJson,
    HdWallet? hdWallet,
    List<RibnNetwork>? networks,
    int? currNetworkIdx,
  }) {
    return KeychainState(
      keyStoreJson: keyStoreJson ?? this.keyStoreJson,
      hdWallet: hdWallet ?? this.hdWallet,
      networks: networks ?? this.networks,
      currNetworkIdx: currNetworkIdx ?? this.currNetworkIdx,
    );
  }
}
