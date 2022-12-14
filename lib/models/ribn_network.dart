import 'dart:convert';

import 'package:brambldart/brambldart.dart';
import 'package:flutter/foundation.dart';

import 'package:ribn/constants/network_utils.dart';
import 'package:ribn/constants/rules.dart';
import 'package:ribn/models/ribn_address.dart';

@immutable
class RibnNetwork {
  /// The name of this network.
  final String networkName;

  /// The id/prefix of this network.
  final int networkId;

  /// The vertx URL associated with this network.
  final String networkUrl;

  /// The list of addresses in the wallet associated with this network.
  final List<RibnAddress> addresses;

  /// The [BramblClient] that allows Ribn to send HTTP JSON-RPC requests to Bifrost.
  final BramblClient? client;

  /// A timestamp that indicates when this network was last selected/toggled in the app.
  final int lastCheckedTimestamp;

  const RibnNetwork({
    required this.networkName,
    required this.networkId,
    required this.networkUrl,
    required this.addresses,
    required this.client,
    this.lastCheckedTimestamp = -1,
  });

  factory RibnNetwork.initial({
    required int networkId,
    required String networkName,
  }) {
    return RibnNetwork(
      networkName: networkName,
      networkId: networkId,
      networkUrl: NetworkUtils.networkUrls[networkId]!,
      client: Rules.getBramblCient(networkId),
      addresses: List.unmodifiable(const []),
    );
  }

  /// Initializes [RibnNetwork] for [NetworkUtils.valhalla], [NetworkUtils.toplNet], and [NetworkUtils.private].
  static Map<String, RibnNetwork> initializeToplNetworks() {
    return {
      NetworkUtils.valhalla: RibnNetwork.initial(
        networkId: NetworkUtils.valhallaId,
        networkName: NetworkUtils.valhalla,
      ),
      NetworkUtils.toplNet: RibnNetwork.initial(
        networkId: NetworkUtils.toplNetId,
        networkName: NetworkUtils.toplNet,
      ),
      NetworkUtils.private: RibnNetwork.initial(
        networkId: NetworkUtils.privateId,
        networkName: NetworkUtils.private,
      ),
    };
  }

  /// Ribn only supports a single wallet address at this time.
  /// The wallet address is the first generated address.
  RibnAddress? get myWalletAddress {
    return addresses.isNotEmpty ? addresses.first : null;
  }

  int getNextExternalAddressIndex() {
    return addresses.lastIndexWhere(
          (addr) => addr.changeIndex == Rules.defaultChangeIndex,
        ) +
        1;
  }

  int getNextInternalAddressIndex() {
    return addresses
            .lastIndexWhere((addr) => addr.changeIndex == Rules.internalIdx) +
        1;
  }

  /// Returns a list of all the assets owned by [myWalletAddress]
  ///
  ///
  /// Iterates through [myWalletAddress.balance.assets], i.e. asset boxes,
  /// and compiles them into a list based on asset codes.
  List<AssetAmount> getAllAssetsInWallet() {
    final Map<String, AssetAmount> myAssets = {};
    for (AssetAmount asset in myWalletAddress?.balance.assets ?? []) {
      final num assetQuantity = asset.quantity;
      myAssets.update(
        asset.assetCode.serialize(),
        (AssetAmount currAsset) {
          return AssetAmount(
            quantity: currAsset.quantity + assetQuantity,
            assetCode: asset.assetCode,
          );
        },
        ifAbsent: () => asset,
      );
    }
    return myAssets.values.toList();
  }

  /// Returns the number of polys owned by this wallet, i.e. [myWalletAddress].
  num getPolysInWallet() {
    return myWalletAddress?.balance.polys.getInNanopoly ?? 0;
  }

  /// Returns the list of all assets issued/minted by this wallet.
  List<AssetAmount> getAssetsIssuedByWallet() {
    return getAllAssetsInWallet()
        .where(
          (AssetAmount asset) =>
              asset.assetCode.issuer.toBase58() ==
              myWalletAddress?.toplAddress.toBase58(),
        )
        .toList();
  }

  RibnNetwork copyWith({
    String? networkName,
    int? networkId,
    String? networkUrl,
    List<RibnAddress>? addresses,
    BramblClient? client,
    int? lastCheckedTimestamp,
  }) {
    return RibnNetwork(
      networkName: networkName ?? this.networkName,
      networkId: networkId ?? this.networkId,
      networkUrl: networkUrl ?? this.networkUrl,
      addresses: addresses ?? this.addresses,
      client: client ?? this.client,
      lastCheckedTimestamp: lastCheckedTimestamp ?? this.lastCheckedTimestamp,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'networkName': networkName,
      'networkId': networkId,
      'networkUrl': networkUrl,
      'addresses': addresses.map((RibnAddress x) => x.toMap()).toList(),
      'lastCheckedTimestamp': lastCheckedTimestamp,
    };
  }

  factory RibnNetwork.fromMap(Map<String, dynamic> map) {
    return RibnNetwork(
      networkName: map['networkName'] as String,
      networkId: map['networkId'] as int,
      networkUrl: map['networkUrl'] as String,
      addresses: List<RibnAddress>.from(
        (map['addresses'] as Iterable<dynamic>).map(
          (x) => RibnAddress.fromMap(x as Map<String, dynamic>),
        ),
      ),
      client: Rules.getBramblCient(map['networkId'] as int),
      lastCheckedTimestamp: map['lastCheckedTimestamp'] ?? -1,
    );
  }

  String toJson() => json.encode(toMap());

  factory RibnNetwork.fromJson(String source) =>
      RibnNetwork.fromMap(json.decode(source));

  @override
  String toString() {
    return 'RibnNetwork(networkName: $networkName, networkId: $networkId, networkUrl: $networkUrl, addresses: $addresses, client: $client, lastCheckedTimestamp: $lastCheckedTimestamp)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RibnNetwork &&
        other.networkName == networkName &&
        other.networkId == networkId &&
        other.networkUrl == networkUrl &&
        listEquals(other.addresses, addresses) &&
        other.client == client &&
        other.lastCheckedTimestamp == lastCheckedTimestamp;
  }

  @override
  int get hashCode {
    return networkName.hashCode ^
        networkId.hashCode ^
        networkUrl.hashCode ^
        addresses.hashCode ^
        client.hashCode ^
        lastCheckedTimestamp.hashCode;
  }
}
