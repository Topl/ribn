// ignore_for_file: implementation_imports
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:mubrambl/brambldart.dart';
import 'package:mubrambl/src/core/amount.dart';

import 'package:ribn/constants/rules.dart';
import 'package:ribn/models/ribn_address.dart';

class RibnNetwork {
  final int networkId;
  final String networkUrl;
  final List<RibnAddress> addresses;
  final BramblClient? client;
  final bool fetchingBalance;

  RibnNetwork({
    required this.networkId,
    required this.networkUrl,
    this.addresses = const [],
    this.client,
    required this.fetchingBalance,
  });

  factory RibnNetwork.initial({int? networkId, String? networkUrl}) {
    return RibnNetwork(
      networkId: networkId ?? Rules.valhallaId,
      networkUrl: networkUrl ?? Rules.networkUrls[Rules.valhallaId]!,
      client: Rules.getBramblCient(networkId ?? Rules.valhallaId),
      fetchingBalance: true,
    );
  }

  int getNextExternalAddressIndex() {
    return addresses.lastIndexWhere((addr) => addr.changeIndex == Rules.defaultChangeIndex) + 1;
  }

  int getNextInternalAddressIndex() {
    return addresses.lastIndexWhere((addr) => addr.changeIndex == Rules.internalIdx) + 1;
  }

  RibnAddress getAddrWithSufficientPolys(int target) {
    return addresses.firstWhere((addr) => addr.balance.polys.quantity >= target);
  }

  RibnAddress getAddrWithSufficientAssets(AssetAmount asset, int target) {
    return addresses.firstWhere(
      (addr) =>
          addr.balance.polys.quantity >= target &&
          addr.balance.assets!.any(
            (elem) => elem.assetCode == asset.assetCode && elem.quantity >= asset.quantity,
          ),
    );
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
    bool? fetchingBalance,
  }) {
    return RibnNetwork(
      networkId: networkId ?? this.networkId,
      networkUrl: networkUrl ?? this.networkUrl,
      addresses: addresses ?? this.addresses,
      client: client ?? this.client,
      fetchingBalance: fetchingBalance ?? this.fetchingBalance,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'networkId': networkId,
      'networkUrl': networkUrl,
      'addresses': addresses?.map((x) => x.toMap())?.toList(),
      'fetchingBalance': fetchingBalance,
    };
  }

  factory RibnNetwork.fromMap(Map<String, dynamic> map) {
    return RibnNetwork(
      networkId: map['networkId'],
      networkUrl: map['networkUrl'],
      addresses: List<RibnAddress>.from(map['addresses']?.map((x) => RibnAddress.fromMap(x))),
      fetchingBalance: map['fetchingBalance'] ?? true,
      client: Rules.getBramblCient(map['networkId']),
    );
  }

  String toJson() => json.encode(toMap());

  factory RibnNetwork.fromJson(String source) => RibnNetwork.fromMap(json.decode(source));

  @override
  String toString() {
    return 'RibnNetwork(networkId: $networkId, networkUrl: $networkUrl, addresses: $addresses, client: $client, fetchingBalance: $fetchingBalance)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RibnNetwork &&
        other.networkId == networkId &&
        other.networkUrl == networkUrl &&
        listEquals(other.addresses, addresses) &&
        other.client == client &&
        other.fetchingBalance == fetchingBalance;
  }

  @override
  int get hashCode {
    return networkId.hashCode ^
        networkUrl.hashCode ^
        addresses.hashCode ^
        client.hashCode ^
        fetchingBalance.hashCode;
  }
}
