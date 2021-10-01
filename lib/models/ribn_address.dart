// ignore_for_file: implementation_imports

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mubrambl/src/credentials/address.dart';
import 'package:mubrambl/src/model/balances.dart';

import 'package:ribn/constants/rules.dart';

@immutable
class RibnAddress {
  final ToplAddress address;
  final int addressIndex;
  final int accountIndex;
  final int changeIndex;
  final String keyPath;
  final Balance balance;
  final int networkId;

  const RibnAddress({
    required this.address,
    required this.addressIndex,
    this.accountIndex = Rules.defaultAccountIndex,
    this.changeIndex = Rules.defaultChangeIndex,
    required this.keyPath,
    required this.balance,
    required this.networkId,
  });

  RibnAddress copyWith({
    ToplAddress? address,
    int? addressIndex,
    int? accountIndex,
    int? changeIndex,
    String? keyPath,
    Balance? balance,
    int? networkId,
  }) {
    return RibnAddress(
      address: address ?? this.address,
      addressIndex: addressIndex ?? this.addressIndex,
      accountIndex: accountIndex ?? this.accountIndex,
      changeIndex: changeIndex ?? this.changeIndex,
      keyPath: keyPath ?? this.keyPath,
      balance: balance ?? this.balance,
      networkId: networkId ?? this.networkId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'address': address.toBase58(),
      'addressIndex': addressIndex,
      'accountIndex': accountIndex,
      'changeIndex': changeIndex,
      'keyPath': keyPath,
      'networkId': networkId,
    };
  }

  factory RibnAddress.fromMap(Map<String, dynamic> map) {
    return RibnAddress(
      address: ToplAddress.fromBase58(
        map['address'],
        networkPrefix: map['networkId'],
      ),
      balance: Rules.initBalance(map['address']),
      addressIndex: map['addressIndex'],
      accountIndex: map['accountIndex'],
      changeIndex: map['changeIndex'],
      keyPath: map['keyPath'],
      networkId: map['networkId'],
    );
  }

  String toJson() => json.encode(toMap());

  factory RibnAddress.fromJson(String source) => RibnAddress.fromMap(json.decode(source));

  @override
  String toString() {
    return 'RibnAddress(address: $address, addressIndex: $addressIndex, accountIndex: $accountIndex, changeIndex: $changeIndex, keyPath: $keyPath, balance: $balance, networkId: $networkId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RibnAddress &&
        other.address == address &&
        other.addressIndex == addressIndex &&
        other.accountIndex == accountIndex &&
        other.changeIndex == changeIndex &&
        other.keyPath == keyPath &&
        other.balance == balance &&
        other.networkId == networkId;
  }

  @override
  int get hashCode {
    return address.hashCode ^
        addressIndex.hashCode ^
        accountIndex.hashCode ^
        changeIndex.hashCode ^
        keyPath.hashCode ^
        balance.hashCode ^
        networkId.hashCode;
  }
}
