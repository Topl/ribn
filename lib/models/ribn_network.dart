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
      addresses: [],
    );
  }

  /// We are only supporting a single wallet address at this time.
  /// The wallet address is the first generated address.
  RibnAddress get myWalletAddress => addresses.first;

  int getNextExternalAddressIndex() {
    return addresses.lastIndexWhere((addr) => addr.changeIndex == Rules.defaultChangeIndex) + 1;
  }

  int getNextInternalAddressIndex() {
    return addresses.lastIndexWhere((addr) => addr.changeIndex == Rules.internalIdx) + 1;
  }

  /// Returns a list of all the assets owned by [myWalletAddress]
  ///
  ///
  /// Iterates through [myWalletAddress.balance.assets], i.e. asset boxes,
  /// and compiles them into a list based on asset codes.
  List<AssetAmount> getAllAssetsInWallet() {
    final Map<String, AssetAmount> myAssets = {};
    for (AssetAmount asset in myWalletAddress.balance.assets ?? []) {
      final num assetQuantity = asset.quantity;
      myAssets.update(asset.assetCode.serialize(), (AssetAmount currAsset) {
        return AssetAmount(quantity: currAsset.quantity + assetQuantity, assetCode: asset.assetCode);
      }, ifAbsent: () => asset);
    }
    return myAssets.values.toList();
  }

  /// Returns the number of polys owned by this wallet, i.e. [myWalletAddress].
  num getPolysInWallet() {
    return myWalletAddress.balance.polys.getInNanopoly;
  }

  /// Returns the list of all assets issued/minted by this wallet.
  List<AssetAmount> getAssetsIssuedByWallet() {
    return getAllAssetsInWallet()
        .where((AssetAmount asset) => asset.assetCode.issuer.toBase58() == myWalletAddress.address.toBase58())
        .toList();
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
