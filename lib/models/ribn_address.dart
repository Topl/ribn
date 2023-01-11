// Dart imports:
import 'dart:convert';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:brambldart/brambldart.dart';

// Project imports:
import 'package:ribn/constants/rules.dart';

@immutable
class RibnAddress {
  /// Helpful representation of the address as a [ToplAddress].
  final ToplAddress toplAddress;

  /// The full HD key derivation path of this address.
  /// Follows the format: m / purpose' / coin_type' / account' / role / index
  final String keyPath;

  /// The address level index, i.e. last index in the hd path of this address.
  final int addressIndex;

  /// The account level index, i.e. second last index in the hd path of this address.
  final int accountIndex;

  /// The change level index, i.e. third last index in the hd path of this address.
  final int changeIndex;

  /// The [Balance] owned by this address.
  final Balance balance;

  /// The networkId that this address is associated with.
  final int networkId;

  const RibnAddress({
    required this.toplAddress,
    required this.addressIndex,
    this.accountIndex = Rules.defaultAccountIndex,
    this.changeIndex = Rules.defaultChangeIndex,
    required this.keyPath,
    required this.balance,
    required this.networkId,
  });

  RibnAddress copyWith({
    ToplAddress? toplAddress,
    String? keyPath,
    int? addressIndex,
    int? accountIndex,
    int? changeIndex,
    Balance? balance,
    int? networkId,
  }) {
    return RibnAddress(
      toplAddress: toplAddress ?? this.toplAddress,
      keyPath: keyPath ?? this.keyPath,
      addressIndex: addressIndex ?? this.addressIndex,
      accountIndex: accountIndex ?? this.accountIndex,
      changeIndex: changeIndex ?? this.changeIndex,
      balance: balance ?? this.balance,
      networkId: networkId ?? this.networkId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'address': toplAddress.toBase58(),
      'addressIndex': addressIndex,
      'accountIndex': accountIndex,
      'changeIndex': changeIndex,
      'keyPath': keyPath,
      'networkId': networkId,
    };
  }

  factory RibnAddress.fromMap(Map<String, dynamic> map) {
    return RibnAddress(
      toplAddress: ToplAddress.fromBase58(
        map['address'] as String,
        networkPrefix: map['networkId'] as int,
      ),
      networkId: map['networkId'] as int,
      addressIndex: map['addressIndex'] as int,
      accountIndex: map['accountIndex'] as int,
      changeIndex: map['changeIndex'] as int,
      keyPath: map['keyPath'] as String,
      balance: Rules.initBalance(map['address'] as String),
    );
  }

  String toJson() => json.encode(toMap());

  factory RibnAddress.fromJson(String source) => RibnAddress.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );

  @override
  String toString() {
    return 'RibnAddress(address: $toplAddress, addressIndex: $addressIndex, accountIndex: $accountIndex, changeIndex: $changeIndex, keyPath: $keyPath, balance: $balance, networkId: $networkId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RibnAddress &&
        other.toplAddress == toplAddress &&
        other.keyPath == keyPath &&
        other.addressIndex == addressIndex &&
        other.accountIndex == accountIndex &&
        other.changeIndex == changeIndex &&
        other.balance == balance &&
        other.networkId == networkId;
  }

  @override
  int get hashCode {
    return toplAddress.hashCode ^
        keyPath.hashCode ^
        addressIndex.hashCode ^
        accountIndex.hashCode ^
        changeIndex.hashCode ^
        balance.hashCode ^
        networkId.hashCode;
  }
}
