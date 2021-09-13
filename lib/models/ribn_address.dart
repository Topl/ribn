// ignore_for_file: implementation_imports

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mubrambl/src/credentials/address.dart';
import 'package:ribn/constants/rules.dart';

@immutable
class RibnAddress {
  final ToplAddress address;
  final int addressIndex;
  final int accountIndex;
  final int changeIndex;
  final String keyPath;

  const RibnAddress({
    required this.address,
    required this.addressIndex,
    this.accountIndex = Rules.defaultAccountIndex,
    this.changeIndex = Rules.defaultChangeIndex,
    required this.keyPath,
  });

  RibnAddress copyWith({
    ToplAddress? address,
    int? addressIndex,
    int? accountIndex,
    int? changeIndex,
    String? keyPath,
  }) {
    return RibnAddress(
      address: address ?? this.address,
      addressIndex: addressIndex ?? this.addressIndex,
      accountIndex: accountIndex ?? this.accountIndex,
      changeIndex: changeIndex ?? this.changeIndex,
      keyPath: keyPath ?? this.keyPath,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'address': address.toBase58(),
      'addressIndex': addressIndex,
      'accountIndex': accountIndex,
      'changeIndex': changeIndex,
      'keyPath': keyPath,
    };
  }

  factory RibnAddress.fromMap(Map<String, dynamic> map) {
    return RibnAddress(
      address: ToplAddress.fromBase58(map['address']),
      addressIndex: map['addressIndex'],
      accountIndex: map['accountIndex'],
      changeIndex: map['changeIndex'],
      keyPath: map['keyPath'],
    );
  }

  String toJson() => json.encode(toMap());

  factory RibnAddress.fromJson(String source) => RibnAddress.fromMap(json.decode(source));

  @override
  String toString() {
    return 'RibnAddress(address: $address, addressIndex: $addressIndex, accountIndex: $accountIndex, changeIndex: $changeIndex, keyPath: $keyPath)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RibnAddress &&
        other.address == address &&
        other.addressIndex == addressIndex &&
        other.accountIndex == accountIndex &&
        other.changeIndex == changeIndex &&
        other.keyPath == keyPath;
  }

  @override
  int get hashCode {
    return address.hashCode ^
        addressIndex.hashCode ^
        accountIndex.hashCode ^
        changeIndex.hashCode ^
        keyPath.hashCode;
  }
}
