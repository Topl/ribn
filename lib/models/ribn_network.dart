// ignore_for_file: implementation_imports
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:mubrambl/src/core/client.dart';
import 'package:ribn/constants/rules.dart';
import 'package:ribn/models/ribn_address.dart';

class RibnNetwork {
  final int networkId;
  final String networkUrl;
  final List<RibnAddress> addresses;
  final BramblClient? client;

  RibnNetwork({
    required this.networkId,
    required this.networkUrl,
    this.addresses = const [],
    this.client,
  });

  factory RibnNetwork.initial({int? networkId, String? networkUrl}) {
    return RibnNetwork(
      networkId: networkId ?? Rules.valhallaId,
      networkUrl: networkUrl ?? Rules.networkUrls[Rules.valhallaId]!,
      client: Rules.getBramblCient(
        networkUrl ?? Rules.networkUrls[Rules.valhallaId]!,
      ),
    );
  }

  int getNextExternalAddressIndex() {
    return addresses.lastIndexWhere((addr) => addr.changeIndex == Rules.defaultChangeIndex) + 1;
  }

  static List<RibnNetwork> initializeNetworks() {
    return <RibnNetwork>[
      RibnNetwork.initial(),
      RibnNetwork.initial(networkId: Rules.toplnetId, networkUrl: Rules.networkUrls[Rules.toplnetId]),
      RibnNetwork.initial(networkId: Rules.privateId, networkUrl: Rules.networkUrls[Rules.privateId]),
    ];
  }

  RibnNetwork copyWith({
    int? networkId,
    String? networkUrl,
    List<RibnAddress>? addresses,
    BramblClient? client,
  }) {
    return RibnNetwork(
      networkId: networkId ?? this.networkId,
      networkUrl: networkUrl ?? this.networkUrl,
      addresses: addresses ?? this.addresses,
      client: client ?? this.client,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'networkId': networkId,
      'networkUrl': networkUrl,
      'addresses': addresses.map((x) => x.toMap()).toList(),
    };
  }

  factory RibnNetwork.fromMap(Map<String, dynamic> map) {
    return RibnNetwork(
      networkId: map['networkId'],
      networkUrl: map['networkUrl'],
      addresses: List<RibnAddress>.from(map['addresses']?.map((x) => RibnAddress.fromMap(x))),
      client: Rules.getBramblCient(map['networkUrl']),
    );
  }

  String toJson() => json.encode(toMap());

  factory RibnNetwork.fromJson(String source) => RibnNetwork.fromMap(json.decode(source));

  @override
  String toString() {
    return 'RibnNetwork(networkId: $networkId, networkUrl: $networkUrl, addresses: $addresses, client: $client)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RibnNetwork &&
        other.networkId == networkId &&
        other.networkUrl == networkUrl &&
        listEquals(other.addresses, addresses) &&
        other.client == client;
  }

  @override
  int get hashCode {
    return networkId.hashCode ^ networkUrl.hashCode ^ addresses.hashCode ^ client.hashCode;
  }
}
