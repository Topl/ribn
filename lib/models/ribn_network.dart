import 'dart:convert';

import 'package:brambldart/brambldart.dart';
import 'package:flutter/foundation.dart';

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
      client: Rules.getBramblCient(networkId ?? Rules.valhallaId),
    );
  }

  int getNextExternalAddressIndex() {
    return addresses.lastIndexWhere((addr) => addr.changeIndex == Rules.defaultChangeIndex) + 1;
  }

  int getNextInternalAddressIndex() {
    return addresses.lastIndexWhere((addr) => addr.changeIndex == Rules.internalIdx) + 1;
  }

  /// Verifies the network connection status.
  /// @TODO Check if needed
  Future<bool> isConnected() async {
    try {
      final String currNetwork = await client!.getNetwork();
      switch (currNetwork) {
        case 'Mainnet':
          return networkId == Rules.toplnetId;
        case 'ValhallaTestnet':
          return networkId == Rules.valhallaId;
        case 'PrivateTestnet':
          return networkId == Rules.privateId;
        default:
          return false;
      }
    } catch (e) {
      return false;
    }
  }

  List<RibnAddress> getAddrsWithSufficientPolys(int target) {
    final List<RibnAddress> sortedAddrs = List.from(addresses)
      ..sort((a, b) => a.balance.polys.quantity.compareTo(b.balance.polys.quantity));
    num availableBalance = 0;
    final List<RibnAddress> selectedAddrs = [];
    for (int i = 0; i < sortedAddrs.length; i++) {
      if (sortedAddrs[i].balance.polys.quantity > 0) {
        selectedAddrs.add(sortedAddrs[i]);
        availableBalance += sortedAddrs[i].balance.polys.quantity;
      }
      if (availableBalance >= target) break;
    }
    return availableBalance >= target ? selectedAddrs : [];
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
      networkId: map['networkId'] as int,
      networkUrl: map['networkUrl'] as String,
      addresses: List<RibnAddress>.from(
        (map['addresses'] as Iterable<dynamic>).map(
          (x) => RibnAddress.fromMap(x as Map<String, dynamic>),
        ),
      ),
      client: Rules.getBramblCient(map['networkId'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory RibnNetwork.fromJson(String source) => RibnNetwork.fromMap(json.decode(source) as Map<String, dynamic>);

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
